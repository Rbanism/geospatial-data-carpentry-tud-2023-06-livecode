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

terrain.colors(3)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x,
                                     y = y,
                                     fill = fct_elevation_cb)) +
  scale_fill_manual(values = terrain.colors(3), name = "Elevation") +
  coord_quickmap()

# Layering rasters

DSM_hill_TUD <- raster(here("data", "tud-dsm-5m-hill.tif"))
DSM_hill_TUD  

DSM_hill_TUD_df <- as.data.frame(DSM_hill_TUD, xy = TRUE)
str(DSM_hill_TUD_df)

ggplot() +
  geom_raster(data = DSM_hill_TUD_df,
              aes(x = x, y = y, alpha = tud.dsm.5m.hill)) +
  scale_alpha(range = c(0.15, 0.65), guide = "none") +
  coord_quickmap()

ggplot() +
  geom_raster(data = DSM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dsm.5m)) +
  geom_raster(data = DSM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dsm.5m.hill)) +
  scale_fill_viridis_c() +
  scale_alpha(range = c(0.15, 0.65), guide = "none") +
  labs(title = "Elevation with hillshade") +
  coord_quickmap()

# Reproject raster data

DTM_TUD <- raster(here("data", "tud-dtm-5m.tif"))
DTM_hill_TUD <- raster(here("data", "tud-dtm-5m-hill-ETRS89.tif"))

DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DTM_hill_TUD_df <- as.data.frame(DTM_hill_TUD, xy = TRUE)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dtm.5m)) +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.5m.hill.ETRS89)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = tud.dtm.5m)) +
  scale_fill_gradientn(name = "Elevation", 
                       colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.5m.hill.ETRS89)) +
  coord_quickmap()

# Reproject rasters

DTM_hill_EPSG28992_TUD <- projectRaster(DTM_hill_TUD,
                                        crs = crs(DTM_TUD))
  
crs(DTM_hill_EPSG28992_TUD)
crs(DTM_TUD)

compareCRS(DTM_hill_EPSG28992_TUD, DTM_TUD)

extent(DTM_hill_EPSG28992_TUD)
extent(DTM_TUD)

res(DTM_hill_EPSG28992_TUD)
res(DTM_TUD)

DTM_hill_EPSG28992_TUD <- projectRaster(DTM_hill_TUD,
                                        crs = crs(DTM_TUD),
                                        res = res(DTM_TUD))

DTM_hill_EPSG28992_TUD_df <- as.data.frame(DTM_hill_EPSG28992_TUD, xy = TRUE)

head(DTM_hill_EPSG28992_TUD_df)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y),
              fill = tud.dtm.5m) +
  geom_raster(data = DTM_hill_EPSG28992_TUD_df,
              aes(x = x, y = y,
                  alpha = tud.dtm.5m.hill.ETRS89)) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_quickmap()
