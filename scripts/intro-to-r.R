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


#  creating objects ----

x <- 12/43
x

sqrt(x)

y <- sqrt(x)
y

# Vectors ----

numeric_vector <- c(2, 6, 3)
numeric_vector

character_vector <- c("banana", "orange", "kiwi")
character_vector

logical_vector <- c(TRUE, FALSE, TRUE)
logical_vector


ab_vector <- c("a" , "b")
abcd_vector <-c(ab_vector, "cd")
abcd_vector

# missing values -----

with_na <- c(1, 2, 1, 7, NA, 1, NA)

mean(with_na)
mean(with_na, na.rm = TRUE)




