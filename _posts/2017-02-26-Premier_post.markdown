---
layout: post
title:  "Sujet introductif"
date:   2017-02-26 13:31:55 +0100
author: Guillaume Pressiat
tags: pmeasyr
categories: Présentation
---

Bienvenue, ce blog rassemble les informations autour du package R *pmeasyr*. 

- Le package est hébergé sur le [Github de l'Information Médicale AP-HP](https://github.com/IM-APHP/pmeasyr)
- Un [livret numérique](/pmeasyr) présente le package et son utilisation
- Ce livret est aussi disponible au [format pdf](/pmeasyr/pmeasyr-book.pdf)
- Le [manuel pdf]({% link /assets/files/pmeasyr.pdf %}) avec l'aide pour toutes les fonctions du package

<br>

----------
<br>


`pmeasyr` permet d'importer les données du PMSI dans R, il est alors possible de les analyser (en utilisant `dplyr` par exemple).

## Un exemple de traitement en MCO

{% highlight r %}
library(pmeasyr)
# Import des rsa, des passages um, des diagnostics associés et des actes
tables_rsa <- irsa(finess = '750712184', # Finess de l'établissement
                   annee  = 2016, # Année pmsi
                   mois   = 12, # Mois pmsi
                   path   = '~/Documents/data/mco', # Localisation du fichier .rsa
                   typi   = 4 # Type d'import, plusieurs possibles
)

# Filtrer sur les séjours (table rsa) avec : 
# - un GHM chirurgical et
# - un diagnostic principal "fracture du fémur" (S720).
library(dplyr)
tables_rsa$rsa %>% filter(RSATYPE == 'C', DP == 'S720')

# Filtrer sur les actes (table actes) avec un acte regroupé acte de chirurgie (activité ccam 1)
library(dplyr)
tables_rsa$actes %>% filter(ACT == '1')

# Séjours passés en Soins intensifs hémato (table unité médicale, type d'autorisation 16)
library(dplyr)
tables_rsa$rsa_um %>% filter(grepl('16', TYPAUT1))
{% endhighlight %}


Pour plus d'exemples sur le MCO et sur les autres champs[^1] SSR, HAD, PSY et RSF, consulter le [livret en ligne](/pmeasyr/).
<br>

------

[^1]: Champs PMSI :
	* MCO : Médecine Chirurgie Obstétrique
	* SSR : Soins de Suite et de Réadaptation
	* HAD : Hospitalisation À Domicile
	* PSY : Psychiatrie
	* RSF : Résumés Standardisés de Financement (Rafael)


<br>
