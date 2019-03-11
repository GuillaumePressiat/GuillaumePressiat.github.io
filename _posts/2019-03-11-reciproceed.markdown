---
layout: post
title:  "reciproceed : recipe, proceed, reciprocally"
date:   2019-03-11 02:05:50 +0100
author: Guillaume Pressiat
tags: R
---



## use R, YAML and bookdown to automate generation of procedure books


<!--more-->

**Context: How to do this thing that only your colleague do when he's not here ?**

I recently put on [github](https://github.com/GuillaumePressiat/reciproceed) a project that contains a little framework to list procedures in a structured way that can be shared with all your colleagues or buddies.

You may know situations where someone in your team has build a project that he is the only one to mastering. How to make it works when he is not here ? Maybe he has written a doc / procedure to do explain his project but you don't know (or don't remember) where it is on the network / web ? 

As a solution, an index of all procedures can be useful. As a listing of :

- summary of all procedures (as simple steps)
- links to git repositories
- links to more detailed procedures (docx, pdf, html)
- links to the data sources involved by the project
- etc.

reciproceed sounds like "reciprocally” meaning that once all procedures are listed this way, all the team will be involved reciprocally.

## Idea

To do this, an idea is : using a YAML file and [bookdown](https://bookdown.org) to build a shareable procedure listing like a book.

## Example

As an example, I collected some soup recipes and fake procedures, see the source [YAML file](https://github.com/GuillaumePressiat/reciproceed/blob/master/index_procedures.yaml).

And the result book is here :

[Soup recipe example](https://guillaumepressiat.github.io/reciproceed/)

## Maybe

Maybe someone else will be interested by this and even will participate to improve it.

It'is here, [https://github.com/GuillaumePressiat/reciproceed](https://github.com/GuillaumePressiat/reciproceed)
