---
layout: post
title:  "stringfix : new package for string manipulation in a %>% way"
date:   2018-12-08 08:05:50 +0100
author: Guillaume Pressiat
tags: R
---


Usually I write here in french about French Hospitals data management and statistical tasks that are linked to. Today I'm gonna talk in english about a new package, that I have called [`stringfix`](https://guillaumepressiat.github.io/stringfix/index.html).
stringfix because it uses infix operators to manipulate character strings.

<!--more-->

# Introduction

In Python, paste two strings is done with  `+` operator, `'Hello ' + 'world'` gives you `'Hello World'`. It's really a nice way of writing things, like writing words with an arithmetic symbol. `paste0` has no problem but you have to use parenthesis, and in successive function call like `f(paste0(g(h(paste0(x, y, z))), u))`, operations order's priority becomes hard to read. 

`+` is a nice operator, and same thing is almost possible in R, you can create it using an infix operator, for instance : 

```r
`%+%` <- function(x,y){
  paste0(x, y)
}
```


While this function is easy to think of and to use, ggplot2 has a same named function to override data in a `ggplot` call, see [here](https://ggplot2.tidyverse.org/reference/gg-add.html). In the tidyverse, this `ggplot` function takes the place. But you can also find an evocation of `%+%` character string pasting in [Advanced R](http://adv-r.had.co.nz/Functions.html#special-calls) book.


To make a home for `paste0`'s `%+%`, I start collecting some other infix functions for strings manipulation. Question was : what functions that I use really often with a right to left call can I reorder in a `%>%` way of coding ? Here is the little family I've made : paste, grepl, substring, count, padding. Sense of this package is to propose beginning of an alternative for character string manipulation in R, always using  `stringr` or `base` functions in backend.

This package at the begining is just a box for me, it's like a draft but I have imagined some other people will like this a bit too, so I post it here.


# Presentation



```r
"In a manner of coding, I just want to say..." % % "Nothing."
#>[1] "In a manner of coding, I just want to say... Nothing."
```

### Examples


#### paste

```r
'Hello ' %+% 'world'
#> [1] "Hello world"
'Your pastas tastes like ' %+% '%>%'
#> [1] "Your pastas tastes like %>%"
'coco' %+% 'bolo'
#> [1] "cocobolo"
```

```r
'Hello' % % 'world'
#> [1] "Hello world"
'Your pastas tastes like' % % '%>%'
#> [1] "Your pastas tastes like %>%"
'Hello' %,% 'world...'
#> [1] "Hello, world..."
'Your pastas tastes like ' %+% '%>%...' %,% 'or %>>%...'
#> [1] "Your pastas tastes like %>%..., or %>>%..."
```

#### grepl

##### Case sensitive

```r
'pig' %g% 'The pig is in the corn'
#> [1] TRUE
'Pig' %g% 'The pig is in the corn'
#> [1] FALSE
```

##### Case insensitive (ignore.case)

```r
'pig' %gic% 'The pig is in the corn'
#> [1] TRUE
'PIG' %gic% 'The PiG is in the corn'
#> [1] TRUE
```

#### substring

```r
'NFKA008' %s% '1.4'
#> [1] "NFKA"
'NFKA008' %s% .4
#> [1] "NFKA"
'where is' % % ('the pig is in the corn' %s% '1.7') % % '?'
#> [1] "where is the pig ?"
```

#### count

```r
fruit <- c("apple", "banana", "pear", "pineapple")
"a" %count% fruit
#> [1] 1 3 1 1
c("a", "b", "p", "p") %count% fruit
#> [1] 1 1 1 3
```

#### pad, lpad and rpad

```r
5 %lpad% '0.5'
#> [1] "00005"
5 %lpad%   .5
#> [1] "00005"
5 %lpad%  '.5'
#> [1] "    5"
5 %lpad% '2.5'
#> [1] "22225"
'é' %lpad% 'é.5'
#> [1] "ééééé"
```

#### names of tibbles : tolower and toupper

I have added two functions that I use really often.

```r
library(magrittr)
iris %>% toupper_names %>% head
#>   SEPAL.LENGTH SEPAL.WIDTH PETAL.LENGTH PETAL.WIDTH SPECIES
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```


At last, I also want to underline this function from [rmngb](https://github.com/pierucci/rmngb) package : `%out%` : negation of `%in%` that I have included in this package because it's really useful not to write `! x %in% y`, you just write `x %out% y`.


More information here : [https://github.com/GuillaumePressiat/stringfix](https://github.com/GuillaumePressiat/stringfix)

---


