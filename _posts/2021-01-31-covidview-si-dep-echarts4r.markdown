---
layout: post
title: "Eyes on RT-PCR tests with echarts and french open data -- COVID-19"
date: 2021-01-31 05:05:50 +0100
author: Guillaume Pressiat
tags: R shiny
categories: Application
comments: true
---



### Data on COVID-19 screening tests for France ; a shared dashboard with calendar and other heatmaps

<img src = "/images/covid/covid-si-dep_echarts4r.png" alt = "Covid-si-dep shiny app with echarts4r calendar heatmap">

<!--more-->


Link for the app: [https://guillaumepressiat.shinyapps.io/covid-si-dep](https://guillaumepressiat.shinyapps.io/covid-si-dep)

This app download daily csv file from french site data.gouv.fr via its api and build heatmaps updated with last day data available.

- I have moved from `ggplotly` to `echarts4r` package and really nice `e_calendar` function, see here: [https://echarts4r.john-coene.com](https://echarts4r.john-coene.com) or here for full docs [https://echarts.apache.org/](https://echarts.apache.org/en/index.html)
- `shinywidgets` with `pickerInput` lets user choose its departments
- data are available mouse on hover
- by tweeking URL like this, you can choose which **?dep**artments or **?reg**ions are available on startup:

[https://guillaumepressiat.shinyapps.io/covid-si-dep/?reg=11\|93\|32](https://guillaumepressiat.shinyapps.io/covid-si-dep/?reg=11%7c93%7c32)

[https://guillaumepressiat.shinyapps.io/covid-si-dep/?dep=36\|23\|75\|29](https://guillaumepressiat.shinyapps.io/covid-si-dep/?dep=36%7c23%7c75%7c29)


Data availables are:

- Number of positive tests by day (cases), week and departments and age categories
- Incidence of positive tests for 100 000 inhabitants

They come from [Santé Publique France](https://www.data.gouv.fr/fr/datasets/taux-dincidence-de-lepidemie-de-covid-19/).

A visualisation is available showing dispersion over age groups by week.

<img src = "/images/covid/covid-si-dep_clage.png" alt = "Incidence by age group by week">

Code for this app is available [here](https://github.com/GuillaumePressiat/covid-si-dep).

