library(networkD3)
library(dplyr)
networkData <- tibble::tribble(
  ~ src, ~ target,
  "pmeasyr",   "MCO",
  "pmeasyr",   "SSR",
  "pmeasyr",   "HAD",
  "pmeasyr",   "Psy",
  "pmeasyr",   "RSF",
  "pmeasyr",   "requetr",
  "pmeasyr",   "vvr",

  
  "nomensland",   "CCAM",
  "nomensland",   "CIM-10",
  "nomensland",   "GHM - RGHM",
  "nomensland",   "GHS - Suppléments",
  "nomensland",   "LPP",
  "nomensland",   "CSARR",
  "nomensland",   "Orpha.net",
  "nomensland",   "Listes de requêtes",

  "shinyapps"     ,   "oncle_cim",
  "shinyapps"     ,   "Transcodeur",
  "shinyapps"     ,   "oncle_cccam",
  "shinyapps"     ,   "oncle_ghm") %>% as.data.frame()
  
  
# Plot
simpleNetwork(networkData, zoom = TRUE, nodeColour = '#002fa7', opacity = 0.8, fontSize = 13, 
              fontFamily = 'Helvetica', linkColour = 'cornflowerblue', linkDistance = 100, charge = -65) %>%
  saveNetwork(file = 'connexes.html')

# "*** Restitutions ***", "theme_latex_aphp", # "*** Restitutions ***", "rmdformats", # "*** Restitutions ***", "markdowntemplates", # "*** Restitutions ***", "sharigan") %>% as.data.frame()

