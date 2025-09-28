---
layout: post
title:  "Mise à jour de pmsi-io et information concernant le nommage des fichiers par Druides"
date:   2025-09-28 14:05:50 +0100
author: Guillaume Pressiat
tags: pmeasyr pypmsi rust
categories: Mise&nbsp;à&nbsp;jour
---


*Utiliser les outils sur les données M01 à M12 2025, en attendant 2026.*

Le package pmeasyr, pypmsi, pmsi-io permettent d'intégrer les données 2025 M01 à M12, il faut pour cela les mettre à jour.

<!--more-->


## pmsi-io / pmsi-clio

voir sur cette page.

[https://github.com/GuillaumePressiat/pmsi-io](https://github.com/GuillaumePressiat/pmsi-io)

**Version 0.1.10**

### pmsi-io

<center>
<a href = "" target = "_blank">
<img src="/images/apercu-pmsi-io.png" width = "100%"/>
</a>
</center>

### pmsi-clio

<center>
<a href = "" target = "_blank">
<img src="/images/apercu-pmsi-clio.png" width = "100%"/>
</a>
</center>


## Modifications à venir / nommage des fichiers PMSI avec Druides

Des modifications assez importantes suivront d'ici la fin de l'année dans les trois outils (pmeasyr, pypmsi, pmsi-io/pmsi-clio).

En effet, la charte de nommage des fichiers PMSI évolue légèrement avec Druides sur les 4 champs (fichiers texte, archives zip) et nécessite désormais de fastidieuses actions manuelles pour continuer à utiliser les programmes habituels de lecture des données (avec pmeasyr notamment). 

En détail, 

- pour les fichiers de données, ces changements vont de l'extension même des fichiers au formattage du mois sur 1 ou 2 caractères (01, 02, 09, etc. ou 1, 2, 9, etc.).
- pour les archives, le nom des archives zip contient désormais le nom du champ PMSI, hormis pour le MCO jusqu'à M07 2025 qui jusque-là gardait le nommage des in/out historique.

L'idée est d'attendre que tous ces changements se sédimentent avant d'acter une stratégie définitive et homogène pour les différents outils.

