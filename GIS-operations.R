library(dplyr)
library(sf)
library(ggplot2)
library(osmdata)
library(leaflet)

bb <- getbb('Brielle', format_out = 'sf_polygon')
bb