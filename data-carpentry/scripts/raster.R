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

# Min and Max values

minValue(DSM_TUD)
maxValue(DSM_TUD)

DSM_TUD <- raster::setMinMax(DSM_TUD)

# Raster bands

nlayers(DSM_TUD)

# Histogram of raster values

ggplot() +
  geom_histogram(data = DSM_TUD_df, aes(tud.dsm.5m))
  
ggplot() +
  geom_histogram(data = DSM_TUD_df, aes(tud.dsm.5m), bins = 40)

# Challenge 1

GDALinfo(here("data", "tud-dsm-5m-hill.tif"))

# Plot Raster Data

DSM_TUD_df <- DSM_TUD_df %>% 
  mutate(fct_elevation = cut(tud.dsm.5m, breaks = 3))

head(DSM_TUD_df)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation))

DSM_TUD_df %>% 
  group_by(fct_elevation) %>% 
  count()

custom_bins <- c(-10, 0, 5, 100)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation_cb))
head(DSM_TUD_df)

DSM_TUD_df <- DSM_TUD_df %>% 
  mutate(fct_elevation_cb = cut(tud.dsm.5m, breaks = custom_bins))
head(DSM_TUD_df)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x,
                                     y = y,
                                     fill = fct_elevation_cb)) +
  coord_quickmap()
