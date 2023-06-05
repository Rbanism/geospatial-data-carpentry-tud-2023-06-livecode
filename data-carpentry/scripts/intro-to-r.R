

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

1 +100

# variables 

x <- 1/40
x

sqrt(x)

x <- 100
x

y <- sqrt(x)
y


