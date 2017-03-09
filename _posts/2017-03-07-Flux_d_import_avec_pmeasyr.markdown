---
layout: post
title:  "Flux d'import avec pmeasyr et %>%"
date:   2017-03-07 08:10:55 +0100
author: Guillaume Pressiat
tags: pmeasyr magrittr
---

Ce post correspond au contenu de la [nouvelle vignette du package](http://www.github.com/IM-APHP/pmeasyr/tree/master/vignettes/vignette2.Rmd).

La syntaxe initiée dans le [post précédent]({% post_url 2017-02-28-do_call_pmeasyr %}) permet de ne préciser qu'une fois les paramètres (finess, annee, mois, path). Le package intègre désormais cette syntaxe[^1], c'est ce qui est présenté ici. 


{% highlight r %}
library(pmeasyr)
library(dplyr)
{% endhighlight %}

## 1 - Définir un noyau de paramètres


{% highlight r %}
p <- noyau_pmeasyr(
        finess   = '750100042',
        annee    = 2015,
        mois     = 12,
        path     = '~/Documents/data/mco',
        progress = F)
{% endhighlight %}

On précise avec `progress = F` le fait que l'on ne veut pas de barre de progression lors de la lecture des fichiers.

En partant de ces paramètres à gauche et en écrivant les appels de fonctions à droite, avec `%>%` et les fonctions de *pmeasyr*, on rend le script plus lisible, et on profite du côté "humain" de la programmation `%>%`.

## 2 - Dézipper

Par défaut la fonction `adezip()` dézippe la totalité des fichiers de l'archive PMSI, on pourra également effacer tous les fichiers avec `adelete()`.

{% highlight r %}
# Tout dézipper
# out
p %>% adezip(type = "out")
# in
p %>% adezip(type = "in")
{% endhighlight %}


## 3 - Importer

### Syntaxe explicite

On importe toutes les tables du MCO, la syntaxe est plus concise et va de gauche à droite : 

{% highlight r %}

# out
p %>% irsa()     -> rsa
p %>% iano_mco() -> ano_out
p %>% iium()     -> ium
p %>% idiap()    -> diap_out
p %>% imed_mco() -> med_out
p %>% idmi_mco() -> dmi_out
p %>% ipo()      -> po_out
p %>% ileg_mco() -> leg
p %>% itra()     -> tra

# rsa type 6 : 
p %>% irsa(typi = 6) -> rsa
# rsa d'une autre année :
p %>% irsa(annee = 2016) -> rsa
# rsa d'une autre année, lire les dix premiers rsa :
p %>% irsa(annee = 2016, n_max = 10) -> rsa

# in
p %>% irum()                    -> rum
p %>% iano_mco(typano  = "in")  -> ano_in
p %>% imed_mco(typmed  = "in")  -> med_in
p %>% idmi_mco(typdmi  = "in")  -> dmi_in
p %>% idiap(typdiap = "in")     -> diap_in
p %>% ipo(typpo   = "in")       -> po_in
{% endhighlight %}

### Importer plusieurs années avec une boucle

On dézippe et on importe les rsa de 2011 à 2015.
Les rsa seront dans l'environnement R avec comme nom : 
  
```
rsa_2011  rsa_2012  rsa_2013  rsa_2014  rsa_2015
```

{% highlight r %}
p <- noyau_pmeasyr(
  finess = '750100042',
  mois   = 12,
  path = "~/Documents/data/mco",
  progress = F
)

for (i in 2011:2015){
  p %>% adezip(annee = i, type = "out", liste = "rsa")
  p %>% irsa(annee = i) -> temp
  assign(paste("rsa", i, sep = "_"), temp)
}
{% endhighlight %}

On peut aussi envisager un import mois par mois si besoin, ou boucler sur une liste de finess (entités géographiques).

### Appel de fonctions

Pour l'exemple, on utilise ci-dessous `sapply()` à la liste des fonctions MCO *out*, en appelant toutes les fonctions, on crée ainsi un objet contenant toutes les tables du MCO *out*. 

{% highlight r %}
p <- noyau_pmeasyr(
        finess   = '750100042',
        annee    = 2015,
        mois     = 12,
        path     = '~/Documents/data/mco',
        progress = F)

# On liste les fonctions MCO du package :
fout <- c('irsa', 'iano_mco', 'iium', 'idiap', 'imed_mco', 'idmi_mco', 'ipo', 'ileg_mco', 'itra')

sapply(fout, function(f)get(f)(p)) -> liste_tables_mco_out
# Les tables ont le noms des fonctions : 
names(liste_tables_mco_out)
{% endhighlight %}

```
irsa iano_mco iium idiap imed_mco idmi_mco ipo ileg_mco itra
```

{% highlight r %}
# enlever les i des noms des tables
names(liste_tables_mco_out) <- substr(names(liste_tables_mco_out),2, nchar(names(liste_tables_mco_out)))
{% endhighlight %}

```
rsa ano_mco ium diap med_mco dmi_mco po leg_mco tra
```

## 4 - Sauvegarde (~ library Rds)

On sauvegarde cet objet R, contenant toutes les tables du *out* MCO dans un fichier *.rds* nommé `750100042.2015.12.out.rds`.

{% highlight r %}
# Coller des chaines de caracteres façon pipe
`%+%` <- function(x,y){paste0(x,y)}

dir.create(p$path %+% '/tables')
{% endhighlight %}

Le répertoire suivant est créé : 
```
'~/Documents/data/mco/tables/'
```

{% highlight r %}
nom <- p$finess %+% '.' %+% p$annee %+% '.' %+% p$mois %+% '.' %+% 'out' %+% '.' %+% 'rds'
saveRDS(liste_tables_mco_out, p$path %+% '/tables/' %+% nom)
{% endhighlight %}
Le fichier rds se nomme : 
```
750100042.2015.12.out.rds
```

## 5 - Effacer

On a importé toutes les données, on peut effacer les fichiers dézippés qui prennent de la place inutilement sur le disque.

{% highlight r %}
# Tout effacer sauf les zip : 
p %>%  adelete()
{% endhighlight %}

## 6 - Relire les tables sauvegardées en rds 

Avec le noyau de paramètres `p` défini tout en haut de cette page, on a les éléments nécessaires pour reconstruire le nom du fichier&thinsp;: `750100042.2015.12.out.rds` : 
{% highlight r %}
# Coller des chaines de caracteres façon pipe
`%+%` <- function(x,y){paste0(x,y)}

# Le fichier se nomme : 750100042.2015.12.out.rds
nom <- p$finess %+% '.' %+% p$annee %+% '.' %+% p$mois %+% '.' %+% 'out' %+% '.' %+% 'rds'
readRDS(p$path %+% '/tables/' %+% nom) -> mydata

View(mydata$rsa$rsa)
View(mydata$rsa$actes)

View(mydata$leg_mco)
{% endhighlight %}

Les données sont de nouveau dans l'environnement R.

----
[^1]: La syntaxe standard `f(finess, annee, mois, path)` est toujours valide

