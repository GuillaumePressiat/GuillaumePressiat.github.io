---
layout: post
title: "pypmsi : lire des fichiers PMSI avec python / polars"
date: 2023-03-11 09:05:50 +0100
author: Guillaume Pressiat
tags: pypmsi python
categories: Programmation
comments: true
---

<style>
table, th {
  border: 1px solid grey;
  color: cornflowerblue;
}
</style>


<center>
<figure>
  <img src="/images/carbon/pypmsi_capt.png" alt = "" />
</figure>  
</center>

<!--more-->

<br>

  > pypmsi est un package python pour lire les fichiers du PMSI ; dans la suite de pmeasyr.

  > Ce code, qui en est à ses débuts, a été initié au sein du département d'information médicale du CHU de Brest en conjonction avec son
  centre de données cliniques (CDC, entrepôt de données de santé) et dans la continuité des travaux réalisés 
  avec le DIM de l'AP-HP.


Le découpage d'un fichier .rsa de 130 000 RSA prend selon les types d'imports :

  - <= 1 seconde, découpage partie fixe (< 300 ms avec puce silicon)
  - <= 4 secondes, découpage partie fixe + parties variables actes, diags, ums (< 1 seconde avec puce silicon)


<!-- ```
import datetime
import pypmsi as pm
p = pm.noyau_pmsi(finess = 290000017, annee = 2021, mois = 5, path = '~/Documents/data/mco')
a = datetime.datetime.now()
rsa = p.irsa(typi = 4)
b = datetime.datetime.now()
b - a

``` -->

## Installation

{% highlight sh %}
pip install https://github.com/GuillaumePressiat/pypmsi/releases/latest/download/pypmsi-0.1.0-py3-none-any.whl
{% endhighlight %}

ou télécharger la dernière version directement sur github avec votre navigateur et l'installer ainsi :

{% highlight sh %}
pip install pypmsi-X.Y.Z-py3-none-any.whl
{% endhighlight %}

en remplaçant X Y et Z par ce qu'il faut.


### Dépôt

<a href="https://github.com/GuillaumePressiat/pypmsi" target="_blank">https://github.com/GuillaumePressiat/pypmsi</a>

## pola.rs ?

  > Lightning-fast DataFrame library for Rust and Python

  - <a href="https://www.pola.rs" target="_blank">https://www.pola.rs</a>
  - <a href="https://towardsdatascience.com/pandas-vs-polars-a-syntax-and-speed-comparison-5aa54e27497e" target="_blank">https://towardsdatascience.com/pandas-vs-polars-a-syntax-and-speed-comparison-5aa54e27497e</a>
  - <a href="https://studioterabyte.nl/en/blog/polars-vs-pandas" target="_blank">https://studioterabyte.nl/en/blog/polars-vs-pandas</a>

<br>

## Utilisation de pypmsi

{% highlight python %}
import polars
import pypmsi as pm
{% endhighlight %}

## 3 manières de lire un fichier

#### Spécifier les paramètres dans la fonction

{% highlight python %}
rsa = pm.irsa(290000017, 2021,5, '~/Documents/data/mco', typi = 4)
rsa
{% endhighlight %}


#### Définir un noyau de paramètres

{% highlight python %}
p = pm.noyau_pmsi(finess = 290000017, annee = 2021, mois = 5, path = '~/Documents/data/mco')
rsa = p.irsa()
rsa
{% endhighlight %}


#### indiquer le chemin du fichier et l'année, et le lire

{% highlight python %}
mon_rsa = pm.chemin_pmsi(filepath = '~/Documents/data/mco/290000017.2021.5.rsa', annee = 2021)
rsa = mon_rsa.read_rsa()
rsa
{% endhighlight %}

(du coup le nom du fichier peut-être formaté différement : `export_rock_n_roll.rss`).


On peut modifier en ligne les paramètres, exemple :

{% highlight python %}
p = pm.noyau_pmsi(finess = 290000017, annee = 2021, mois = 12, path = '~/Documents/data/mco')
# lire les données 2022
rsa = p.irsa(annee = 2022)
rsa
{% endhighlight %}

### Exemple sur les rsa

{% highlight python %}
rsa
{% endhighlight %}


