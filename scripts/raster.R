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

summary(DSM_TUD)
summary(DSM_TUD, maxsamp = ncell(DSM_TUD))

DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)
str(DSM_TUD_df)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y, fill = tud.dsm)) +
  scale_fill_viridis_c() +
  coord_quickmap()

plot(DSM_TUD)

# View CRS 
crs(DSM_TUD)

# Calculate the Min and Max value of a raster
minValue(DSM_TUD)
maxValue(DSM_TUD)

setMinMax
