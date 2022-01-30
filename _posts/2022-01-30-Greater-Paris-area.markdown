---
layout: post
title: "Trying to reproduce a map of the greater Paris area from APUR with ggplot2, a moment for coloring"
date: 2022-01-30 09:05:50 +0100
author: Guillaume Pressiat
tags: R
categories: maps
comments: true
---


In 2016, [APUR](https://www.apur.org/en) the Paris urbanism agency published a map that described new Greater Paris area, see [here](https://www.apur.org/sites/default/files/documents/etablissements_publics_territoriaux_MGP_carte_chiffres_cles.pdf).

At this time I was interested to reproduce this map in R with official datas/shapefiles and ggplot2.

*A moment for coloring*.

<img src = "/assets/files/grand_paris/capture_gp_carbon.png" width = "50%" alt="">

<!--more-->

I replace this code story here to let it somewhere other than my head (I have lost part of the code since 2016) and to share.


## Here is the map from APUR:

<br>

<img src = "/assets/files/grand_paris/gp_apur.png" alt="capture from apur">



## Trying to mimick with ggplot2

First thing was to define T1 to T12 areas and use french national geographic institute ([IGN](https://www.ign.fr)) shapefiles to plot a beginning ggplot2 map:


<img src = "/assets/files/grand_paris/gp1.png" width = "40%" alt="first ggplot2">


After some efforts, I was able to show this in R:

<img src = "/assets/files/grand_paris/gp2.png" alt="second ggplot2">



## La Seine and co.

Last thing that was not shown are rivers and canals. I had to find a shapefile for this.

Fortunately, I have found a shapefile from [APUR website](https://opendata.apur.org/datasets/plan-eau/explore?location=48.843002%2C2.423601%2C11.16) directly, named PLAN_EAU.

With this data, I have been able to show La Seine, La Marne, le Port de Gennevilliers and Paris canals.

Here I have plotted Grand Paris with "carbon like" colors to highlight this new area and because I find it's pretty cool like this!

R is really a nice environment.

<img src = "/assets/files/grand_paris/gp_carbon.png" alt="carbon paris ggplot2">

See here in [pdf](https://guillaumepressiat.github.io/assets/files/grand_paris/test_gp_seine_carbon2.pdf)


## Greater Paris map with R

I was able to output something like this.

<img src = "/assets/files/grand_paris/gp_end.png" alt="g paris end ggplot2">



Code for these maps is not clean but is available [here](https://github.com/GuillaumePressiat/grand_paris).

In this code, there are several steps:

- import shapefiles (rgdal)
- define Greater Paris area(s)
- union of regions with rgal/rgeos
- fortify shapefiles to plot polygons with ggplot2
- draw rivers and canals as polygons and paths (geoms)

Last map to mimick APUR map can be seen here in [pdf](https://guillaumepressiat.github.io/assets/files/grand_paris/test_gp_apur_like.pdf).