{% highlight sh %}
{'rsa': shape: (57140, 88)
┌───────────┬────────┬────────────┬────────┬─────┬───────┬──────┬─────┬─────────┐
│ nofiness  ┆ novrsa ┆ cle_rsa    ┆ novrss ┆ ... ┆ dr    ┆ ndas ┆ na  ┆ filler6 │
│ ---       ┆ ---    ┆ ---        ┆ ---    ┆     ┆ ---   ┆ ---  ┆ --- ┆ ---     │
│ str       ┆ str    ┆ str        ┆ str    ┆     ┆ str   ┆ i32  ┆ i32 ┆ str     │
╞═══════════╪════════╪════════════╪════════╪═════╪═══════╪══════╪═════╪═════════╡
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆ R5210 ┆ 0    ┆ 0   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆ G628  ┆ 0    ┆ 0   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆ M341  ┆ 0    ┆ 5   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆       ┆ 16   ┆ 27  ┆         │
│ ...       ┆ ...    ┆ ...        ┆ ...    ┆ ... ┆ ...   ┆ ...  ┆ ... ┆ ...     │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆       ┆ 0    ┆ 4   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆ N185  ┆ 0    ┆ 1   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆ C504  ┆ 0    ┆ 1   ┆         │
│ 290000017 ┆ 226    ┆ 00000xxxxx ┆ 120    ┆ ... ┆       ┆ 6    ┆ 25  ┆         │
└───────────┴────────┴────────────┴────────┴─────┴───────┴──────┴─────┴─────────┘, 

'actes': shape: (166028, 13)
┌────────────┬───────┬─────────┬────────┬─────┬────────┬────────┬────────┬─────────┐
│ cle_rsa    ┆ delai ┆ cdccam  ┆ descri ┆ ... ┆ assonp ┆ nbexec ┆ indval ┆ nseqrum │
│ ---        ┆ ---   ┆ ---     ┆ ---    ┆     ┆ ---    ┆ ---    ┆ ---    ┆ ---     │
│ str        ┆ i32   ┆ str     ┆ str    ┆     ┆ str    ┆ i32    ┆ str    ┆ str     │
╞════════════╪═══════╪═════════╪════════╪═════╪════════╪════════╪════════╪═════════╡
│ 00000xxxxx ┆ 0     ┆ GLQP002 ┆        ┆ ... ┆ 1      ┆ 1      ┆ 1      ┆ 01      │
│ 00000xxxxx ┆ 0     ┆ PBQM003 ┆        ┆ ... ┆        ┆ 1      ┆ 1      ┆ 01      │
│ 00000xxxxx ┆ 0     ┆ YYYY076 ┆        ┆ ... ┆ 2      ┆ 1      ┆ 1      ┆ 01      │
│ 00000xxxxx ┆ 0     ┆ ZZQX069 ┆        ┆ ... ┆ 4      ┆ 1      ┆ 1      ┆ 01      │
│ ...        ┆ ...   ┆ ...     ┆ ...    ┆ ... ┆ ...    ┆ ...    ┆ ...    ┆ ...     │
│ 00000xxxxx ┆ 4     ┆ DEQP004 ┆        ┆ ... ┆        ┆ 1      ┆ 1      ┆ 02      │
│ 00000xxxxx ┆ 4     ┆ YYYY020 ┆        ┆ ... ┆        ┆ 1      ┆ 1      ┆ 02      │
│ 00000xxxxx ┆ 4     ┆ YYYY020 ┆        ┆ ... ┆        ┆ 1      ┆ 1      ┆ 02      │
│ 00000xxxxx ┆ 4     ┆ YYYY020 ┆        ┆ ... ┆        ┆ 1      ┆ 1      ┆ 02      │
└────────────┴───────┴─────────┴────────┴─────┴────────┴────────┴────────┴─────────┘, 

'diags': shape: (177176, 4)
┌────────────┬─────────┬───────┬──────────┐
│ cle_rsa    ┆ nseqrum ┆ diag  ┆ position │
│ ---        ┆ ---     ┆ ---   ┆ ---      │
│ str        ┆ str     ┆ str   ┆ i32      │
╞════════════╪═════════╪═══════╪══════════╡
│ 00000xxxxx ┆ 01      ┆ Z4180 ┆ 1        │
│ 00000xxxxx ┆ 01      ┆ Z512  ┆ 1        │
│ 00000xxxxx ┆ 01      ┆ Z092  ┆ 1        │
│ 00000xxxxx ┆ 01      ┆ D462  ┆ 1        │
│ ...        ┆ ...     ┆ ...   ┆ ...      │
│ 00000xxxxx ┆ 01      ┆ M0699 ┆ 4        │
│ 00000xxxxx ┆ 01      ┆ C629  ┆ 4        │
│ 00000xxxxx ┆ 01      ┆ N185  ┆ 4        │
│ 00000xxxxx ┆ 01      ┆ C504  ┆ 4        │
└────────────┴─────────┴───────┴──────────┘, 

'rsa_um': shape: (63199, 17)
┌────────────┬─────────┬────────┬───────────┬─────┬─────────┬─────────┬──────────┬─────────┐
│ cle_rsa    ┆ nseqrum ┆ nsequm ┆ nohop1    ┆ ... ┆ nbsupp1 ┆ typaut2 ┆ natsupp2 ┆ nbsupp2 │
│ ---        ┆ ---     ┆ ---    ┆ ---       ┆     ┆ ---     ┆ ---     ┆ ---      ┆ ---     │
│ str        ┆ str     ┆ str    ┆ str       ┆     ┆ i32     ┆ str     ┆ str      ┆ str     │
╞════════════╪═════════╪════════╪═══════════╪═════╪═════════╪═════════╪══════════╪═════════╡
│ 00000xxxxx ┆ 01      ┆ 0028   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 01      ┆ 0021   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 01      ┆ 0022   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 01      ┆ 0076   ┆ 29000xxxx ┆ ... ┆ 109     ┆         ┆          ┆         │
│ ...        ┆ ...     ┆ ...    ┆ ...       ┆ ... ┆ ...     ┆ ...     ┆ ...      ┆ ...     │
│ 00000xxxxx ┆ 02      ┆ 0039   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 03      ┆ 0039   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 04      ┆ 0085   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
│ 00000xxxxx ┆ 05      ┆ 0085   ┆ 29000xxxx ┆ ... ┆ 0       ┆         ┆          ┆         │
└────────────┴─────────┴────────┴───────────┴─────┴─────────┴─────────┴──────────┴─────────┘}
{% endhighlight %}



