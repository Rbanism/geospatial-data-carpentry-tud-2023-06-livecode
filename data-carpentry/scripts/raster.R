# Load packages
library(tidyverse)
library(here)
library(raster)
library(rgdal)

# View Raster File Attributes

GDALinfo(here("data", "tud-dsm-5m.tif"))

# Open raster

DSM_TUD <- raster(here("data", "tud-dsm-5m.tif"))
DSM_TUD

summary(DSM_TUD)
