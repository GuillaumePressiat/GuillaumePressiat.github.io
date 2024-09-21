---
layout: post
title: "Lire des fichiers H'XML / HPRIM-XML avec python/pola.rs ou R"
date: 2024-09-21 11:00:00 +0100
author: Guillaume Pressiat
tags: python interopérabilité HPRIM-XML
categories: Programmation
comments: true
---


Comment lire facilement des fichiers H'XML avec Python ou R ? 
Plusieurs solutions abordées dans ce billet.

<!--more-->


## Introduction


### De quoi parle-t-on ?

Dans les hôpitaux, il y a de nombreux logiciels qui s'organisent autour du soin, on parle de système d'information hospitalier (SIH). Une caractéristique importante de ce système, c'est la nécessité que les logiciels communiquent des informations en cohérence les uns avec les autres. 

Par exemple : 

- les données identifiant les patients : nom, prénoms, date de naissance, etc. 
- leur localisation : où et par qui sont pris en charge les patients à un instant T, où seront-ils à T+1 ? 
- pour le reste, en résumé :  toutes les informations relatives à leur prise en charge (médicaments, examens, analyses, diagnostics, actes médicaux, chirurgicaux, etc.)


Les enjeux sont importants et on parle d'interopérabilité, de logique évenementielle, d'atomicité de l'information. Bref, tout cela rentre dans un cadre plus large que l'on appelle l'urbanisation d'un système d'information.

Afin que ces échanges entre logiciels se passent le mieux possible, des standards ont été mis en place au niveau international (il y a un jargon, on citera HL7[^1], IHE[^2]) mais également au niveau national avec HPRIM[^3] car certaines données sont propres au cadre réglementaire français, notamment les spécificités du PMSI[^4].

En termes de format informatique, les données peuvent prendre la forme de fichiers texte où l'information est séparée par des barres verticales, de fichiers json mais aussi, souvent, de fichiers XML.

C'est ce dernier point qui est abordé dans ce billet avec le cas des fichiers HPRIM-XML. 
Les objectifs de cette norme tiennent dans ces 2 axes originellement en lien avec la FIDES Séjours[^5] : 

- Remontée des informations d’activité vers le DIM (exhaustivité, qualité et validation des informations médicales)
- Alimentation du processus de facturation individuelle des séjours (exhaustivité, qualité et validation des informations de facturation)


### Contexte

