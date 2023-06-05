library(tidyverse)
library(here)
library(sf)

# Open a shapefile
boundary_Delft <- st_read(here("data", "delft-boundary.shp"))

# Examine the metadata
st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)

boundary_Delft <- st_transform(boundary_Delft, 28992)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)

boundary_Delft

# Plot a shapefile

ggplot(data = boundary_Delft) +
  geom_sf(linewidth = 1, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))

# Challenge 1

lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

st_crs(lines_Delft)
st_crs(point_Delft)

st_crs(lines_Delft)$epsg
st_crs(lines_Delft)$Name

lines_Delft
point_Delft
