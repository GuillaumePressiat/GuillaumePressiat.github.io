---
layout: post
title: "pmsi-io 0.4.1 et Transcoder 0.2.0"
date: 2026-07-12 15:05:05 +0100
author: Guillaume Pressiat
categories: [Application, "Mise à jour"]
tags: [rust, pmsi, shiny, "cim & ccam", finess]
comments: true
---


<br>

Je partage ici deux travaux réalisés ces dernières semaines : une mise à jour de **pmsi-io**, l'application bureau de traitement des données PMSI MCO, et une nouveauté en application de bureau et WebAssembly, **Transcoder**, port natif de l'application Shiny de transcodage de listes de codes.
 
![Aperçu explorateur](https://guillaumepressiat.github.io/pmsi-io/assets/light/7-explorer-example-2.png)
 
![Aperçu thème clair](https://github.com/GuillaumePressiat/transcoder/blob/main/assets/screenshot_light.png?raw=true)
<!--more-->

## pmsi-io 0.4.1

[![pmsi-io](https://github.com/user-attachments/assets/e7838cb6-00d6-4bd3-9d3b-d6eaa560df4f){: width="120" style="float:right; margin-left: 1em;"}](https://guillaumepressiat.github.io/pmsi-io/)

[pmsi-io](https://guillaumepressiat.github.io/pmsi-io/) est une application bureau pour le traitement des données PMSI MCO (RSA, RSS, fichiers ATIH). Elle tourne entièrement en local.
 
### 0.4.0 : refonte majeure
 
La 0.4.0 représente une extension significative sur deux axes.
 
**Deux nouveaux onglets :**
 
- **Requêtes** : sélection et exécution de requêtes PMSI pré-établies par thématique
- **Requête Lab'** : constructeur de requêtes personnalisées (GHM, diagnostics, actes, âge, poids, durée), sauvegarde, export JSON, partage entre utilisateurs

![Aperçu requêtes](https://guillaumepressiat.github.io/pmsi-io/assets/light/2-requete.png)
 
**Robustesse Rust :**
 
- Type d'erreur unifié `PmsiError` via `thiserror` : les erreurs remontent proprement jusqu'au frontend
- Migration Tauri v1 → v2, migration Svelte 4 → Svelte 5 (runes)

### 0.4.1 : Explorateur de données
 
Le gros ajout de cette version : un onglet **Explorer** pour analyser visuellement les résultats de requêtes RSA sans export disque.
 
![Aperçu explorateur](https://guillaumepressiat.github.io/pmsi-io/assets/light/6-pyramid.png)
 
- **Pivot table** : sélection des axes lignes/colonnes, agrégations (count, somme, moyenne, min, max), tri alphabétique ou par effectif
- **6 types de graphiques interactifs** via ECharts : barres, courbes, camembert, heatmap, river, pyramide des âges
- Calcul pivot entièrement côté Rust/Polars (`group_by` + agrégation sur LazyFrame) : aucune écriture sur disque
- **Tutoriel** : pastilles numérotées ① à ⑥ guidant les nouveaux utilisateurs, désactivables
- **Switcher de thème** clair/sombre persisté


- Frontend : SvelteKit 2 + Svelte 5
- Backend : Rust + Polars
- environnement de développement : Tauri 2


---

<br>

## Transcoder 0.2.0

[![Transcoder](https://github.com/GuillaumePressiat/transcoder/blob/main/src-tauri/icons/ios/AppIcon-512@2x.png?raw=true){: width="120" style="float:right; margin-left: 1em;"}](https://github.com/GuillaumePressiat/transcoder)

**Transcoder** est le port natif de la Shiny app [stringfix/transcoder](https://guillaumepressiat.shinyapps.io/transcodeur/), un outil du quotidien en info médicale pour reformater des listes de codes (CIM-10, CCAM, FINESS, identifiants patients) entre différents formats : liste vecteurs quotés, clause SQL `%LIKE%`, pipe pour les regexp.

![Aperçu thème sombre](https://github.com/GuillaumePressiat/transcoder/blob/main/assets/screenshot.png?raw=true)

<!-- ![Aperçu thème clair](https://github.com/GuillaumePressiat/transcoder/blob/main/assets/screenshot_light.png?raw=true) -->

### Application bureau (Tauri)

La version 0.2.0 apporte par rapport à la Shiny originale :

- Thème clair / sombre avec persistance
- Historique des 50 dernières transformations (dédoublonné, non persistant, comme les listes peuvent contenir des données patients)
- Copie automatique dans le presse-papier à chaque transformation
- Raccourcis clavier : `Ctrl+Entrée`, `Ctrl+1/2/3`, `Ctrl+H`, `Ctrl+L`


### Version web (WASM)

La logique de transcodage Rust est compilée en **WebAssembly** via `wasm-pack` et tourne directement dans le navigateur : sans serveur, sans installation, sans données envoyées à l'extérieur.

**[guillaumepressiat.github.io/transcoder](https://guillaumepressiat.github.io/transcoder/)**

Le résultat est une page statique hébergée sur GitHub Pages. Le code source de la version web est dans la branche [`wasm`](https://github.com/GuillaumePressiat/transcoder/tree/wasm).


- Logique : Rust → WASM (wasm-pack)
- Frontend : SvelteKit 2 + Svelte 5
- Deploy : GitHub Pages (Actions)

---

<br>

## Installer les applications 

Les versions en application de bureau, pour mac (dmg, arm, intel ou universal), windows (exe ou msi) et linux (rpm, deb ou appimage) sont disponibles aux pages suivantes : 

[pmsi-io](https://github.com/GuillaumePressiat/pmsi-io/releases) · [transcoder](https://github.com/GuillaumePressiat/transcoder/releases)

 
---

<br>

Les deux applications tournent entièrement en local, souhaitable dans un environnement hospitalier.


Code source : [github.com/GuillaumePressiat](https://github.com/GuillaumePressiat)
