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

DSM_TUD <- raster::setMinMax(DSM_TUD)

minValue(DSM_TUD)
maxValue(DSM_TUD)

# Raster bands
nlayers(DSM_TUD)

# Histogram
ggplot() +
  geom_histogram(data = DSM_TUD_df, aes(tud.dsm))

ggplot() +
  geom_histogram(data = DSM_TUD_df, aes(tud.dsm), bins = 40)

# Challenge 1 

# Use `GDALinfo()` to determine the following about the `tud-dsm-hill.tif` file:
#   
#   1. Does this file have the same CRS as `DSM_TUD`?
#   2. What is resolution of the raster data?
#   3. How large would a 5x5 pixel area be on the Earth’s surface?
#   4. Is the file a multi- or single-band raster?

GDALinfo(here("data","tud-dsm-hill.tif"))

# Plot raster data ----

DSM_TUD_df <- DSM_TUD_df %>% 
  mutate(fct_elevation = cut(tud.dsm, breaks = 3))

DSM_TUD_df <- DSM_TUD_df %>% 
  dplyr::select(-`fct_elevation <- cut(tud.dsm, breaks = 3)`)
  
str(DSM_TUD_df)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation))

DSM_TUD_df %>% 
  group_by(fct_elevation) %>% 
  count()

custom_bins <- c(-10, 0, 5, 100)

head(DSM_TUD_df)

DSM_TUD_df <- DSM_TUD_df %>% 
  mutate(fct_elevation_cb = cut(tud.dsm, breaks = custom_bins))

head(DSM_TUD_df)

unique(DSM_TUD_df$fct_elevation_cb)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation_cb))

my_col <- terrain.colors(3)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y,
                                     fill = fct_elevation_cb)) +
  scale_fill_manual(values = my_col) +
  coord_quickmap()
  



