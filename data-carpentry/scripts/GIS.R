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

buildings <- x$osm_polygons %>%
  st_transform(28992)

buildings$build_date <- 
 if_else(as.numeric(buildings$start_date) < 1900,
         1900, as.numeric(buildings$start_date))

ggplot(data = buildings) +
  geom_sf(aes(fill = build_date, 
              colour = build_date)) +
  scale_fill_viridis_c(option = "viridis") +
  scale_colour_viridis_c(option = "viridis")
