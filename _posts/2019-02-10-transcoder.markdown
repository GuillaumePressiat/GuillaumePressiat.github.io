---
layout: post
title:  "stringfix : adding transcoder shiny app"
date:   2019-02-10 02:05:50 +0100
author: Guillaume Pressiat
tags: R
---



<center>
<figure>
  <img src="/images/transcoder_1.png" alt = "" width= "80%" />
  <figcaption>Adding quotes to a character list</figcaption>
</figure>  
</center>

<!--more-->


# Transcoder : Shiny app to tranpose lists to columns (and reciprocally) and formatting tricks


Often I have to take a character list or column and put it in a vector, which means before I have to add quotes. It takes times. 

For me and my colleagues I have created the transcoder shiny app. The main goal is to facilitate formatting list of strings (make a vector from a list, from an Excel column, add quotes, put in pipe R format, or in SQL like, etc.).

You can run the app within [`stringfix`](https://guillaumepressiat.github.io/stringfix/index.html) package :


{% highlight r %}
stringfix::run_transcoder()
{% endhighlight %}


You may have to reinstall the package :

{% highlight r %}
devtools::install_github('GuillaumePressiat/stringfix')
{% endhighlight %}

You can also view and explore this little app running on shinyapps.io [here](https://guillaumepressiat.shinyapps.io/transcodeur/).

For instance, here is a screenshot of the app that put a column in grepl pipe format:

<center>
<figure>
  <a href="/images/transcoder_2.png"><img src="/images/transcoder_2.png" alt = "" width= "80%" /></a>
  <figcaption>Format a column to pipe | format</figcaption>
</figure>  
</center>




# Other things about stringfix package

I have added a page to present all the functions [here](https://guillaumepressiat.github.io/stringfix/reference/index.html).

<center>
<figure>
  <a href="https://guillaumepressiat.github.io/stringfix/reference/index.html"><img src="/images/stringfix_functions.png" alt = "" width= "50%" /></a>
</figure>  
</center>
 
Three functions in stringfix package are for pasting. From [here](https://github.com/GuillaumePressiat/stringfix/issues/2), you may discover another package that propose to paste strings with infix operators, it's the [`pasta`](https://github.com/chrisschuerz/pasta) package !


 


