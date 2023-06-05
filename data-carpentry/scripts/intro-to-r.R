

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


#Vectors


numeric_vector <- c(2 , 6, 3)
numeric_vector

character_vector <- c("banana", "apple", "orange")
character_vector

logical_vector <- c(TRUE, FALSE, TRUE)
logical_vector

ab_vector<- c("a", "b")
ab_vector

abcd_vector <- c(ab_vector, "c", "d")
abcd_vector


# Missing values 

with_na <- c(1 ,2 , 1, 1 , NA, 3 , NA) 
mean(with_na)

mean(with_na, na.rm = TRUE)


