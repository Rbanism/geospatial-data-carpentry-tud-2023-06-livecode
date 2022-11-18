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
  mutate(length = st_length(.))

cycleway_Delft_lengths %>% 
  summarise(total_length = sum(length))


