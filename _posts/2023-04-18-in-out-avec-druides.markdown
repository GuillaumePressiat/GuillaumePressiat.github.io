---
layout: post
title: "Reproduire des in / out MCO à partir des zip.zip.zip de Druides"
date: 2023-04-18 09:05:50 +0100
author: Guillaume Pressiat
tags: pmeasyr
categories: Programmation
comments: true
---


Comment regénérer des in / out sur la version de test de Druides 0.7.4.0 ?


<!--more-->

## Contexte


## Code


{% highlight r %}

library(dplyr)

# Répertoire de travail temporaire
setwd('~/../Downloads/in_out/')

# druides a tourné et généré ce fichier zip
# 290000017.2023.0.SEJOURS.SEJOURS.xxxxxxxxxxxxxxxx.zip

# Placer ce dernier fichier généré dans par druides dans le répertoire par exemple :
# ~/../Downloads/in_out/druides_out/202302

# Lister les fichiers (récupérer le nom du zip dynamiquement)
liste_in_out <- list.files('druides_out/202302', full.names = TRUE)

# récupérer les paramètres classiques type noyau_pmeasyr depuis le nom du zip
finess <- basename(liste_in_out)[1] %>% stringr::str_split('\\.') %>% .[[1]] %>% .[1]
annee  <- basename(liste_in_out)[1] %>% stringr::str_split('\\.') %>% .[[1]] %>% .[2]
mois   <- basename(liste_in_out)[1] %>% stringr::str_split('\\.') %>% .[[1]] %>% .[3]

# générer un timestamp sur la date de création du zip
# TODO : case when si plateforme unix alors ctime, sinon mtime (windows)
timestamp_druides <- file.info(liste_in_out[1])$mtime %>% format('%d%m%Y%H%M%S')
# générer deux noms de répertoires type in et out horodaté ; finess.annee.mois.horodate.in et out
in_repos <- paste0(finess, '.', annee, '.', mois, '.', timestamp_druides, '.in')
out_repos <- paste0(finess, '.', annee, '.', mois, '.', timestamp_druides, '.out')

# On extrait les fichiers "matriochkas"
unzip(liste_in_out[grepl('zip', liste_in_out)], exdir = 'temp____00')
# pour le in > in4ctl ne contient que um et rss ré-arrangé, et un tra formaté csv
unzip(list.files('temp____00', pattern = 'data.zip', full.names = TRUE), exdir = 'temp____01')
unzip(list.files('temp____01', pattern = 'in4ctl.zip', full.names = TRUE), exdir = in_repos)
R.utils::gunzip(list.files('temp____01', pattern = 'in.gzip', full.names = TRUE), ext = "gzip")

# pour le out > basket contient tout le out.zip sauf le tra
unzip(list.files('temp____01', pattern = 'basket.zip', full.names = TRUE), exdir = 'temp_out_01')
unzip(list.files('temp____01', pattern = 'log', full.names = TRUE), exdir = 'temp_out_01')
unzip(list.files('temp_out_01', pattern = 'data.zip', full.names = TRUE), exdir = 'temp_out_02')
unzip(list.files('temp_out_02', pattern = 'data2.zip', full.names = TRUE), exdir = out_repos)



# move tra > et le reformater "comme avant"
tra_link <- list.files(in_repos, pattern = '\\.tra', full.names = TRUE)
tra_l <- readr::read_csv2(tra_link, col_names = c('finess', 'pkrsa', 'nas', 'norss', 'dtent', 'dtsort', 'filler'))
tra_l <- tra_l %>% 
  mutate(dtent = format(dtent, '%d%m%Y'),
         ghm = '      ',
         no_rss_ent = stringr::str_pad('',10, 'right', '0'),
         norss = stringr::str_pad(norss, 20, 'right', ' '),
         nas = stringr::str_pad(nas, 20, 'right', ' '),
         dtsort = format(dtsort, '%d%m%Y')) %>% 
  glue::glue_data('{pkrsa}{norss}{no_rss_ent}{nas}{dtent}{ghm}{dtsort}')

readr::write_lines(tra_l, file.path(out_repos, basename(tra_link)))
# file.copy(tra_link, out_repos)

file_in_sejours <- list.files('temp____01', pattern = 'SEJOURS\\.SEJOURS.*\\.in$', full.names = FALSE)

# pour la partie RSS et les in on utilise le json
json_rss <- jsonlite::read_json(paste0('temp____01/',
                                       file_in_sejours), simplifyVector = TRUE)

