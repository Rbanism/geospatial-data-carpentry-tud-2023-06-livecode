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
x <- 1/40
x

sqrt(x)

x <- 100
x

y <- sqrt(x)
y

# Vectors 

numeric_vector <- c(2, 6, 3)

character_vector <- c("banana", "apple", "orange")

logical_vector <- c(TRUE, FALSE, FALSE)

numeric_vector
character_vector
logical_vector

# combine vectors

ab_vector <- c("a", "b")
ab_vector

abcd_vector <- c(ab_vector, "c" , "d")
abcd_vector

NA

with_na <- c(1,2,1,1,NA,3,NA)
mean(with_na)
mean(with_na, na.rm = TRUE)


is.na(with_na)
!is.na(with_na)

without_na <- with_na[!is.na(with_na)]
without_na

# Factors

nordic_str <- c("Norway", "Sweden", "Norway", "Denmark", "Sweden")
nordic_str

nordic_cat <- factor(nordic_str)
nordic_cat

levels(nordic_cat)
nlevels(nordic_cat)

nordic_cat <- factor(nordic_cat, levels = c("Norway", "Sweden", "Denmark"))
nordic_cat

str(nordic_cat)


# Data frames 

gapminder <- read.csv(here("data", "gapminder_data.csv") )

str(gapminder)

head(gapminder)

summary(gapminder)

nrow(gapminder)
ncol(gapminder)

contry_vector <- gapminder$country
head(contry_vector)

# Manipulate data 

year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

year_country_gdp <- gapminder %>% select(year, country, gdpPercap)
head(year_country_gdp)


year_country_gdp_noneur <- gapminder %>%
  filter(continent != "Europe" & year > 2000 ) %>%
  select(year, country, gdpPercap)

head(year_country_gdp_noneur)

year_country_gdp_eurasia <- gapminder %>%
  filter(continent == "Europe" | continent == "Asia") %>%
  select(year, country, gdpPercap)

head(year_country_gdp_eurasia)

