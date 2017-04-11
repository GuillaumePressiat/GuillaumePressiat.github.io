---
layout: page
title: Blog
permalink: /blog/
---

Se trouvent ici les différents posts de ce blog.

<ul class="listing">
{% for post in site.posts %}
  {% capture y %}{{post.date | date:"%Y"}}{% endcapture %}
  {% if year != y %}
    {% assign year = y %}
    <li class="listing-seperator">{{ y }}</li>
  {% endif %}
  <li class="listing-item">
    <time datetime="{{ post.date | date:"%Y-%m-%d" }}">{{ post.date | date:"%d-%m-%Y" }}</time>
    <a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a>
  </li>
{% endfor %}
</ul>


{% assign rawtags = "" %}
{% for post in site.posts %}
	{% assign ttags = post.tags | join:'|' | append:'|' %}
	{% assign rawtags = rawtags | append:ttags %}
{% endfor %}
{% assign rawtags = rawtags | split:'|' | sort %}


{% assign tags = "" %}
{% for tag in rawtags %}
	{% if tag != "" %}
		{% if tags == "" %}
			{% assign tags = tag | split:'|' %}
		{% endif %}
		{% unless tags contains tag %}
			{% assign tags = tags | join:'|' | append:'|' | append:tag | split:'|' %}
		{% endunless %}
	{% endif %}
{% endfor %}

<br>

#### **Par mot-clé**

<ul class="tags">
{% for tag in tags %}
	<a class = "tag" href="/blog/tag/#{{ tag }}"> {{ tag }} </a>
{% endfor %}
</ul>



{% assign rawcategories = "" %}
{% for post in site.posts %}
  {% assign ccategories = post.categories | join:'|' | append:'|' %}
  {% assign rawcategories = rawcategories | append:ccategories %}
{% endfor %}
{% assign rawcategories = rawcategories | split:'|' | sort %}


{% assign categories = "" %}
{% for categorie in rawcategories %}
  {% if categorie != "" %}
    {% if categories == "" %}
      {% assign categories = categorie | split:'|' %}
    {% endif %}
    {% unless categories contains categorie %}
      {% assign categories = categories | join:'|' | append:'|' | append:categorie | split:'|' %}
    {% endunless %}
  {% endif %}
{% endfor %}

#### **Par catégorie**

<ul class="categories">
{% for categorie in categories %}
	<a class = "categorie" href="/blog/categories/#{{ categorie }}"> {{ categorie }} </a>
{% endfor %}
</ul>


