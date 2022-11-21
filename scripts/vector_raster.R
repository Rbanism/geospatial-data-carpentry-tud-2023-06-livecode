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


buildings <- x$osm_polygons %>% 
  st_transform(.,28992)


str(buildings$start_date)

buildings$start_date <- as.numeric(buildings$start_date)


ggplot() +
  geom_sf(data = buildings, 
          aes(fill = start_date, colour= start_date)) +
  scale_fill_viridis_c(option="viridis") +
  coord_sf(datum=st_crs(28992))


min(buildings$start_date)
