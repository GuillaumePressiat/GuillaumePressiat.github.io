---
layout: post
title: "Découverte de delta lake avec pola.rs et pypmsi"
date: 2024-09-21 10:00:00 +0100
author: Guillaume Pressiat
tags: pmsi pypmsi
categories: Programmation
comments: true
---

*Take delta lake for a spin*

<!--more-->


## Introduction

L'an dernier lors de la montée en charge de pola.rs, j'ai voulu tester l'écriture de fichiers parquet avec pola.rs sous le framework delta lake.

Delta Lake est un framework open source qui permet d'ajouter une couche ACID[^1] au stockage de données type lakehouse, c'est-à-dire que quand on souhaite mettre à jour, supprimer, ajouter des données, l'ensemble des opérations sont historisées. De cette manière il est sécurisant d'opérer des actions d'administration sur les données.

Dans cet article, je pointe vers le code que j'ai écrit pour intégrer les données PMSI rsa sous forme de delta lake. Ce code a été initialement écrit l'été dernier en 2023 et je le place ici principalement pour ne pas le perdre. Je me dis aussi que cela peut intéresser d'autres personnes d'où ce billet.

## Version des packages utilisés

À l'heure actuelle, tout l'écosystème pola.rs / delta lake n'est pas encore parfaitement stabilisé. Sans fichier requirements mais juste en listing voici les packages utilisés :

```sh
polars==1.6.0
pypmsi=0.2.6
delta==0.4.2
delta-spark==2.4.0
deltalake==0.19.2
pyspark==3.4.3
pandas==2.0.2
```

## Notebook 

Autonome en termes de présentation du code le notebook qui initie le delta lake permet de : 

- définir un schéma homogène de données PMSI d'un point de vue longitudinal (2013 -- 2023) au préalable de l'insertion des données, un pré-requis de deltalake
- charger les données RSA, ACTES, DIAGS et UM pour toutes les années avec l'ajout des identifiants NAS/IEP et NORSS
- tester les fonctionalités de déletion de données (pyspark requis pour le moment) : `DELETE FROM ... WHERE ANSOR = '2024'`
- tester la rapidité des requêtes et dénombrements au travers de la syntaxe pola.rs
- un ensemble de fonctions est défini dans le notebook pour réaliser ces différentes actions 
- un sucre syntaxique appelé via une fonction `remote_table` est bricolé pour faciliter l'interrogation des données : `rsa@actes` permet de requêter la table actes des RSA, dans l'idée de proposer une organisation hiérarchique des données PMSI dans le lac/delta lac.  

Ce notebook est accessible ici : 

<a href="https://github.com/GuillaumePressiat/pmsi_rsa_for_deltalake" target="_blank">https://github.com/GuillaumePressiat/pmsi_rsa_for_deltalake</a>

Il a ensuite été mis en forme pour être un peu plus joli avec quarto, ici en html:

<a href="https://guillaumepressiat.github.io/pmsi_rsa_for_deltalake/" target="_blank">https://guillaumepressiat.github.io/pmsi_rsa_for_deltalake/</a>

Le voici embarqué dans cette page :

<center>
<iframe src="https://guillaumepressiat.github.io/pmsi_rsa_for_deltalake/" width="95%" height = "750"></iframe>
</center>

---
[^1]: ACID : Atomicité, cohérence, isolation et durabilité
