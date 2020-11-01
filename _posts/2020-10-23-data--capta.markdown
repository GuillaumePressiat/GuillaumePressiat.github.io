---
layout: post
title: "data / capta : Interroger le concept de donnée à l'heure du HealthDataHub <small>avec une application portée sur l'information médicale</small>"
date: 2020-10-23 01:01:01 +0100
author: Guillaume Pressiat
tags: data
categories: Réflexion
comments: true
---



> La tentation de l’idéalisme vient peut-être du mot même de données qui décrit aussi mal que possible ce sur quoi s’appliquent les capacités cognitives ordinaires des érudits, des savants et des intellectuels. Il faudrait remplacer ce terme par celui, beaucoup plus réaliste, d’obtenues et parler par conséquent de bases d’obtenues, de sublata plutôt que de data.[^1]

<!--more-->

<style src="text/css">
	main {
  line-height: 1.85em;
  font-size: 18px;
}

h2 {
	font-size:30px;
	/*font-weight: 100;*/
	color: #4d4d4d;
	margin-top: 35px;
	margin-bottom: 10px;
}

h3 {
	margin-top: 30px;
	font-size:23px;
	font-weight:400;
	color: #4d4d4d;
	margin-bottom: 10px;
}
h4 {
	margin-top: 20px;
	font-size:16px;
	font-weight:540;
	color: #4d4d4d;
}

blockquote {
	font-size: 15px;
	letter-spacing: 0px;
}
</style>



## Introduction 
  
L'usage courant du terme de donnée nous amène à l'interroger comme concept (et percept par là-même). C'est un préliminaire pour pouvoir interroger tant bien les données elles-mêmes que les différents processus et acteurs amenant à les obtenir. Si un objectif est défini, celui de trouver dans toutes les informations de santé disponibles des réponses à des questions, ainsi que de soulever de nouvelles questions, le moyen d'atteindre cet objectif reste à concevoir : comment respecter la donnée, et, avec elle, respecter les différents acteurs qui s'y investissent ? 

*Est-on bien sûr que l'analyse des données tient compte de la complexité des processus et du crédit des acteurs qui les réalisent ?*

## Contexte

En période de crise sanitaire, les hôpitaux ont été en première ligne pour affronter le virus. En parallèle, les pouvoirs publics ont invité les hôpitaux à produire une donnée au fil de l'eau (transmissions hebdomadaires) pour alimenter le nouveau HealthDataHub (HDH). 
 
Les louanges sur la capacité du pays -et des territoires- à trouver des solutions sans l'aide de l'État ont fleuri lors de cette crise, mais le décret précisant que les données devraient remonter des hôpitaux vers le HDH est passé par un canal on ne peut plus central. Et comme souvent, l'information ensuite enchevêtrée dans les strates administratives ne circule pas : elle sédimente. Il aura donc fallu la chercher partout. Subtile l'efficacité et la clarté en période de crise. (On n'oubliera pas qu'en parallèle les hôpitaux répondaient déjà au relevé pluri-quotidien des patients COVID hospitalisés / en réanimation / décédés ou sortis, à destination des ARS - Santé Publique France - etc.). 

Mais, c'est bien normal de vouloir le plus de données possible en période de crise pour avoir toutes les chances de mieux comprendre ce virus. Cela dit les producteurs de données ne sont pas du tout associés ni considérés en ce qui concerne les nouvelles modalités d'analyse de ces données. Pour adopter une formulation organiciste, on déconnecte la tête du corps, et ce n'est pas une bonne chose pour la suite. Il faudrait relier les hôpitaux au HealthDataHub, comme son nom l'indique d'ailleurs, et pas uniquement les données des hôpitaux. *À l'échelle des grands hôpitaux, c'est ce qui est réalisé avec les entrepôts de données de santé : l'organisation à cette échelle peut permettre de créer le lien entre les métiers de la donnée et les métiers du soin.* 

