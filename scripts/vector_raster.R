#### ---- OSM data Extraction

library(tidyverse)
library(here)
#install.packages("osmextract")
library(osmextract)
library(sf)
#install.packages("remotes")
#library(remotes)
#remotes::install_github("ropensci/osmdata")
library(osmdata)

bb <- getbb("Delft", format_out = "sf_polygon")
bb


assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()

head(x)


buildings <- st_transform
