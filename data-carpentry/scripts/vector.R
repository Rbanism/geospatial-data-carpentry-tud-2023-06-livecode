library(tidyverse)
library(here)
library(sf)

# Open a shapefile

boundary_Delft <- st_read(here("data", "delft-boundary.shp"))
