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
  
# Layering rasters ----

DTM_TUD <- raster(here("data", "tud-dtm.tif"))
DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)

DTM_hill_TUD <- raster(here("data", "tud-dtm-hill.tif"))
DTM_hill_TUD_df <- as.data.frame(DTM_hill_TUD, xy = TRUE)

str(DTM_TUD_df)
str(DTM_hill_TUD_df)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dtm)) +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.hill)) +
  scale_fill_viridis_c() +
  scale_alpha(range = c(0.4, 0.7), guide = "none") +
  ggtitle("DTM with Hillshade") +
  coord_quickmap()

# Reprojecting raster data
DTM_TUD <- raster(here("data", "tud-dtm.tif"))
DTM_hill_TUD <- raster(here("data", "tud-dtm-hill.tif"))
DTM_hill_TUD_ETRS89 <- projectRaster(DTM_hill_TUD, crs = 4258)

DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DTM_hill_TUD_ETRS89_df <- as.data.frame(DTM_hill_TUD_ETRS89, xy = TRUE)

str(DTM_hill_TUD_ETRS89_df)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dtm)) +
  geom_raster(data = DTM_hill_TUD_ETRS89_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.hill)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()

DTM_hill_TUD_EPSG28992 <- projectRaster(DTM_hill_TUD, 
                                        crs = crs(DTM_TUD), 
                                        res = res(DTM_TUD))
DTM_hill_TUD_EPSG28992_df <- as.data.frame(DTM_hill_TUD_EPSG28992, xy = TRUE)

res(DTM_hill_TUD_EPSG28992)
str(DTM_hill_TUD_df)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dtm)) +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.hill)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()

# Raster math
CHM_TUD <- DSM_TUD - DTM_TUD
CHM_TUD_df <- as.data.frame(CHM_TUD, xy = TRUE)

str(CHM_TUD_df)

ggplot() +
  geom_raster(data = CHM_TUD_df,
              aes(x = x, y = y, fill = layer)) +
  scale_fill_gradientn(name = "Canopy and building height", 
                       colors = terrain.colors(10)) +
  coord_quickmap()

ggplot(CHM_TUD_df) +
  geom_histogram(aes(layer))

