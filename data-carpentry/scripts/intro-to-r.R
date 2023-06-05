

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

is.na(with_na)

!is.na(with_na)

without_na <- with_na[!is.na(with_na)]
without_na


# Factors

nordic_str <- c("Norway", "Sweden", "Norway",
                "Denmark", "Sweden")
nordic_str

nordic_cat <- factor(nordic_str)
nordic_cat

levels(nordic_cat)
nlevels(nordic_cat)

nordic_cat <- factor(nordic_cat, 
                     levels = c("Norway", "Denmark", "Sweden"))
nordic_cat

# Data frames 

gapminder <- read.csv(here("data", "gapminder_data.csv"))

str(gapminder)
head(gapminder)
summary(gapminder)
nrow(gapminder)
ncol(gapminder)


country_vec <- gapminder$country
head(country_vec)

# Data manipulation

year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)

year_country_gdp_noneur <- gapminder %>%
  filter(continent != "Europe" & year > 2000) %>%
  select(year, country, gdpPercap)

head(year_country_gdp_noneur)

year_country_gdp_eurasia <- gapminder %>%
  filter(continent == "Europe" | continent == "Asia") %>%
  select(year, country, gdpPercap)
head(year_country_gdp_eurasia)


# Exercise 1

year_country_lifeExp_Africa <- gapminder %>%
  filter(continent=="Africa"  ) %>%
  select(year,country,lifeExp)

nrow(year_country_lifeExp_Africa)

# group by

gapminder %>%
  group_by(continent) %>%
  summarize(avg_gdpPercap = mean(gdpPercap))


#Exercise 2 

gapminder %>%
  group_by(country) %>%
  summarize(avg_lifeExp = mean(lifeExp) ) %>%
  filter(avg_lifeExp == min(avg_lifeExp) | avg_lifeExp == max(avg_lifeExp))

gapminder %>%
  group_by(continent, year) %>%
  summarize(avg_gdpPercap = mean(gdpPercap),
            avg_lifExp = mean(lifeExp)
  )
  
gapminder %>%
  group_by(continent, year) %>%
  count()

gapminder_gdp <- gapminder %>%
  mutate(gdpBillion = gdpPercap * pop / 10^9 )

head(gapminder_gdp)


# Introduction to Data vis

ggplot(data = gapminder, aes(x = lifeExp)) +
  geom_histogram()

gapminder %>%
  filter(year == 2007 & continent == "Americas") %>%
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()


plot_c <- gapminder %>%
  filter(year == 2007 & 
           continent == "Americas") %>%
  mutate(country = fct_reorder(country, gdpPercap)) %>%
  ggplot(aes(x = country, y = gdpPercap, fill= lifeExp)) +
  geom_col() +
  coord_flip()+
  scale_fill_viridis_c()

plot_c

plot_d <-gapminder %>%
  filter(year == 2007 &
           continent == "Americas") %>%
  mutate(country = fct_reorder(country, gdpPercap),
         lifeExp_cat = if_else(lifeExp >= mean(lifeExp), 
                               "high", "low")) %>%
  ggplot(aes(x = country, y = gdpPercap, fill = lifeExp_cat))+
  geom_col()+
  coord_flip()+
  scale_fill_manual(values = c("light blue", "orange"))
  
plot_d



