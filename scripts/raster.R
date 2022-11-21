# Load packages ----
library(tidyverse)
library(here)

# install.packages("raster")
# install.packages("rgdal")
library(raster)
library(rgdal)

# Wiew attributes
GDALinfo(here("data", "tud-dsm.tif"))

