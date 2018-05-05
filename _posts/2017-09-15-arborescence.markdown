---
layout: post
title:  "Arborescence des archives homogène ~/Documents/data"
date:   2017-09-15 08:34:50 +0100
author: Guillaume Pressiat
tags: pmeasyr
categories: data&nbsp;management
---

*"Une arborescence de travail commune pour envisager des programmes communs."*

<!--more-->


***L'idée de ce post est de proposer une arborescence d'archives pmsi commune aux différents utilisateurs de pmeasyr, qu'ils soient sous windows, mac ou linux. Une localisation des données (fichiers du pmsi) commune facilite grandement le partage de programmes : c'est un peu l'équivalent d'une arborescence commune en ce qui concerne les projets RStudio (mais les fichiers in/out étant souvent volumineux, il est préférable de ne pas les dupliquer dans chaque projet).***

***Autre avantage de cette approche, les données pmsi, assez sensibles de par leur contenu sont protégées par votre mot de passe dans votre session utilisateur.***


## Sous Unix

Chaque utilisateur dispose de son path `'~'`[^1], qui équivaut par exemple à : `'/home/gui/'`.

Une possibilité est de mettre les données dans `'~/Documents/data'`.

Exemple : 

{% highlight r %}
dir.create('~/Documents/data/mco')
{% endhighlight %}

Dossier dans lequel placer les archives in/out du mco.


## Sous Windows

Chaque utilisateur dispose de son répertoire, exemple `'C:/Users/gui/'`. Et souvent, sans l'utilisation de projets RStudio, les chemins d'accès aux données sont pénibles à configurer dans chaque programme.

Mais dans R, le symbole `'~'` utilisé sur windows dans un chemin d'accès aux fichiers renvoie au répertoire Documents de l'utilisateur : `C:/Users/gui/Documents/`.


{% highlight r %}
path.expand('~')
{% endhighlight %}

renvoie `'C:/Users/gui/Documents/'`.

Par conséquent sur Windows le répertoire à créer pour localiser les fichiers d'archives pmsi sera : `'C:/Users/gui/Documents/Documents/data'` :

{% highlight r %}
dir.create('~/Documents/data/mco', recursive = T)
{% endhighlight %}

## Déposer les archives et commencer un programme

Peu importe si vos collègues sont sur windows ou unix, vous pourrez alors partager vos scripts, si vos archives sont placées comme indiqué [ici](https://guillaumepressiat.github.io/pmeasyr/archives.html#arborescence-des-archives). 

Début du programme : 

{% highlight r %}
library(pmeasyr)
# noyau_skeleton()
noyau_pmeasyr(
  finess = '.........',
  annee  = ....,
  mois   = ..,
  path   = '~/Documents/data/mco'
) -> p
{% endhighlight %}

## Un répertoire pour une db


Ce choix d'arborescence des archives sera utilisé pour le prochain post qui concerne l'intégration des données pmsi avec pmeasyr dans une base de données (avec DBI, dbplyr et monetdblite).

{% highlight r %}
dir.create('~/Documents/data/__db')
{% endhighlight %}



<br>

------

[^1]: Le tilde ~ se produit sur un clavier pc avec les touches Alt Gr + é, et sur mac avec les touches alt + N.
