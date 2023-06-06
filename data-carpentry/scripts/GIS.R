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

library(leaflet)

buildings2 <- x$osm_polygons
buildings2$build_date <- 
  if_else(as.numeric(buildings2$start_date) < 1900,
          1900, as.numeric(buildings2$start_date))


leaflet(buildings2) %>%
  addTiles() %>%
 # addProviderTiles(provider = providers$CartoDB.Positron) %>%
  addPolygons(fillColor = 
                ~colorQuantile("YlOrRd", build_date)(build_date))



### GIS Operations - Conservation

old <- 1800

buildings %>% 
  filter(as.numeric(start_date) <= old) %>%
  ggplot() + 
  geom_sf()
  





