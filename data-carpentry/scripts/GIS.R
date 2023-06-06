library(tidyverse)
library(sf)
#install.packages("osmdata")
library(osmdata)

bb <- getbb("Brielle", format_out = "sf_polygon" )
bb
