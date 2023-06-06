library(tidyverse)
library(sf)
#install.packages("osmdata")
library(osmdata)

bb <- getbb("Brielle", format_out = "sf_polygon" )
bb

bbnl <- getbb("Brielle, NL", format_out = "data.frame")
bbnl

x <- opq(bbox = bbnl) %>%
  add_osm_feature(key = "building") %>%
  osmdata_sf()

assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

buildings <- x$osm_polygons
head(buildings)
