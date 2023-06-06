# Load packages
library(tidyverse)
library(here)
library(raster)
library(rgdal)

# View Raster File Attributes

GDALinfo(here("data", "tud-dsm-5m.tif"))