### Quelques statistiques avec polars


{% highlight python %}
(rsa['actes']
  .filter(pl.col('cdccam').str.contains('EBLA'))
  .groupby(['cdccam', 'nbexec'])
  .count()
)
{% endhighlight %}

{% highlight sh %}
shape: (2, 3)
┌─────────┬────────┬───────┐
│ cdccam  ┆ nbexec ┆ count │
│ ---     ┆ ---    ┆ ---   │
│ str     ┆ i64    ┆ u32   │
╞═════════╪════════╪═══════╡
│ EBLA002 ┆ 1      ┆ 2     │
│ EBLA003 ┆ 1      ┆ 185   │
└─────────┴────────┴───────┘
{% endhighlight %}


{% highlight python %}
(rsa['actes']
  .filter(pl.col('cdccam').str.contains('EBLA'))
  .join(rsa['rsa'], on = 'cle_rsa', how = 'inner')
  .pivot('nbexec', 'cdccam', 'rsatype', 'count')
  .fill_null(0)
)
{% endhighlight %}

{% highlight sh %}
shape: (2, 5)
┌─────────┬─────┬─────┬─────┬─────┐
│ cdccam  ┆ C   ┆ M   ┆ Z   ┆ K   │
│ ---     ┆ --- ┆ --- ┆ --- ┆ --- │
│ str     ┆ u32 ┆ u32 ┆ u32 ┆ u32 │
╞═════════╪═════╪═════╪═════╪═════╡
│ EBLA003 ┆ 24  ┆ 56  ┆ 9   ┆ 96  │
│ EBLA002 ┆ 0   ┆ 1   ┆ 1   ┆ 0   │
└─────────┴─────┴─────┴─────┴─────┘
{% endhighlight %}

{% highlight python %}
(rsa['actes']
  .filter(pl.col('cdccam').str.contains('EBLA'))
  .join(rsa['rsa'], on = 'cle_rsa', how = 'inner')
  .pivot('nbexec', 'cdccam', ['rsacmd', 'rsatype'], 'sum')
  .fill_null(0)
)
{% endhighlight %}

{% highlight sh %}
shape: (2, 19)
┌─────────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│ cdccam  ┆ 17  ┆ 11  ┆ 04  ┆ ... ┆ C   ┆ M   ┆ Z   ┆ K   │
│ ---     ┆ --- ┆ --- ┆ --- ┆     ┆ --- ┆ --- ┆ --- ┆ --- │
│ str     ┆ i64 ┆ i64 ┆ i64 ┆     ┆ i64 ┆ i64 ┆ i64 ┆ i64 │
╞═════════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╡
│ EBLA003 ┆ 29  ┆ 1   ┆ 13  ┆ ... ┆ 24  ┆ 56  ┆ 9   ┆ 96  │
│ EBLA002 ┆ 0   ┆ 0   ┆ 0   ┆ ... ┆ 0   ┆ 1   ┆ 1   ┆ 0   │
└─────────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
{% endhighlight %}


