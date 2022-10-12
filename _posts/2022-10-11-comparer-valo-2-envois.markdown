---
layout: post
title: "Comprendre l'évolution de valorisation e-PMSI entre deux envois MCO <em>rsa</em> avec R"
date: 2022-10-11 09:05:50 +0100
author: Guillaume Pressiat
tags: pmeasyr
categories: Programmation
comments: true
---

<style>
table, th {
  border: 1px solid grey;
  color: cornflowerblue;
}
</style>


Dans une année de collecte des informations du PMSI dans un hôpital,  
il y a des périodes où l'on cherche particulièrement à concentrer l'optimisation des envois.   
  
Lorsque ces efforts semblent porter leurs *fruits*, il peut être intéréssant de détailler : 
  
  - sur quels types de séjours
  - sur quelles rubriques e-PMSI 
  - pour quelles raisons (quelles actions) 

la revalorisation T2A s'opère.   

Ce post présente une manière de le faire concordante avec les tableaux SV et RAV d'ePMSI. 
  Il utilise le package pmeasyr et dplyr.


<!--more-->

## Contexte

Les évolutions de valorisation peuvent être la conséquence d'actions de différents acteurs : 

-  GHM : codage CMD type GHM + sévérités + actes
-  Suppléments
-  Nouveaux séjours
-  Séjours supprimés (ou « disparus »)
-  Evolutions de la ligne vid-hosp

Valoriser le travail effectué une fois l'envoi réalisé n'est pas toujours facile à faire car les actions ont été diverses et étalées sur de nombreux secteurs. Savoir valoriser les efforts effectués par les différents acteurs peut amener de la reconnaissance.

Parfois, des séjours peuvent "disparaître" de l'envoi ou de nombreux séjours devenir non facturables ; il est alors précieux de pouvoir les identifier rapidement pour cibler le problème et viser concrêtement à sa résolution sur des exemples précis (rss, nas/iep).

Ce post présente une manière de le faire cohérente avec les tableaux "SV - Séjours valorisés" et "RAV - Récapitulatif Activité Valorisation" d'ePMSI en termes de typologies et de montants.  


## Emplacement des archives *out*

On place les archives PMSI des deux envois v1 et v2 dans deux répertoires proches :

```
~/Documents/data/tests/v1
~/Documents/data/tests/v2
```  

Ensuite on peut dézipper les fichiers ainsi :

{% highlight r %}
library(pmeasyr)
library(dplyr)

noyau_pmeasyr(
  finess = '123456789',
  annee  = 2022,
  mois   = 8,
  path   = '~/Documents/data/tests/v1'
) -> p1

noyau_pmeasyr(
  finess = '123456789',
  annee  = 2022,
  mois   = 8,
  path   = '~/Documents/data/tests/v2'
) -> p2

adezip(p1, type = "out")
adezip(p2, type = "out")
{% endhighlight %}


## Valorisation T2A des deux envois 


On utilise la fonction `map` pour appliquer la valorisation aux deux archives out.

Le code utilise ici de nombreuses fonctions du package pmeasyr et les tables de tarifs GHS et suppléments présentes dans le package nomensland.

{% highlight r %}
rsa_valo_compile <- purrr::map(list(p1, p2),
                               function(p){
                                 p$tolower_names <- TRUE
                                 vrsa <- vvr_rsa(p)
                                 vano <- vvr_ano_mco(p)
                                 library(nomensland)
                                 tarifs_ghs <- dplyr::distinct(get_table('tarifs_mco_ghs'), 
                                                               ghs, anseqta, .keep_all = TRUE)
                                 
                                 tarifs_supp <- get_table('tarifs_mco_supplements') %>% 
                                 mutate_if(is.numeric, tidyr::replace_na, 0) %>%
                                   select(-cgeo)
                                 
                                 resu <- vvr_mco(
                                   vvr_ghs_supp(rsa = vrsa,
                                                tarifs = tarifs_ghs,
                                                supplements =  tarifs_supp,
                                                ano = vano,
                                                porg = ipo(p),
                                                diap = idiap(p),
                                                pie = ipie(p),
                                                mo = imed_mco(p),
                                                full = FALSE,
                                                cgeo = 1L,
                                                # prudent = 1,
                                                prudent = 0.993,
                                                bee = FALSE),
                                   vvr_mco_sv(vrsa, vano, ipo(p))
                                 ) %>% inner_tra(itra(p)) %>%
                                   mutate(ansor = as.character(p$annee))
                                 resu %>% select(-nohop) %>%
                                   mutate(envoi = basename(p$path)) %>%
                                   left_join(vrsa %>% select(cle_rsa, ghm))
                               }
)
{% endhighlight %}