Imaginons que l'on se trouve entre deux logiciels qui échangent ce type d'informations (des informations typiquement du domaine de l'information médicale). On a besoin d'en interroger le contenu (et bien sûr, on a l'autorisation). Comment faire sans être un expert XSL[^6], ni spécialiste interopérabilité[^7] ?

Pour donner un aperçu, l'entête de ces fichiers XML ressemble à ceci : 

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<evenementsServeurEtatsPatient acquittementAttendu="non" version="2.00" xmlns="http://www.hprim.org/hprimXML">
	<enteteMessage>
		<identifiantMessage>00001_esep</identifiantMessage>
		<dateHeureProduction>2024-01-01T01:01:01</dateHeureProduction>
		<emetteur>
			<agents>
				<agent categorie="application">
					<code>TEST</code>
				</agent>
			</agents>
		</emetteur>
<etc.../>
{% endhighlight %}

Des fichiers d'exemples sont aussi disponibles : 

[https://github.com/GuillaumePressiat/pyhprimxml/tree/main/data/xml_tests](https://github.com/GuillaumePressiat/pyhprimxml/tree/main/data/xml_tests)

Nous présentons dans ce billet plusieurs options pour lire les données de fichiers HPRIM-XML par l'exemple.

## Utiliser xpath pour aller vite

Finalement, le problème peut être résumé à la lecture de fichiers XML, ces fichiers sont des fichiers où l'information est hiérarchisée, relationnelle. 

Comme pour scraper le contenu d'une page web, on peut utiliser XPath[^8] pour se "balader" dans les informations d'un fichier XML. Le principe de XPath est le suivant : si on connait le chemin, on peut accéder à l'information.

Voici deux implémentations très basiques pour le faire avec Python et R.

### Avec python

Avec python ici, une solution parmi d'autres : 

<a href="https://guillaumepressiat.github.io/pyhprimxml/xpath_xml.html" target="_blank">https://guillaumepressiat.github.io/pyhprimxml/xpath_xml.html</a>

<center>
<iframe src="https://guillaumepressiat.github.io/pyhprimxml/xpath_xml.html" width="95%" height = "750"></iframe>
</center>

<br>

### Avec R 

Le même exemple (très court) avec R ici : 

<a href="https://guillaumepressiat.github.io/pyhprimxml/xpath_xml_r.html" target="_blank">https://guillaumepressiat.github.io/pyhprimxml/xpath_xml_r.html</a>

<center>
<iframe src="https://guillaumepressiat.github.io/pyhprimxml/xpath_xml_r.html" width="95%" height = "750"></iframe>
</center>

<br>

## Package pyhprimxml

Avec les deux solutions simplistes ci-dessus, on a l'information mais on perd la dimension hiérarchique des fichiers XML, donc on perd de l'information en la simplifiant.

Le package pyhprimxml permet de convertir l'information d'un fichier HPRIM-XML en un DataFrame pola.rs : on peut ensuite se reposer sur la syntaxe de pola.rs pour extraire les informations.


###### Bibliothèques utilisées

- lxml : pour enlever le namespace xmlns avec un script xslt
- xmltodict : pour convertir le xml en dict python 
- json : pour encapsuler le dict en json pour la lecture avec pl.read_json
- polars : pour les étapes de déstructuration de la donnée hiérarchique issue des XML
- io, os, glob : pour les étapes de manipulations de fichiers dans le système

<a href="https://github.com/GuillaumePressiat/pyhprimxml" target="_blank">https://github.com/GuillaumePressiat/pyhprimxml</a>

Une présentation de ce package est faite ici : 

<a href="https://guillaumepressiat.github.io/pyhprimxml/" target="_blank">https://guillaumepressiat.github.io/pyhprimxml/</a>

Le voici embarqué dans cette page :

<center>
<iframe src="https://guillaumepressiat.github.io/pyhprimxml/" width="95%" height = "750"></iframe>
</center>


<br>

Pour en savoir plus, le repo github est ici : 

[https://github.com/GuillaumePressiat/pyhprimxml](https://github.com/GuillaumePressiat/pyhprimxml)

<br>

---
[^1]: [HL7](https://fr.wikipedia.org/wiki/Health_Level_7)
[^2]: [IHE](https://fr.wikipedia.org/wiki/Integrating_the_Healthcare_Enterprise)
[^3]: HPRIM : Harmoniser et PRomouvoir l'Informatique Médicale, initialement développé pour les laboratoires d'analyse médicale pour lesquels l'enjeu d'un échange de données efficient est rapidement apparu comme crucial
[^4]: PMSI : Programme de médicalisation des systèmes d'information
[^5]: FIDES Séjours : facturation individuelle des établissements de santé, voir [doc simphonie dgos](https://sante.gouv.fr/IMG/pdf/dgos_simphonie_reunion_editeur_hprimxml_040422.pdf)
[^6]: [https://fr.wikipedia.org/wiki/Extensible_stylesheet_language](https://fr.wikipedia.org/wiki/Extensible_stylesheet_language)
[^7]: interopérabilité : Capacité de matériels, de logiciels ou de protocoles différents à fonctionner ensemble et à partager des informations 
[^8]: [https://fr.wikipedia.org/wiki/XPath](https://fr.wikipedia.org/wiki/XPath) est un langage de requête pour localiser une portion d'un document XML très lié au départ aux spécifications XSL.