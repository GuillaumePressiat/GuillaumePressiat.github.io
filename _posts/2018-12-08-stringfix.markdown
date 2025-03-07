---
layout: post
title:  "stringfix : new R package for string manipulation in a %>% way"
date:   2019-01-24 02:05:50 +0100
author: Guillaume Pressiat
tags: R
comments: true
---


I usually write around here in french and mainly report on French Hospitals data managment and the statistical tasks they imply. As today’s post is about a new package I have created, I’ll be writing in english. The package is called [`stringfix`](https://guillaumepressiat.github.io/stringfix/index.html) because it uses infix operators to manipulate character strings.

<!--more-->

*This post is an actualisation on December 2018 post.*

# Introduction

In Python, the operator `+` is used to paste two character strings together. For example: `'Hello ' + 'world'` gives `'Hello World'`. For that matter, building sentences with words and arithmetic symbols seems a very nice way to write. In R, the paste function requires parenthesis in order to be computed. Therefore the use of consecutive functions can make it hard to understand.

`+` is a nice operator, and we can use it in R almost as it is used in Python by creating an infix operator.

```r
`%+%` <- function(x,y){
  paste0(x, y)
}
```


While a ggplot function has already the same name, it is used to override data in a `ggplot` call and not for pasting character strings, see [here](https://ggplot2.tidyverse.org/reference/gg-add.html). When loading tidyverse, the same ggplot function is called, preventing us from using `paste0’`s `%+%`. Otherwise, you can find a hint of character string pasting in the [Advanced R](http://adv-r.had.co.nz/Functions.html#special-calls) book.


In order to create a toolbox around `paste0`'s `%+%`, I started collecting some other infix functions for character strings manipulation. The main question was: which functions with a right to left call that I use really often could be reordered in a  `%>%` code. Here is the little family I have since build on : paste, grepl, substring, count, padding. The goal of this package is to use stringr or base functions in backend as a start for an alternative character string manipulation in R.

This package is still at its early begining (kind of a draft for me!)  but I thought some other people would enjoy it and may even wish to contribute.


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
'Your pastas taste like ' %+% '%>%'
#> [1] "Your pastas taste like %>%"
'coco' %+% 'bolo'
#> [1] "cocobolo"
```

```r
'Hello' % % 'world'
#> [1] "Hello world"
'Your pastas taste like' % % '%>%'
#> [1] "Your pastas taste like %>%"
'Hello' %,% 'world...'
#> [1] "Hello, world..."
'Your pastas taste like ' %+% '%>%...' %,% 'or %>>%...'
#> [1] "Your pastas taste like %>%..., or %>>%..."
```

#### grepl

##### Case sensitive

```r
'pig' %g% 'The pig is in the cornfield'
#> [1] TRUE
'Pig' %g% 'The pig is in the cornfield'
#> [1] FALSE
```

##### Case insensitive (ignore.case)

```r
'pig' %gic% 'The pig is in the cornfield'
#> [1] TRUE
'PIG' %gic% 'The PiG is in the cornfield'
#> [1] TRUE
```

#### substring

```r
'NFKA008' %s% '1.4'
#> [1] "NFKA"
'NFKA008' %s% .4
#> [1] "NFKA"
'where is' % % ('the pig is in the cornfield' %s% '1.7') %+% '?'
#> [1] "where is the pig?"
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


Finally, I also wanted to outline that the function from the [rmngb](https://github.com/pierucci/rmngb) package : `%out%` : negation of `%in%` can be very useful to avoid  typing `! x %in% y` (you can just type `x %out% y` instead). This is why I have included it in this package !


More functions and information here : [https://github.com/GuillaumePressiat/stringfix](https://github.com/GuillaumePressiat/stringfix)

---


