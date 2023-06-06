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
summary(DSM_TUD, maxsamp = ncell(DSM_TUD))

DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)
str(DSM_TUD_df)
head(DSM_TUD_df)

ggplot() +
  geom_raster(data = DSM_TUD_df, 
              aes(x = x, y = y, fill = tud.dsm.5m)) +
  scale_fill_viridis_c() +
  coord_quickmap()

plot(DSM_TUD)  
  
# View Raster CRS

crs(DSM_TUD)
  
  
  
  
  