## Reproduire les tableaux SV et RAV d'ePMSI


### Dans tous les tableaux, tous les montants et volumes sont mis à zéro

Par exemple sur l'envoi v1

**Tableau RAV**

{% highlight r %}
epmsi_mco_rav(rsa_valo_compile[[1]]) %>% 
  knitr::kable()
{% endhighlight %}

| ordre_epmsi|lib_valo                                             |var          |v                |
|-----------:|:----------------------------------------------------|:------------|:----------------|
|           1|Valorisation des GHS de base                         |rec_base     |0              € |
|           2|Valorisation extrême bas (à déduire)                 |rec_exb      |0              € |
|           5|Valorisation journées extrême haut                   |rec_exh      |0              € |
|           6|Valorisation actes GHS 9615 en Hospit.               |rec_aph      |0              € |
|           8|Valorisation suppléments antepartum                  |rec_ant      |0              € |
|           9|Valorisation actes RDTH en Hospit.                   |rec_rdt_tot  |0              € |
|          10|Valorisation suppléments de réanimation              |rec_rea      |0              € |
|          11|Valorisation suppléments de réa pédiatrique          |rec_rep      |0              € |
|          12|Valorisation suppléments de néonat sans SI           |rec_nn1      |0              € |
|          13|Valorisation suppléments de néonat avec SI           |rec_nn2      |0              € |
|          14|Valorisation suppléments de réanimation néonat       |rec_nn3      |0              € |
|          15|Valorisation prélévements d organe                   |rec_po_tot   |0              € |
|          16|Valorisation des actes de caissons hyperbares en sus |rec_caishyp  |0              € |
|          17|Valorisation suppléments de dialyse                  |rec_dialhosp |0              € |
|          20|Valorisation suppléments de surveillance continue    |rec_src      |0              € |
|          21|Valorisation suppléments de soins intensifs          |rec_stf      |0              € |
|          NA|Total valorisation 100% T2A                          |rec_totale   |0              € |

  
  
<br>

**Tableau SV**

{% highlight r %}
 epmsi_mco_sv(rsa_valo_compile[[1]]) %>% 
 knitr::kable()
{% endhighlight %}

| type_fin|     n|          rec|%       |lib_type                                                 |
|--------:|-----:|------------:|:-------|:--------------------------------------------------------|
|        0| 0    |            0|     %  |Séjours valorisés                                        |
|        1| 0    |            0|     %  |Séjours en CM 90                                         |
|        2| 0    |            0|     %  |Séjours en prestation inter-établissement                |
|        3| 0    |            0|     %  |Séjours en GHS 9999                                      |
|        4| 0    |            0|     %  |Séjours avec pb de chainage (hors NN, rdth et PO)        |
|        5| 0    |            0|     %  |Séjours avec pb de codage des variables bloquantes       |
|        6| 0    |            0|     %  |Séjours en attente de décision sur les droits du patient |
|        7| 0    |            0|     %  |Séjours non facturable à l'AM hors PO                    |

  
<br>


## Comparaison des deux envois rss par rss

{% highlight r %}
rsa_v1 <- rsa_valo_compile[[1]] %>%
  select(norss, type_fin, typvidhosp, rec_totale, envoi, ghm) %>%
  left_join(vvr_libelles_valo('lib_type_sej'))

rsa_v2 <- rsa_valo_compile[[2]] %>%
  select(norss, type_fin, typvidhosp, rec_totale, envoi, ghm) %>%
  left_join(vvr_libelles_valo('lib_type_sej'))
{% endhighlight %}

{% highlight r %}
rsa_v1 %>%
  full_join(rsa_v2, by = c('norss'), suffix = c('_v1', '_v2')) %>%
  mutate(delta_evol = case_when(
    is.na(type_fin_v1) & type_fin_v2 != "0" ~ 0,
    is.na(type_fin_v1) & type_fin_v2 == "0" ~ rec_totale_v2,
    is.na(type_fin_v2) & type_fin_v1 != "0" ~ 0,
    is.na(type_fin_v2) & type_fin_v1 == "0" ~ -rec_totale_v1,
    type_fin_v1 == "0" & type_fin_v2 != "0" ~ -rec_totale_v1,
    type_fin_v1 != "0" & type_fin_v2 == "0" ~ rec_totale_v2,
    type_fin_v1 != "0" & type_fin_v2 != "0" ~ 0,
    type_fin_v1 == "0" & type_fin_v2 == "0" ~ rec_totale_v2 - rec_totale_v1,
    TRUE ~ 0
  )) -> comparaisons
{% endhighlight %}

