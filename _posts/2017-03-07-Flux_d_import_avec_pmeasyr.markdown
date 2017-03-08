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

On crée une fonction qui permet d'ajouter de nouveaux paramètres à l'objet `p`, par exemple :

{% highlight r %}
# Ajouter des paramètres au noyau de parametres façon pipe
`%P%` <- function(p, x){c(p,x)}
p %P% c(type = "out")
# équivaut à : 
c(p, type = "out")
{% endhighlight %}

Par défaut la fonction `adezip()` dézippe la totalité des fichiers de l'archive PMSI, on pourra également effacer tous les fichiers avec `adelete()`.

{% highlight r %}
# Tout dézipper
# out
p %P% c(type = "out") %>% adezip()
# in
p %P% c(type = "in" ) %>% adezip()
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

# in
p %>% irum()                            -> rum
p %P% c(typano  = "in") %>% iano_mco()  -> ano_in
p %P% c(typmed  = "in") %>% imed_mco()  -> med_in
p %P% c(typdmi  = "in") %>% idmi_mco()  -> dmi_in
p %P% c(typdiap = "in") %>% idiap()     -> diap_in
p %P% c(typpo   = "in") %>% ipo()       -> po_in
{% endhighlight %}

### Appel de fonctions (implicite)

Pour l'exemple, on utilise ci-dessous `sapply()` à la liste des fonctions MCO *out*, en appelant toutes les fonctions, on crée ainsi un objet contenant toutes les tables du MCO *out*. 

{% highlight r %}
# En plus dense : 
# On liste les fonctions MCO du package :
fout <- c('irsa', 'iano_mco', 'iium', 'idiap', 'imed_mco', 'idmi_mco', 'ipo', 'ileg_mco', 'itra')

sapply(fout, function(x)get(x)(p)) -> liste_tables_mco_out
names(liste_tables_mco_out)
# enlever les i des noms des tables
names(liste_tables_mco_out) <- substr(names(liste_tables_mco_out),2, nchar(names(liste_tables_mco_out)))
{% endhighlight %}

## 4 - Sauvegarde (~ library Rds)

On sauvegarde cet objet R, contenant toutes les tables du *out* MCO dans un fichier *.rds* nommé `750100042.2015.12.out.rds`.

{% highlight r %}
# Coller des chaines de caracteres faon pipe
`%+%` <- function(x,y){paste0(x,y)}

dir.create('~/Documents/data/mco/tables')
nom <- p$finess %+% '.' %+% p$annee %+% '.' %+% p$mois %+% '.' %+% 'out' %+% '.' %+% 'rds'
saveRDS(liste_tables_mco_out, '~/Documents/data/mco/tables/' %+% nom)
{% endhighlight %}

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

