# Distribution map made for Salix babylonica using R code 

library(devtools)    
library(usethis)
library(rnaturalearthdata)
library(countrycode)
library(CoordinateCleaner)
library(dplyr)
library(ggplot2)
library(rgbif)
library(sp)

tremulaitem <- occ_search(scientificName = "Populus tremula", limit = 99900, hasCoordinate = T)
tremulaitem <-tremulaitem$data
tremulaitem <- tremulaitem %>%
  dplyr::select(species, decimalLongitude, decimalLatitude, countryCode, individualCount,
                gbifID, family, taxonRank, coordinateUncertaintyInMeters, year,
                basisOfRecord, institutionCode, datasetName)
tremulaitem <- tremulaitem%>%
  filter(!is.na(decimalLongitude))%>%
  filter(!is.na(decimalLatitude))
wm <- borders("world", colour="gray50", fill="gray50")
ggplot()+ coord_fixed()+ wm +
  geom_point(data = tremulaitem, aes(x = decimalLongitude, y = decimalLatitude),
             colour = "darkred", size = 0.5)+
  theme_classic()

write.csv(tremulaitem)
write.csv(tremulaitem,"/Users/elvisyung/Desktop/TREMULA_DISTRIBUTION.csv", row.names = TRUE)

