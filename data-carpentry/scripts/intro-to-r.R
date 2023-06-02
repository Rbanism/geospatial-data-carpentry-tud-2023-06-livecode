# install.packages("here")

# Load packages 

library(here)
library(tidyverse)

here("data")

# Download data file 
download.file("https://bit.ly/geospatial_data",
              here("data", "gapminder_data.csv"),
              mode = "wb")

# R as calculator
1 + 100

# Variables and assignment

