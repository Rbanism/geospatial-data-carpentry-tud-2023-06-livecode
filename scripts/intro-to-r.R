3 + 5
print('hello world')

# Loading packages -------

# install.packages("here")
# install.packages("tidyverse")

library(tidyverse)
library(here)


here()
here('data')
here('scripts', 'intro-to-r.R')


# download gapminder data -----

# download.file("bit.ly/GeospatialGapminder", here('data', 'gapminder_data.csv'), mode = 'wb')

1+100
11*101
12/43


# object assignment -------

x <- 12/43
x

sqrt(12/43)

y <- sqrt(x)
y


# Vectors -------------

numeric_vector <- c(2, 6, 3)
numeric_vector


character_vector <- c("banana", "apple", "orange")
character_vector

logical_vector <- c(TRUE, FALSE, TRUE)
logical_vector


ab_vector <- c("a", "b")
ab_vector

abcd_vector <- c(ab_vector, "cd" )
abcd_vector


# Missing values ---- 

with_na <- c(1, 2, 1, 1, NA, 7, NA)

mean(with_na)



