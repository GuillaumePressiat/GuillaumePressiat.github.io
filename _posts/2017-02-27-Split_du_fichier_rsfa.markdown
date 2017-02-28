---
layout: post
title:  "Split du fichier rsfa (rafael) avec python et import dans R"
date:   2017-02-27 13:40:55 +0100
author: Guillaume Pressiat
---


Le fichier `rsfa` peut être volumineux car il contient tous les types de rafael (débuts de factures, actes externes, ATU, consultations, ...). Or il est rare d'avoir à utiliser tous les types de rafael en même temps dans un seul projet.

Plutôt que de tout importer dans R et donc charger trop de données (c.-à.-d. remplir la mémoire vive inutilement), on peut :

- spécifier à *pmeasyr* que l'on ne souhaite pas garder tous les types de rsfa en mémoire dans R
- diviser le fichier d'origine `rsfa` en plusieurs fichiers selon leur type avec python

[Un notebook en ligne]({% link /assets/files/split_rsfa.nb.html %}) présente ces deux solutions.
