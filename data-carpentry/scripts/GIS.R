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

old <- 1939

old_buildings <- buildings %>% 
  filter(as.numeric(start_date) <= old) 
  
ggplot(old_buildings) + 
  geom_sf()
  
distance <- 10

buffer_old_bldgs <- 
  st_buffer(x = old_buildings, dist = distance)

ggplot(buffer_old_bldgs) +
  geom_sf()

single_old_buffer <- st_union(buffer_old_bldgs) %>%
  st_cast(to = "POLYGON") %>%
  st_as_sf() %>%
  mutate("ID" = as.factor(1:nrow(.)))

ggplot(single_old_buffer) +
  geom_sf()

old_centroids <- st_centroid(old_buildings)

ggplot() +
  geom_sf(data = single_old_buffer, aes(fill=ID)) +
  geom_sf(data = old_centroids)

centroids_intersect_buffers <- 
  st_intersection(old_centroids, single_old_buffer) %>%
  mutate(n = 1)

multipoint_blgds <- centroids_intersect_buffers %>%
  group_by(ID) %>%
  summarise(N_buildings = sum(n))

final_zones <- single_old_buffer %>%
  mutate(N_buildings = multipoint_blgds$N_buildings)

ggplot() +
  geom_sf(data = buildings) +
  geom_sf(data = final_zones, 
          aes(fill = N_buildings),
          colour = NA) +
  scale_fill_viridis_c(
    alpha = 0.6,
    begin = 0.6,
    end = 1,
    direction = -1,
    option = "B")

final_zones$surface <- 
  st_area(final_zones) %>%
  units::set_units(.,km^2)

final_zones$density <-
  final_zones$N_buildings / 
  final_zones$surface

summary(final_zones$density)

ggplot() +
  geom_sf(data = buildings2) +
  geom_sf(data = final_zones,
          aes(fill = density),
          colour = NA) + 
  scale_fill_viridis_c(
    alpha = 0.6,
    begin = 0.6,
    end = 1,
    direction = -1,
    option = "B")
