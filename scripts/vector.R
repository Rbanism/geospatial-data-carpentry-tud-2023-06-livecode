# Load packages ----
library(tidyverse)
library(here)

# install.packages("sf")
library(sf)


# Open and plot shapefiles ----
boundary_Delft <- st_read(here("data", "delft-boundary.shp"))

st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)

boundary_Delft <- st_transform(boundary_Delft, 28992)
st_crs(boundary_Delft)

st_bbox(boundary_Delft)

ggplot(data = boundary_Delft) + 
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  ggtitle("Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))

# Challenge 1
lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

class(lines_Delft)
class(point_Delft)

st_crs(lines_Delft)
st_crs(point_Delft)

st_bbox(lines_Delft)
st_bbox(point_Delft)

# Explore and plot by vector layer attributes ----
lines_Delft
names(lines_Delft)
ncol(lines_Delft)

head(lines_Delft)
head(lines_Delft, 10)

point_Delft
names(point_Delft)
head(point_Delft, 10)

lines_Delft

head(lines_Delft$highway)

levels(factor(lines_Delft$highway))

cycleway_Delft <- lines_Delft %>% 
  filter(highway == "cycleway")

nrow(cycleway_Delft)
nrow(lines_Delft)

cycleway_Delft_lengths <- cycleway_Delft %>% 
  mutate(length = st_length(cycleway_Delft))

cycleway_Delft_lengths %>% 
  summarise(total_length = sum(length))

ggplot(data = cycleway_Delft) + 
  geom_sf() +
  ggtitle("Slow mobility network of Delft", subtitle = "Cycleways") +
  coord_sf(datum = st_crs(28992))

# Challenge 2

ncol(point_Delft)
ncol(boundary_Delft)

head(point_Delft)
head(point_Delft, 10)

point_Delft

names(point_Delft)

# Challenge 3

levels(factor(lines_Delft$highway))

motorway_Delft <- lines_Delft %>% 
  filter(highway == "motorway")

motorway_Delft %>% 
  mutate(length = st_length(motorway_Delft)) %>% 
  select(everything(), geometry) %>%
  summarise(total_length = sum(length))

nrow(motorway_Delft)

ggplot(data = motorway_Delft) +
  geom_sf(size = 1.5) +
  ggtitle("Mobility network of Delft", subtitle = "Motorways") +
  coord_sf()

pedestrian_Delft <- lines_Delft %>% 
  filter(highway == "pedestrian")

nrow(pedestrian_Delft)

ggplot(data = pedestrian_Delft) +
  geom_sf() +
  ggtitle("Slow mobility network of Delft", subtitle = "Pedestrian") +
  coord_sf()

# Costomize plots
levels(factor(lines_Delft$highway))

road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft %>% 
  filter(highway %in% road_types) %>% 
  mutate(highway = factor(highway, levels = road_types))

levels(lines_Delft_selection$highway)

road_colors <- c("blue", "green", "navy", "purple") 

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway)) +
  scale_color_manual(values = road_colors) +
  coord_sf(datum = st_crs(28992))

line_widths <- c(1, 0.75, 0.5, 0.25)

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway, size = highway)) +
  scale_color_manual(values = road_colors) +
  scale_size_manual(values = line_widths) +
  coord_sf(datum = st_crs(28992)) +
  ggtitle("Mobility network of Delft",
          subtitle = "Roads and Cycleways") +
  labs(color = "Road Types", size = "Road Types")

# Challenge 5

class(lines_Delft_selection$highway)

levels(factor(lines_Delft_selection$highway))

lines_Delft_bicycle <- lines_Delft %>% 
  filter(highway == "cycleway")

ggplot() +
  geom_sf(data = lines_Delft) +
  geom_sf(data = lines_Delft_bicycle, color = "magenta", size = 2) +
  ggtitle("Mobility network of Delft", subtitle = "Roads dedicated to bikes") +
  coord_sf()
