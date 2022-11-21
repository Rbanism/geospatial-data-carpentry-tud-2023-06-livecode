# Load packages ----
library(tidyverse)
library(here)

# install.packages("raster")
# install.packages("rgdal")
library(raster)
library(rgdal)

# View attributes
GDALinfo(here("data", "tud-dsm.tif"))

# Open a raster
DSM_TUD <- raster(here("data", "tud-dsm.tif"))
DSM_TUD




