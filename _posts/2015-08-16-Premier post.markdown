---
layout: post
title:  "Sujet introductif"
date:   2017-02-26 13:31:55 +0100
author: Guillaume Pressiat
---

Bienvenue, ce blog rassemble les informations autour du package R *pmeasyr*. 

- Le package est hébergé sur le [Github de l'Information Médicale AP-HP](https://github.com/IM-APHP/pmeasyr).
- Un livret numérique présentant le package et son utilisation est [disponible](/pmeasyr).

  
<br>

----------
<br>


Ce package permet d'importer et d'analyser (avec `dplyr` par exemple) les données du PMSI dans R, exemples en MCO : 


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
