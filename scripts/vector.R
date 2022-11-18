# Load packages ----
library(tidyverse)
library(here)

# install.packages("sf")
library(sf)

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
