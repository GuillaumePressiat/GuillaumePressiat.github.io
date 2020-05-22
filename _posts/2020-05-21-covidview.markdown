---
layout: post
title: "Eyes on first wave with french open data -- COVID-19"
date: 2020-05-22 05:05:50 +0100
author: Guillaume Pressiat
tags: R shiny
categories: Application
comments: true
---




<img src = "/images/covid/covid_view.png" alt = "Covidfrance shiny app">


<!--more-->

**[Covidfrance app](https://guillaumepressiat.shinyapps.io/covidfrance/)** was first developped beginning of April for family, friends (and myself) to automatically know every day how many cases there are in each department where they live, daily along this crisis.

This app download daily csv file from french site data.gouv.fr via its api and build the map updated with last day data.

- [Scientific colour maps](http://www.fabiocrameri.ch/resources/ScientificColourMaps_FabioCrameri.png) palettes are used with scico package
- Population's ratio statistics are enabled with a switch to have both absolute and relative measures of epidemy.
- Overlay of json layers is used with full opacity to render time progression visible 
- departments shapes are simplified and smoothed with [smoothr](https://cran.r-project.org/web/packages/smoothr/vignettes/smoothr.html#smoothing-methods) (Chaikin method) and rmapshaper, really nice packages
- to let the map prints each day on animated mode along the time gauge, a delay of 1.7 second is set. It's a bit long but there are ~ 100 departments to look up each day! ("Almost 2 sec per day, not so much").


Data availables are:

- *Hospitalisés*: people in hospital on day i
- *En réanimation*: people in intensive care unit on day i
- *Retours à domicile (cumulés)*: cumul of returned at home until the day i
- *Décès (cumulés)*: cumul of deceases <u>at hospital</u> until the day i


This open data csv is a good way to share data across data-focus people and journalists. 

Then an app like this seems a good way to make data more accessible and eye friendly for people, with a geographical and "kinetic" approach.



Code for this app is quick code available [here](https://gist.github.com/GuillaumePressiat/0e3658624e42f763e3e6a67df92bc6c5).


<style type="text/css">

@media only screen and (min-width: 100px) {
    .gallery {
        display: flex;
        width: 100%;
        flex-flow: row wrap;
        margin-left: -4px;
    }

    .gallery div {
        overflow: hidden;
        margin: 0 0 8px 8px;
        flex: auto;
        height: 250px;
        min-width: 150px;
    }

    .gallery div:nth-child(8n+1) {
        width: 220px;
    }

    .gallery div:nth-child(8n+2) {
        width: 110px;
    }

    .gallery div:nth-child(8n+3) {
        width: 260px;
    }

    .gallery div:nth-child(8n+4) {
        width: 310px;
    }

    .gallery div:nth-child(8n+5) {
        width: 240px;
    }

    .gallery div:nth-child(8n+6) {
        width: 190px;
    }

    .gallery div:nth-child(8n+7) {
        width: 210px;
    }

    .gallery div:nth-child(8n+8) {
        width: 170px;
    }

    .gallery div.wide {
        width: 650px;
    }

    .gallery div.tall {
        width: 650px;
        height: 450px;
    }

    .gallery div.narrow {
        width: 250px;
    }

    .gallery img {
        object-fit: cover;
        width: 100%;
        height: 100%;
    }
}

</style>

<div class="gallery">
<div><img src = "/images/covid/covid_marti.png"/></div>
<div><img src = "/images/covid/corse_2020-05-01.png"/></div>
<div class = "narrow"><img src = "/images/covid/idf_2020-05-01_2.png"/></div>
<div><img src = "/images/covid/oleron.png"/></div>
<div><img src = "/images/covid/rad_last.png"/></div>
<div class = "narrow"><img src = "/images/covid/alsace.png"/></div>
<div><img src = "/images/covid/paysage_bret_idf.png"/></div>
<!-- <div class = "narrow"><img src = "/images/covid/marseille.png"/></div> -->
</div>
<br>



