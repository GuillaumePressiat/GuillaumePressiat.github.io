---
layout: post
title: "Fun pictures with ggplot2 and scico packages"
date: 2026-04-18 10:05:05 +0100
author: Guillaume Pressiat
tags: R
comments: true
---



<img src="/images/earth-wind-oleron/oleron_polar_light.png">

<br>

This wonderful post from [Jonathan Caroll](https://jcarroll.com.au/2026/04/17/schotter-plots-in-r/) give me idea to play with [ggplot2](https://ggplot2.tidyverse.org) code and 
[scico](https://github.com/thomasp85/scico) color palettes: 

Also see this [toot](https://mastodon.social/@safest_integer/114296256313964335) from 
Stefan Siegert, inspiring!

I took the code from the [toot](https://mastodon.social/@safest_integer/114296256313964335) mentioned above, modified it, and used it to have a little fun creating graphics that look like paintings with imperfections around the edges, among other things. 

All in all, I think it's a good way to test color palettes.

When you get higher dot per inch images, it can be really cool.

<br>


<!--more-->


{% highlight r %}
# https://mastodon.social/@safest_integer/114296256313964335
library(tidyverse)
crossing(x=0:10, y=x) |>
  mutate(dx = rnorm(n(), 0, (y/20)^1.5),
         dy = rnorm(n(), 0, (y/20)^1.5)) |>
ggplot() +
geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour='black',
          lwd=2, width=1, height=1, alpha=0.8, show.legend=FALSE) +
scale_fill_gradient(high='#9f025e', low='#f9c929') +
scale_y_reverse() + theme_void()
{%endhighlight%}


{% highlight r %}
library(tidyverse)

crossing(x=8:300, y=x[1:100]) |>
  mutate(dx = rnorm(n(), 0, (y/200)^1.5),
         dy = rnorm(n(), 0, (y/100)^1.5)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour=NA,
            lwd=4, width=8, height=4, alpha=0.1, 
            show.legend=FALSE) +
  scale_fill_gradient(high='#9f025e', low='#f9c929') +
  scale_y_reverse() + theme_void() + 
  coord_fixed()
{%endhighlight%}

<img src="/images/earth-wind-oleron/manhattan.jpg"/>


Here is the "Oleron" color palette from [scico](https://github.com/thomasp85/scico). What a beautiful palette for those who know this french island!

{% highlight r %}
library(tidyverse)

crossing(x=8:300, y=x[1:100]) |>
  mutate(dx = rnorm(n(), 0, (y/200)^1.5),
         dy = rnorm(n(), 0, (y/100)^1.5)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour=NA,
            lwd=4, width=8, height=4, alpha=0.1, 
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "oleron", 
  direction = 1) +
  scale_y_reverse() + theme_void() + 
  coord_fixed()
{%endhighlight%}

<img src="/images/earth-wind-oleron/oleron_flat.jpg"/>


Now drawing waves, view at the top of the dune:


{% highlight r %}
crossing(x=8:300, y=x[1:100]) |>
  mutate(dx = rnorm(n(), 0, (y/200)^1.5),
         dy = ifelse(y < 52, 
                     rnorm(n(), 0, (y/100)^1.5)+ 
                       ifelse(x %% 2 == 0, 
                              cos(x * 3 + y / 5)*4 +
                                sin(x * 3 + y / 2)*2, 0) / 1.7,
                     rnorm(n(), 0, (y/100)^1.5))) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour=NA,
            lwd=4, width=8, height=4, alpha=0.2, 
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "oleron", #begin = 0.6,
                          direction = 1) +
  scale_y_reverse() + theme_void() + 
  coord_fixed()
{%endhighlight%}

The green might be vegetation from the dunes, or maybe seaweed.
The blue might also be sky and wind, blue hour, there is definitely sand.


<img src="/images/earth-wind-oleron/oleron_wave.jpg"/>

Back to bigger rectangles with a cyclic scico palette: `romaO`.

{% highlight r %}
crossing(x=1:280, y=x) |>
  mutate(dx = rnorm(n(), 0, (x/40)^1.5),
         dy = rnorm(n(), 0, (y/40)^1.5)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y-dy*3, fill=y), colour='white',
            lwd=0.03, width=13, height=6, alpha=0.4, 
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "romaO", #begin = 0.6,
                          direction = 1) +
  scale_y_reverse() + theme_void() + 
  theme(panel.background = element_rect(fill = "#2b2828")) +
  coord_fixed()
{%endhighlight%}

<img src="/images/earth-wind-oleron/romaO.jpg"/>


<br>

Now just play with a bit more magic: `coord_polar`

{% highlight r %}
crossing(x=1:280, y=x) |>
  mutate(dx = rnorm(n(), 0, (x/40)^1.5),
         dy = rnorm(n(), 0, (y/40)^1.5)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y-dy*3, fill=y), colour='white',
            lwd=0.03, width=13, height=6, alpha=0.4, 
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "romaO", #begin = 0.6,
  direction = 1) +
  scale_y_reverse() + theme_void() + 
  theme(panel.background = element_rect(fill = "#2b2828")) +
  coord_polar()
{%endhighlight%}

<img src="/images/earth-wind-oleron/romaO_polar.jpg"/>

Another one with `vikO` palette:

{% highlight r %}
crossing(x=8:70, y=x[1:30]) |>
  mutate(dx = rnorm(n(), 0, (y/20)^1.5),
         dy = rnorm(n(), 0, (y/10)^1.5)+ ifelse(x %%2 == 0, cos(x * 3 + y / 5)*10, 0)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour='grey70',
            lwd=0.1, width=8, height=4, alpha=0.6,
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "vikO", #begin = 0.6,
                          direction = -1) +
  scale_y_reverse() +
  theme_void() +
  theme(panel.background = element_rect(fill = "#2b2828")) +
  coord_polar(theta = "x")
{%endhighlight%}

<img src="/images/earth-wind-oleron/vikO_polar.png"/>

Finally back to Oleron palette with coord_polar:

{% highlight r %}
crossing(x=8:70, y=x[1:30]) |>
  mutate(dx = rnorm(n(), 0, (y/20)^1.5),
         dy = rnorm(n(), 0, (y/10)^1.5)+ ifelse(x %%2 == 0, cos(x * 3 + y / 5)*10, 0)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour=NA,
            lwd=1, width=8, height=4, alpha=0.4,
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "oleron", #begin = 0.6,
                          direction = 1) +
  scale_y_reverse() +
  theme_void() +
  theme(panel.background = element_rect(fill = "grey5")) + ##2b2828
  coord_polar(theta = "x")
{%endhighlight%}

Kind of like Earth, but not from the Moon. Just from R.

<img src="/images/earth-wind-oleron/oleron_polar.png"/>


`bukavu` palette:

{% highlight r %}
crossing(x=8:70, y=x[1:30]) |>
  mutate(dx = rnorm(n(), 0, (y/20)^1.5),
         dy = rnorm(n(), 0, (y/10)^1.5)+ ifelse(x %%2 == 0, cos(x * 3 + y / 5)*10, 0)) |>
  ggplot() +
  geom_tile(aes(x=x+dx, y=y+dy, fill=y), colour='grey5',
            lwd=0.2, width=8, height=4, alpha=0.4,
            show.legend=FALSE) +
  scico::scale_fill_scico(palette = "bukavu", #begin = 0.6,
                          direction = 1) +
  scale_y_reverse() +
  theme_void() +
  theme(panel.background = element_rect(fill = "#2b2828")) +
  coord_polar(theta = "x")
{%endhighlight%}

<img src="/images/earth-wind-oleron/bukavu_polar.png"/>



Many thanks to:

- Thomas Lin Pedersen for this package: [thomasp85/scico](https://github.com/thomasp85/scico) and [Fabio Crameri](https://www.fabiocrameri.ch/colourmaps/) for the palettes.
- [Stefan Siegert](https://mastodon.social/@safest_integer/114296256313964335)
- [Jonathan Caroll](https://jcarroll.com.au/2026/04/17/schotter-plots-in-r/)
- ggplot2 author and maintainers.

