3 + 5
print("hello world")

# Loading packages ------

# install.packages("here")
# install.packages("tidyverse")

library(tidyverse)
library(here)

here()
here("data", "tud-dsm.tif")

# downloading data -----

download.file("bit.ly/GeospatialGapminder", 
              here("data", "gapminder_data.csv"),
              mode = "wb"
              )

11 + 100
10*12
23/45