contenus <- names(json_rss$dossiers[[1]])

mappe_in <- tibble::tribble(
  ~contenu,      ~file_in,
  "dossierId",        NA,
  "dateEntreeSejour", NA,
  "dateSortieSejour", NA,
  "dateNaissance",    NA,
  "topmaisnais",      NA,
  "anohosp",          "ano.txt",
  "rums",             "rss.txt",
  "iums",             "ium.txt",
  "meds",             "med.txt",
  "dmis",             "dmi.txt",
  "porgs",            "porg.txt",
  "pies",             "pie.txt",
  "dips",             "diap.txt",
  "ivgs",             "ivg.txt",
  "maisnaiss",        NA,
  "transps",          "transp.txt",
  "immunos",          NA,
  "dmintraghs",       NA,
  "sexe",             NA,
  "estDecede",        NA
)

extract_json_in <- function(json_rss, contenu){
  json_rss$dossiers %>% 
    purrr::map(contenu) %>% 
    unlist() %>% 
    .[!is.na(.)]
}

# contenu1 <- 'dmis'
write_like_in <- function(contenu1, json_rss,  mappe_in){
  file_in <- mappe_in %>% filter(contenu == contenu1) %>% pull(file_in)
  extract_json_in(json_rss, contenu1) -> temp
  
  if (contenu1 == 'iums'){
    temp <- unique(temp)
  }
  readr::write_lines(temp, paste0(in_repos, '/', finess, '.', annee, '.', mois,'.', file_in))
  TRUE
}


mappe_in %>% 
  filter(!is.na(file_in)) %>% 
  pull(contenu) %>% 
  # .[1:2] %>% 
  purrr::map(write_like_in, json_rss, mappe_in)


# remap mois2 to mois1
to_rename <- list.files(in_repos, full.names = TRUE)
fichier <- to_rename[1]
rename_mois <- function(fichier, finess, annee, mois){
  fichier_renome <- stringr::str_replace(fichier, 
                                         paste0('\\/', finess, '.', annee, '.', stringr::str_pad(mois, 2, 'left', '0')),
                                         # paste0('\\/', finess, '.', annee, '.', mois)
                                         paste0('\\/', finess, '.', annee, '.', 2)
                                         )
  file.rename(fichier, fichier_renome)
}

purrr::map(to_rename, rename_mois, finess, annee, mois)
to_rename <- list.files(out_repos, full.names = TRUE)
purrr::map(to_rename, rename_mois, finess, annee, mois)

log_file <- list.files('temp_out_01/', pattern = "log.json", full.names = TRUE)
log_json <- jsonlite::read_json(log_file, simplifyVector = TRUE)

unnest_errors <- function(log_json, type1){
  log_json %>% 
    as_tibble() %>% 
    filter(Type == type1) %>% 
    mutate(nb_errors = purrr::map_dbl(Errors, function(x)length(x))) %>% 
    filter(nb_errors > 0) %>% 
    select(-Type) %>% 
    group_by(Id) %>% 
    tidyr::unnest(Errors) %>% 
    ungroup %>% 
    tidyr::separate(Id, c('nas', 'norss', 'dtent', 'dtsort'), sep = "\\@")
}

liste_type <- count(log_json, Type) %>% pull(Type)

liste_erreurs <- purrr::map(liste_type, unnest_errors, log_json = log_json)
names(liste_erreurs) <- liste_type

toutes_erreurs <- bind_rows(liste_erreurs)

readr::write_csv2(toutes_erreurs, paste0(out_repos, '/', finess, '.', annee, '.', mois, '.', 'erreurs.csv'))

zip(zipfile = paste0(in_repos, '.zip'), files = list.files(in_repos, full.names = TRUE),
         flags = '-r9Xj')
zip(paste0(out_repos, '.zip'), list.files(out_repos, full.names = TRUE),
    flags = '-r9Xj')


unlink(list.files(pattern = 'temp_'), recursive = TRUE)

# library(pmeasyr)
# adezip(290000017, 2023, 0, '.', type = "out")
# 
# irsa(290000017, 2023, 2, '.')
# 
# iano_mco(290000017, 2023, 2, '.') %>% count(FACTAM)
# 
# imed_mco(290000017, 2023, 2, '.')
# 
# adelete(290000017, 2023, 2, '.')
# 

{% endhighlight %}

