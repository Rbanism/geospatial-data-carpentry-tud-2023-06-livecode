

# install.packages("here")

# Load packages 

library(tidyverse)
library(here)

here("data")

# Download data
download.file("https:/bit.ly/geospatial_data", 
              here("data", "gapminder_data.csv"),
              mode = "wb"
              )



