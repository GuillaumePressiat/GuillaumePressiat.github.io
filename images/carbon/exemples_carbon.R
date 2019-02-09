library(pmeasyr)
library(MonetDBLite)
library(dplyr)
library(stringfix)

# noyau de paramètre
library(pmeasyr)
p <- noyau_pmeasyr(finess = '750712184', 
                   annee = 2018, 
                   mois = 12, 
                   path   = '~/Documents/data/mco/', 
                   tolower_names = TRUE,
                   # n_max = 1e4,
                   lib = FALSE)

# Dézipper le fichier en sortie de genrsa
adezip(p, type = "out")

# Importer des données
rsa <- irsa(p, typi = 6)
ano <- iano_mco(p)
med <- imed_mco(p)
dmi <- idmi_mco(p)

# Case-mix et DMS 
library(dplyr)
cm <- rsa$rsa %>% group_by(ghm, noghs) %>%
  summarise(dms = mean(duree[duree > 0]),
            effectif = n(),
            effectif_sup0 = sum(duree > 0))

# Lancer des requêtes 
library(nomensland)
rsa <- rsa %>% 
  prepare_rsa

# chirurgie de l'obésite
chir_obesite <- get_all_listes("Chirurgie bariatrique")
sejours_chir_obesite <- lancer_requete(rsa, chir_obesite)

# Recours exceptionnel
recours_exc <- get_all_listes("Recours Exceptionnel")
sejours_recours_exc <- lancer_requete(rsa, recours_exc)

# requête ad hoc
exemple_requete <- list(
  actes = c('QEFA003','QEFA005','QEFA010','QEFA013','QEFA015','QEFA019','QEFA020')
)
sejours_qefa <- requete(rsa, exemple_requete)

# Données en base
dbdir <- "~/Documents/data/monetdb"
con <- MonetDBLite::src_monetdblite(dbdir)
tbl_mco(con, 18, 'rsa_rsa')
tbl_mco(con, 18, 'rsa_actes')
tbl_mco(con, 18, 'rsa_diags')
tbl_mco(con, 18, 'rsa_um')

# requête en base
exemple_requete <- list(
  actes = c('QEFA003','QEFA005','QEFA010',
            'QEFA013','QEFA015','QEFA019',
            'QEFA020')
)
sejours_qefa <- requete_db(con, 18, exemple_requete)

# Valoriser les rsa

## Tarifs et suppléments
library(nomensland)
tarifs_ghs  <- get_table('tarifs_mco_ghs') %>% 
  distinct(ghs, anseqta, .keep_all = TRUE)
supplements <- get_table('tarifs_mco_supplements') %>% 
  mutate_if(is.numeric, tidyr::replace_na, 0)

# rsa et ano sont préparés
vrsa <- vvr_rsa(con, 18)
vano <- vvr_ano_mco(con, 18)


rsa_valo <- vvr_mco(
  # on calcule la valorisation des séjours
  vvr_ghs_supp(rsa = vrsa, 
               tarifs = tarifs_ghs, 
               supplements =  tarifs_supp, 
               ano = vano, 
               porg = ipo(p), 
               diap = idiap(p), 
               pie = ipie(p), 
               full = FALSE,
               cgeo = 1.07, 
               prudent = NULL,
               bee = FALSE),
  # on attribue le caractère facturable au séjour
  vvr_mco_sv(vrsa, vano, ipo(p))
)

# on peut reproduire les tableaux epmsi
epmsi_mco_sv(valo_rsa, knit = TRUE)
epmsi_mco_rav(valo, knit = TRUE)