{% highlight r %}
comparaisons %>%
  group_by(lib_type_v1, lib_type_v2) %>%
  summarise(n = n(),
            valo_v1 = sum(rec_totale_v1, na.rm = TRUE),
            valo_v2 = sum(rec_totale_v2, na.rm = TRUE),
            evol = sum(delta_evol)) %>%
  ungroup %>%
  mutate_if(is.character, tidyr::replace_na, "RSA absent") %>%
  mutate_if(is.numeric, function(x)0) %>% knitr::kable()
{% endhighlight %}

<br>

Quelques exemples de lignes :

La colonne évol donnera la valorisation correspondante au delta (avec le bon signe) entre les deux envois (les évolutions vont dans les deux sens, valo_v1 et valo_v2 étant les valeurs 100% T2A).


lib_type_v1 et lib_type_v2 seront ici les rubriques du tableau SV des deux envois PMSI réalisés. 
  Lorsqu'un séjour change de rubrique ou que la valorisation change de montant il s'est passé quelque chose dans les données soit DIM (RSS) soit facturation (ano-hosp).

<br>

|lib_type_v1                                              |lib_type_v2                                              |  n| valo_v1| valo_v2| evol|
|:--------------------------------------------------------|:--------------------------------------------------------|--:|-------:|-------:|----:|
|Séjours avec pb de chainage (hors NN, rdth et PO)        |Séjours avec pb de chainage (hors NN, rdth et PO)        |  0|       0|       0|    0|
|Séjours avec pb de chainage (hors NN, rdth et PO)        |Séjours non facturable à l'AM hors PO                    |  0|       0|       0|    0|
|Séjours avec pb de chainage (hors NN, rdth et PO)        |RSA absent                                               |  0|       0|       0|    0|
|Séjours en CM 90                                         |Séjours avec pb de chainage (hors NN, rdth et PO)        |  0|       0|       0|    0|
|Séjours en CM 90                                         |Séjours en CM 90                                         |  0|       0|       0|    0|
|Séjours en CM 90                                         |Séjours en GHS 9999                                      |  0|       0|       0|    0|
|Séjours en CM 90                                         |Séjours valorisés                                        |  0|       0|       0|    0|
|Séjours en CM 90                                         |RSA absent                                               |  0|       0|       0|    0|
|Séjours en GHS 9999                                      |Séjours en CM 90                                         |  0|       0|       0|    0|
|Séjours en GHS 9999                                      |Séjours en GHS 9999                                      |  0|       0|       0|    0|
|Séjours en GHS 9999                                      |Séjours valorisés                                        |  0|       0|       0|    0|
|Séjours en prestation inter-établissement                |Séjours en prestation inter-établissement                |  0|       0|       0|    0|
|Séjours non facturable à l'AM hors PO                    |Séjours non facturable à l'AM hors PO                    |  0|       0|       0|    0|
|Séjours valorisés                                        |Séjours avec pb de chainage (hors NN, rdth et PO)        |  0|       0|       0|    0|
|Séjours valorisés                                        |Séjours en CM 90                                         |  0|       0|       0|    0|
|Séjours valorisés                                        |Séjours valorisés                                        |  0|       0|       0|    0|
|Séjours valorisés                                        |RSA absent                                               |  0|       0|       0|    0|
|RSA absent                                               |Séjours non facturable à l'AM hors PO                    |  0|       0|       0|    0|
|RSA absent                                               |Séjours valorisés                                        |  0|       0|       0|    0|

<br>


On peut ensuite trouver les séjours correspondants et les décrire avec dplyr et ggplot (non détaillé ici).

**Quelques exemples**

{% highlight r %}
# Nouveaux séjours ? (ou séjours disparus à l'inverse)
comparaisons %>%
  filter(is.na(lib_type_v1), lib_type_v2 == "Séjours valorisés") %>%
  group_by(ghm_v2) %>%
  summarise(n = n(),
            evol = sum(delta_evol))

# type GHM et CM(D) identique mais sévérités différentes ?
comparaisons %>%
  filter(substr(ghm_v1,1,3) == substr(ghm_v2,1,3), ghm_v1 != ghm_v2) %>%
  group_by(sev_v1 = substr(ghm_v1,6,6),sev_v2 =  substr(ghm_v2,6,6)) %>%
  summarise(n = n(),
            evol = sum(delta_evol))

# type GHM et CM(D) différents ?
comparaisons %>%
  filter(substr(ghm_v1,1,3) != substr(ghm_v2,1,3)) %>%
  group_by(rsatype_v1 = substr(ghm_v1,3,3), rsatype_v2 =  substr(ghm_v2,3,3)) %>%
  summarise(n = n(),
            evol = sum(delta_evol))
{% endhighlight %}


La même chose est faisable sur les fichcomp.