## Types d'imports

La typologie des imports pour les RUM et les RSA reprend celle du package pmeasyr.

On peut obtenir avec les imports "stream" des colonnes de ce type, ici au niveau des RSA : 

{% highlight sh %}
┌───────────┬────────┬────────────┬───────────────────┬────────────────────────────┬───────────────────────────┬───────────────┬─────────────┐
│ nofiness  ┆ novrsa ┆ cle_rsa    ┆ stream_actes      ┆ stream_das                 ┆ stream_um                 ┆ stream_dpum   ┆ stream_drum │
│ ---       ┆ ---    ┆ ---        ┆ ---               ┆ ---                        ┆ ---                       ┆ ---           ┆ ---         │
│ str       ┆ str    ┆ str        ┆ str               ┆ str                        ┆ str                       ┆ str           ┆ str         │
╞═══════════╪════════╪════════════╪═══════════════════╪════════════════════════════╪═══════════════════════════╪═══════════════╪═════════════╡
│ 290000017 ┆ 226    ┆ y          ┆ null              ┆ null                       ┆ 61 P                      ┆ Z4180         ┆ R5210       │
│ 290000017 ┆ 226    ┆ y          ┆ null              ┆ null                       ┆ 29 C                      ┆ Z512          ┆ G628        │
│ 290000017 ┆ 226    ┆ y          ┆ YYYY076, GLQP002, ┆ null                       ┆ 29 M                      ┆ Z092          ┆ M341        │
│           ┆        ┆ y          ┆ PBQM003, ZZQX1... ┆                            ┆                           ┆               ┆             │
│ 290000017 ┆ 226    ┆ y          ┆ ZZNL047, ZZML002, ┆ K573, J980, T808, J448,    ┆ 16 C                      ┆ D462          ┆             │
│           ┆        ┆            ┆ YYYY028, ZZML0... ┆ T827, D6...                ┆                           ┆               ┆             │
│ ...       ┆ ...    ┆ ...        ┆ ...               ┆ ...                        ┆ ...                       ┆ ...           ┆ ...         │
│ 290000017 ┆ 226    ┆ y          ┆ QZMA006           ┆ null                       ┆ 53 C                      ┆               ┆             │
│ 290000017 ┆ 226    ┆ y          ┆ JVJF008           ┆ null                       ┆ 21 P                      ┆ Z491          ┆ N185        │
│ 290000017 ┆ 226    ┆ y          ┆ ZZNL051           ┆ null                       ┆ 01 C, 42 P                ┆ Z5101         ┆ C504        │
└───────────┴────────┴────────────┴───────────────────┴────────────────────────────┴───────────────────────────┴───────────────┴─────────────┘
{% endhighlight %}

(ici sur les RSA, typi = 3)

On peut alors filtrer sur les actes, les diags etc directement au niveau des RSA, sans jointure entre les tables :

{% highlight python %}
import polars as pl
# Exemple : PTG ou PTH sans RUM avec DP S ou M
(rsa['rsa']
  .filter(pl.col('stream_actes').str.contains('N.KA'))
  .filter(~pl.col('stream_dpum').str.contains('S|M'))
)
{% endhighlight %}


- RSA : 6 types d'imports (typi)

```
# 1          : partie fixe uniquement
# 2          : partie fixe + zones streams actes, das
# 3          : partie fixe + zones streams actes, das, dpum, drum, typaut
# 4 (défaut) : partie fixe + partie variable + zones streams actes, das
# 5          : partie fixe + zones streams actes, das, dpum, drum, typaut
# 6          : partie fixe + partie variable + zones streams actes, das, dpum, drum, typaut
```

- RUM : 4 types d'imports (typi)

```
# 1          : partie fixe uniquement
# 2          : partie fixe + zones streams actes, das, dad
# 3 (défaut) : partie fixe + partie variable
# 4          : partie fixe + partie variable + zones streams actes, das, dad
```

## Fichiers pris en charge

- MCO
  - rss (irum) - de 2012 à 2023
  - rsa (irsa) - de 2011 à 2023
  - ano in et out (iano_mco) - de 2012 à 2023
  - med in et out (imed_mco) - de 2012 à 2023
  - rsf (irsf) - de 2011 à 2023
  - rsfa (irsfa) - de 2011 à 2023



## à poursuivre


<a href="https://github.com/GuillaumePressiat/pypmsi/issues/9" target="_blank">https://github.com/GuillaumePressiat/pypmsi/issues/9</a>


