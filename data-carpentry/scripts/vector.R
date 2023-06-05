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
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  labs(title)







