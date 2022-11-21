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
min(buildings$start_date, na.rm=TRUE)

buildings$start_date <- as.numeric(buildings$start_date)

buildings$start_date_simplified <- 
  ifelse(buildings$start_date <= 1900, 1900, 
         buildings$start_date)


ggplot() +
  geom_sf(data = buildings, 
          aes(fill = start_date_simplified, 
              colour= start_date_simplified)) +
  scale_fill_viridis_c(option="viridis") +
  scale_colour_viridis_c(option="viridis") +
  coord_sf(datum=st_crs(28992))


# Conservation in Delft ------

bb <- getbb("Delft", format_out = "sf_polygon")

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()

buildings <- x$osm_polygons %>% 
  st_transform(.,28992)

buildings$start_date <- as.numeric(buildings$start_date)

old <- 1800
distance <- 500

old_buildings <- buildings |>
  filter(start_date <= old)

buffer_old_buildings <- st_buffer(old_buildings, 
                                  dist = distance)

ggplot(data = buffer_old_buildings) +
  geom_sf()

single_buffers <- st_union(buffer_old_buildings) |>
  st_cast(to = "POLYGON") |>
  st_as_sf()

single_buffers <- single_buffers %>%
  add_column("ID" = as.factor(1:nrow(.))) %>%
  st_transform(., crs=28992)

ggplot(single_buffers) + geom_sf()

sf::sf_use_s2(FALSE)
centroids_old_buildings <- st_centroid(old_buildings) %>%
  st_transform(., crs=28992)
