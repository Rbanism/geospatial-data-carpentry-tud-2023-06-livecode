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

is.na(with_na)

!is.na(with_na)

without_na <- with_na[!is.na(with_na)]


# rm(with_na)
with_na

# factors ----

nordic_str <- c("Norway", "Sweden",  "Norway", 
                "Denmark", "Sweden" )
nordic_str

nordic_cat <-factor(nordic_str)
nordic_cat


levels(nordic_cat)
nlevels(nordic_cat)

nordic_cat <- factor(nordic_cat,
                     levels = c("Norway", "Sweden", "Denmark"))
nordic_cat

gapminder <- read.csv(here("data", "gapminder_data.csv"))

str(gapminder)
head(gapminder)
summary(gapminder)

# data manipulation ---- 

# select 

year_country_gdp <- select(gapminder, year, country, gdpPercap)

head(year_country_gdp)

#%>% 
# #|>  

gapminder %>%
  select(year, country, gdpPercap)

# filter 

year_country_gdp_euro <- gapminder %>%
  filter(continent == "Europe" & year > 2000) %>%
  select(year, country, gdpPercap)

head(year_country_gdp_euro)  

# challenge 1 
year_country_lifeExp_Africa <- gapminder %>%
  filter(continent=="Africa"  ) %>%
  select(year,country,lifeExp)

nrow(year_country_lifeExp_Africa)

head(year_country_lifeExp_Africa)

