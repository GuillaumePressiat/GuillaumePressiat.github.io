---
layout: post
title:  "Alléger les scripts utilisant pmeasyr avec do.call"
date:   2017-02-28 13:40:55 +0100
author: Guillaume Pressiat
---


### Quatre paramètres

Les fonctions de dézippage et d'import de *pmeasyr* ont en commun quatre paramètres :

- le finess du fichier
- l'année pmsi
- le mois pmsi
- le path, repértoire où se trouve le fichier


Appeler ces fonctions amène à répéter souvent ces quatre paramètres, exemple : 


{% highlight r %}
library(pmeasyr)

# Dézipper
adezip(finess = '750712184', 
       annee  = 2015, 
       mois   = 12, 
       path   = '~/Documents/data/mco/',
       type   = "out", 
       liste  = c("rsa", "ano", "tra"))

# Table ano
iano_mco(finess = '750712184', 
         annee  = 2015, 
         mois   = 12, 
         path   = '~/Documents/data/mco/') -> ano

# Tables rsa
irsa(finess = '750712184', 
     annee  = 2015, 
     mois   = 12, 
     path   = '~/Documents/data/mco/', 
     typi   = 4) -> rsa

# Table tra
itra(finess = '750712184', 
     annee  = 2015, 
     mois   = 12, 
     path   = '~/Documents/data/mco/') -> tra
{% endhighlight %}


La syntaxe est répétitive.

### Un noyau de paramètres

De manière alternative, pour alléger les scripts, on peut spécifier ce "noyau de paramètres" une seule fois en début de programme, et ensuite appeler les fonctions avec `do.call()` : 

{% highlight r %}
library(pmeasyr)

# Noyau de paramètres
parametr_i <- list(finess = '750712184', 
                   annee = 2015, 
                   mois = 12, 
                   path   = '~/Documents/data/mco/')

# Dézipper
do.call(adezip, c(parametr_i, 
                  type = "out", 
                  liste = list(c("rsa", "ano", "tra"))))

# Table ano
do.call(iano_mco, parametr_i) -> ano
# Tables rsa
do.call(irsa, c(parametr_i, typi = 4)) -> rsa
# Table tra
do.call(itra, parametr_i) -> tra
{% endhighlight %}


Cette syntaxe allégée présente l'avantage de concentrer les paramètres comme la période PMSI (année, mois) et le finess en un seul point du script, mais aussi en un seul objet.

### Centraliser les paramètres

Pour refaire tourner un programme sur 2016 et / ou sur un autre finess, il suffira de changer ces paramètres dans `parametr_i`; bien que ce ne soit pas la seule solution[^1].

----

[^1]: il est aussi envisageable de spécifier en début de programme les paramètres `an = 2015`, `f = '750712184'` et appeler les fonctions avec `an` et `f` comme paramètres. Pour changer l'année ou le finess en début de script, le résultat est le même.