Plus pragmatiquement, la demande de remontées hebdomadaires donne l'impression que la donnée coule de l'hôpital comme d'une source. En pleine crise sanitaire comme en temps normal, ce n'est pas le cas. Cette impression ne s'atténue guère quand le ministre de la santé évoque la perte de temps pour un médecin de saisir ces informations (l'avenir du codage[^7]), alors qu'en même temps, il est demandé aux hôpitaux de fournir ces informations à un rythme accéléré ! Mais qui sont ces médecins qui codent ?  


Autre point délicat : le format des données hospitalières (PMSI, voir plus bas), quasiment stable depuis une dizaine d'années est bousculé pour répondre à cette demande du HDH. Il l'est également pour tenir compte des exigences de la CNIL (niveau d'anonymisation des informations patients[^9]), erreur / hasard de calendrier. En pleine crise, donc, on déstabilise les systèmes d'informations hospitaliers s'appuyant sur ces données. 

## Données ou obtenues ?


Mais revenons sur le concept de donnée. Je reprends ici des éléments d'un article d'[Arthur Perret](http://arthurperret.fr/documentarite-et-donnees.html) dont le paragraphe [Épistémologie des données](http://arthurperret.fr/documentarite-et-donnees.html#épistémologie-des-données) mérite, je crois, le détour.

### De la mesure au big data

Suite au développement des expérimentations scientifiques et de l'instrumentation allant avec, le terme donnée apparait au XVIIème siècle.

> **Données**, adj. pris subst. terme de Mathématique, qui signifie certaines choses ou quantités, qu’on suppose être données ou connues, & dont on se sert pour en trouver d’autres qui sont inconnues, & que l’on cherche. Un problème ou une question renferme en général deux sortes de grandeurs, les données & les cherchées, data & quæsita.[^2]

Jusque-là, on est en plein dans notre contexte, le souhait d'avoir l'éventail du connu pour trouver, dans les replis, ce qui est pour l'instant inconnu, ce qui reste à chercher et à comprendre dans les données.


> *The word “data” is commonly used to refer to records or recordings, statistical observations, collections of evidence*[^3]

Actuellement, nous vivons dans un monde où le terme *big data* est souvent utilisé, mais là encore, sans forcément bien connaître ni pouvoir comprendre quelles sont les données qui sont derrières. 


### Obtenues

> Dans les années 1990, les sociologues des sciences ont critiqué l’usage du mot « donnée » pour désigner des objets en réalité construits, arrachés au terrain au prix d’un temps et d’efforts parfois considérables. Le mot « obtenue » est notamment suggéré par Bruno Latour comme une alternative souhaitable.[^4]

Bruno Latour retourne brillamment ce qu'est une donnée. C'est très intéressant.

> La tentation de l’idéalisme vient peut-être du mot même de données qui décrit aussi mal que possible ce sur quoi s’appliquent les capacités cognitives ordinaires des érudits, des savants et des intellectuels. Il faudrait remplacer ce terme par celui, beaucoup plus réaliste, d’obtenues et parler par conséquent de bases d’obtenues, de sublata plutôt que de data.[^1]

Ce qui est derrière cette notion d'obtenues se voit complété dans le terme "capta", Johanna Drucker :

> Croire que les données sont intrinsèquement quantitatives — évidentes, neutres sur le plan des valeurs et indépendantes de l’observateur — exclut la possibilité de les concevoir comme qualitatives, co-dépendamment constituées — en d’autres termes, de reconnaître que data sont des captas […] Je suggère que nous repensions fondamentalement les données comme des captas en termes d’ambiguïté plutôt que de certitude, et que nous trouvions des moyens d’exprimer graphiquement la complexité de l’interprétation.[^5],  [trad. libre][^4]


<br>

Dans les deux paragraphes suivants, deux temporalités sont distinguées pour inviter à réfléchir à la pluri-disciplinarité dans les (grandes) données et leur analyse. Dans le premier, on s'interroge, en amont, sur les processus et les acteurs produisant la donnée, on y aborde l'exemple de l'information médicale avec le codage des diagnostics ; dans le deuxième, en aval, aux modalités d'analyses de la donnée comme objet fini, et au travers d'elles les différentes perceptions de la donnée.  


## Processus et acteurs de la donnée


<!-- *N.B.: Cette réflexion semble un préalable pour redéfinir une politique publique sur les données de santé : quels rôles pour quels acteurs ? Comment trouver une organisation ensemble ?* -->

### Les processus de production et les acteurs de la donnée

Interroger le concept de donnée nous amène à réfléchir sur les processus et les acteurs de la donnée :

- quels processus permettent d'aboutir à l'obtention des données ?
- quelle est la temporalité, l'ordonnancement de ces processus ?
- la complexité des processus n'induit-elle pas une complexité de la donnée ? Quels impacts ces processus ont-ils sur la donnée ? Quel est le stade au bout duquel on n'interroge plus le concept de données mais celui d'artefact ?
- quels acteurs sont en compétence sur ces processus, lorsque ceux-ci ne sont pas automatiques ? 
- quelle part d'expertise, retenue par ces "producteurs" de la donnée, n'est pas livrée dans la donnée elle-même ?


Comment assurer par la pluri-disciplinarité la garantie que l'ensemble des acteurs rassemblés autour de ces données partagent une connaissance commune de l'ensemble des processus, de la production à l'analyse ? Autrement dit, prudence : est-on bien sûr que l'analyse des données tient compte de la complexité des processus et du crédit des acteurs qui les réalisent ? 

Dans cette étape, on parle de l'observation de processus et d'acteurs, et on s'inscrit avec l'observation dans une pratique scientifique, cette étape modeste de la science où l'on regarde comment sont les choses. *Une fois ces processus bien décrits, il deviendrait même tentant de leur appliquer le critère de reproductibilité !*


<br>

Pour rentrer dans le sujet par un exemple, on propose ici le codage des diagnostics pour les hospitalisations.

### Le diagnostic, une donnée de l'hôpital

Lorsqu'un patient est hospitalisé, il débute un épisode de soins qui amène à la production de nombreuses données (données administratives du patient, description de la prise en charge, actes chirurgicaux, diagnostics des pathologies du patient, documents médicaux rédigés par les médecins et le personnel infirmier, médicaments administrés, couts de prises en charge pour l'établissement, données physiologiques, de laboratoire d'analyse).

Nous nous concentrerons ici sur la fabrication des diagnostics décrivant les pathologies dont le patient est atteint.  

#### Du compte rendu d'hospitalisation au diagnostic

Ces diagnostics appartiennent de manière normative à une classification internationale des maladies (CIM-10) basée sur des codes alpha-numériques : pour faire très simple, 'E66' signifie par exemple "Obésité". C'est un code parmi d'autres qui décrit le motif de prise en charge du patient, ses pathologies associées. Ce diagnostic précis, est codé avec 6 caractères au maximum, au sein d'un système robuste, le programme de médicalisation des systèmes d'information (PMSI) ; il alimente régulièrement les bases de données nationales de santé.

- Ces codes peuvent être "codés" par le médecin ayant pris en charge le patient, en parallèle de la rédaction d'un compte rendu d'hospitalisation ou d'une lettre de sortie, envoyée au médecin traitant.
- Ils peuvent aussi être "codés" par des experts du codage, au sein d'un département spécifique dans l'hôpital : le DIM. Les médecins d'information médicale (MIM) associés à de plus nombreux techniciens (TIM) "convertissent" ce qui a été inscrit dans le compte rendu d'hospitalisation par le médecin ayant pris en charge le patient.
- Ils peuvent aussi être codés de manière automatique ou semi-automatique en fonction des prises en charge du patient (certaines prises en charge ambulatoires)

On le voit sur cet exemple, la donnée "diagnostic de la maladie" et les pathologies associées du patient peuvent être produites de différentes manières, avec un nombre d'acteurs et une temporalité différente. Il n'y a rien de standard dans cette production qui peut varier beaucoup plus selon la pathologie du patient et ceux qui le prennent en charge.

L'information qui en découle apparait normée, car elle se réfère à une classification, mais elle résulte le plus souvent de la lecture et de l'analyse forcément subjective d'au moins un document médical par une personne, et cela pour chaque patient.[^8]   



#### Synthèse

Cette "donnée" est donc loin de couler comme -et d'être aussi claire que- l'eau d'une source. Elle est obtenue, parfois difficilement.


Voici un exemple des processus qui fabriquent les données et leurs artefacts dans les hôpitaux. À l'heure où la moissonneuse batteuse à données de santé (HDH) va se mettre à récolter et, probablement, mélanger des blés de toutes sortes, de toutes qualités. 

La coopérative à données aura des outils intéressants (modèles statistiques, apprentissage profond) pour mesurer la qualité des données, les classifier en différents types de grains, et trouver dans les replis de données massives des réponses à des questions, de nouvelles questions. 

Ce qui n'apparaitra pas dans ces replis, c'est la connaissance de terroir du paysan qui travaille pour obtenir et composer cette donnée au quotidien dans l'hôpital. Il aura pourtant bien coopéré. 



<br>


On développe dans le paragraphe suivant une réflexion sur l'aval : les modalités d’analyses de ces obtenues. 


## Perspectives de la donnée 

### La donnée et le kaléidoscope, l'endroit de nos subjectivités


L'analyse de données a ceci de proche de l'analyse mathématique qu'elle joue avec les échelles. Il y a l'infiniment petit d'une mesure, d'une information, d'un "cas particulier" -le grain de la donnée, et l'infiniment grand de l'ensemble. L'infini exprime ici de manière exagérée la combinaison des intervalles finis qui supportent la donnée dans des dimensions et disciplines nombreuses. Le terme d'"infini" accroche l'esprit car on sent que l'on pourrait s'y perdre[^6]. 


Imbriqués dans différentes échelles successives, les processus de production de la donnée se devinent. Si l'on joue comme on le fait en tournant un kaléidoscope, *un voyage imagé dans les données*, il y aura autant de temps d'arrêts, où le niveau de détail apparait plus net, que de dimensions subjectives et d'expertises requises pour analyser les données. À chaque temps d'arrêt du kaléidoscope, un acteur de la donnée retrouve l'objet de son travail, la netteté dans laquelle il reconnaît une réalité, une familiarité. Il voit net sur sa discipline, mais peut-être un peu flou ailleurs. C'est une expertise qui prend le pouvoir. Ou, pour remplacer l'expertise par un terme moins exclusif, la maîtrise. La formule nous aide : sans elle, la puissance n'est rien. Ou on accélère et tout va plus vite, ce qui est perçu n'est que flou. Ou on élabore en prenant le temps pour éviter ce flou, la maîtrise serait de savoir ce que l'on veut trouver avant de commencer à chercher. 


Cette métaphore du kaléidoscope fonctionne aussi pour le partage démocratique. Savant ou non, le constat, c'est que chacun est ancré dans sa subjectivité : il n'y a pas plus de partage de pouvoir qu'il n'existe d'objectivité si pour chacun l'échelle du zoom est figée. Comme dirait l'autre : "il ne faut pas voir les choses par le petit bout de la lorgnette".

Changer d'angle de vue, de focale, critiquer sa propre position à l'aide d'une nouvelle perspective -celle d'un autre acteur de la donnée par exemple, faciliterait la mise en œuvre d'un partage de connaissances et permettrait ainsi de conquérir le pouvoir complexe qui est dans les données. 

Il faut donc inviter tous ces acteurs à se rassembler autour des données, afin que celles-ci fassent sens.  

Tout ceci repose bien sur l'idée que ce kaléidoscope est dans les mains de tous, avec un objectif commun.

Le problème actuel, c'est que chacun est atomisé dans sa fonction, producteur d'un type d'informations à temps plein. Chacun sa lorgnette. Rien n'a été prévu pour que l'objectif soit partagé. Pas de regards croisés. La donnée semble encore trop considérée comme pur objet informatique à collecter et forer, et non comme le fruit d'une connaissance et d'une expertise qui serait pourtant utile à l'analyse, comme aux travaux d'intelligence artificielle, par exemple.


## Conclusion

L'idée était de remettre en perspective ce qu'est une donnée  -tantôt produite, tantôt obtenue, avec la volonté de mettre en lumière le travail d'équipes dans les hôpitaux, grâce à qui toutes ces données sont disponibles. Et de bien avoir en tête que selon la perspective de l'individu y accédant, la donnée est interprétée de bien différentes manières. 


Ce qui apparait avec ce HealthDataHub, c'est l'œil du pouvoir : mais il faut saisir le prisme des données dans tous ses sens.

N'oublions pas la phrase d'Alain Desrosières selon laquelle faire des statistiques, c'est faire des choses qui tiennent. Il est frappant de lire les articles exposant les principes schématiques de la *data science* : prendre des données du terrain, travailler à les modéliser, apprendre et finalement faire un retour à ceux qui récoltent la donnée avec comme finalité d'un cycle l'amélioration du modèle. C'est-à-dire, probablement, l'essence même du travail statistique. Et l'on peut aussi inscrire dans ce cycle vertueux l'amélioration de la qualité des données.

D'où l'intérêt que les hôpitaux participent aux travaux de cette coopérative à données.  

Que nous gardions bien en tête que la suite menée au sein du HealthDataHub est rendue possible parce que la donnée a été obtenue.  

Perspective avec contre-jour : si cette donnée n'est pas un don du ciel, n'attendons pas le contre-don du ciel.

<br> 

**Guillaume Pressiat**

<br>

[^1]: Latour, B., « Pensée retenue, pensée distribuée », 2007, p. 609.
[^2]: Encyclopédie de Diderot et D’Alembert.
[^3]: Zins, C., « Conceptual approaches for defining data, information, and knowledge », Février 2007. Journal of the American Society for Information Science and Technology, 58(4):479-493. DOI: 10.1002/asi.20508
[^4]: Perret, A. & Le Deuff, O. « Documentarité et données, instrumentation d’un concept ». 12ème Colloque international d’ISKO-France : Données et mégadonnées ouvertes en SHS : de nouveaux enjeux pour l’état et l’organisation des connaissances ? [https://hal.archives-ouvertes.fr/hal-02307039](https://hal.archives-ouvertes.fr/hal-02307039).
[^5]: Drucker J., Humanities Approaches to Graphical Display. Digital Humanities Quarterly [en ligne], 2011. Vol. 5, n° 1. Disponible à l’adresse : [http://digitalhumanities.org/dhq/vol/5/1/000091/000091.html](http://digitalhumanities.org/dhq/vol/5/1/000091/000091.html).
[^6]: C'est désormais un océan de données dans lequel nous vivons, un véritable enjeu qu'il ne s'agit pas d'aborder ici : on ne fait que pressentir les conséquences de notre dépendance à la donnée. Y a t-il un sens à tout cela, quelles seront les conséquences politiques, énergétiques et sociales d'une fuite en avant dans l'âpre monde du tout-donnée (smart-cities, etc.) ?
[^7]: [https://www.hospimedia.fr/actualite/articles/20200615-gestion-les-medecins-dim-rappellent-l-utilite-du](https://www.hospimedia.fr/actualite/articles/20200615-gestion-les-medecins-dim-rappellent-l-utilite-du)
[^8]: *Cette logique structurant l'information hospitalière représente un investissement humain et logiciel pour les hôpitaux réellement conséquent, elle s'inscrit dans le PMSI et a depuis 2008 pour principale finalité le financement des hôpitaux par la tarification à l'activité  -et non pas la recherche, ni l'épidémiologie, ni la lutte contre le COVID - les hôpitaux cherchant à équilibrer leurs finances dans ce système (garder le navire à flot).*
[^9]: [https://www.atih.sante.fr/mesures-de-securite-de-pseudonymisation-des-logiciels-pmsi](https://www.atih.sante.fr/mesures-de-securite-de-pseudonymisation-des-logiciels-pmsi)


