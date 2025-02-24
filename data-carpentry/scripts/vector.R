library(tidyverse)
library(here)
library(sf)

# Open a shapefile
boundary_Delft <- st_read(here("data", "delft-boundary.shp"))

# Examine the metadata
st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)

boundary_Delft <- st_transform(boundary_Delft, 28992)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)

boundary_Delft

# Plot a shapefile

ggplot(data = boundary_Delft) +
  geom_sf(linewidth = 1, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))

# Challenge 1

lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

st_crs(lines_Delft)
st_crs(point_Delft)

st_crs(lines_Delft)$epsg
st_crs(lines_Delft)$Name

lines_Delft
point_Delft

head(lines_Delft)

# Explore and plot by vector layer attributes

ncol(lines_Delft)
lines_Delft

names(lines_Delft)

# Challenge 2

ncol(point_Delft)
head(point_Delft)
head(point_Delft, 10)

# Explore values within one attribute

unique(point_Delft$leisure)
head(point_Delft$leisure, 10)

levels(factor(point_Delft$leisure))

# Subset features

levels(factor(lines_Delft$highway))

cycleway_Delft <- lines_Delft %>% 
  filter(highway == "cycleway")

nrow(lines_Delft)
nrow(cycleway_Delft)  

cycleway_Delft <- cycleway_Delft %>% 
  mutate(length = st_length(.))
cycleway_Delft

cycleway_Delft %>% 
  summarise(total_length = sum(length))

# Plot cycleways

ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(title = "Slow mobility network in Delft", subtitle = "Cycleways") +
  coord_sf(datum = st_crs(28992))


# Challenge 3

levels(factor(lines_Delft$highway))

motorway_Delft <- lines_Delft %>% 
  filter(highway == "motorway")

motorway_Delft

motorway_Delft %>% 
  mutate(length = st_length(.)) %>% 
  summarise(total_length = sum(length))

# Customize plots

levels(factor(lines_Delft$highway))

road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft %>% 
  filter(highway %in% road_types) %>% 
  mutate(highway = factor(highway, levels = road_types))

road_colors <- c("blue", "green", "navy", "purple")

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway)) +
  scale_color_manual(values = road_colors) +
  labs(title = "Road network of Delft",
       subtitle = "Roads & Cycleways",
       color = "Road Type") +
  coord_sf(datum = st_crs(28992))

# Adjust line width

line_widths <- c(1, 0.75, 0.5, 0.25)

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway, linewidth = highway)) +
  scale_color_manual(values = road_colors) +
  scale_linewidth_manual(values = line_widths) +
  labs(title = "Mobikity network of Delft",
       subtitle = "Roads & Cycleways",
       color = "Road Type",
       linewidth = "Road Type") +
  coord_sf(datum = st_crs(28992))

# Challenge 5

# First, create a data frame with only those roads where bicycles are allowed
lines_Delft_bicycle <- lines_Delft %>% 
  filter(highway == "cycleway")

# Next, visualise using ggplot
ggplot(data = lines_Delft) +
  geom_sf() +
  geom_sf(data = lines_Delft_bicycle, aes(color = highway), linewidth = 1) +
  scale_color_manual(values = "magenta") +
  labs(title = "Mobility network in Delft", subtitle = "Roads dedicated to Bikes") +
  coord_sf(datum = st_crs(28992))
  
# A different map

municipal_boundaries_NL <- st_read(here("data", "nl-gemeenten.shp"))

str(municipal_boundaries_NL)

levels(factor(municipal_boundaries_NL$ligtInPr_1))

ggplot(data = municipal_boundaries_NL) +
  geom_sf(aes(color = ligtInPr_1), linewidth = 1) +
  labs(title = "Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))
  
# Plot multiple shapefiles

ggplot() +
  geom_sf(data = boundary_Delft, 
          fill = "grey", color="grey") +
  geom_sf(data = lines_Delft_selection, 
          aes(color = highway), 
          linewidth = 1) +
  geom_sf(data = point_Delft) +
  labs(title = "Mobility network of Delft") +
  coord_sf(datum = st_crs(28992))


levels(factor(point_Delft$leisure))

leisure_colors <- rainbow(15)
point_Delft$leisure <- factor(point_Delft$leisure)

ggplot() +
  geom_sf(data = boundary_Delft, 
          fill = "grey", color = "grey") +
  geom_sf(data = lines_Delft_selection,
          aes(color = highway),
          linewidth = 0.75) +
  geom_sf(data = point_Delft,
          aes(fill = leisure),
          shape = 22) +
  scale_color_manual(values = road_colors, 
                     name = "Road Type") +
  scale_fill_manual(values = leisure_colors,
                    name = "Leisure Location") +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))

# Challenge 7

leisure_locations_selection_2 <- point_Delft %>% 
  filter(leisure %in% c("playground", "picnic_table"))

levels(factor(leisure_locations_selection_2$leisure))

blue_orange <- c("cornflowerblue", "darkorange")

ggplot() + 
  geom_sf(data = lines_Delft_selection, aes(color = highway)) + 
  geom_sf(data = leisure_locations_selection_2, aes(fill = leisure, 
                                                    shape = leisure)) + 
  scale_color_manual(name = "Road Type", values = road_colors) + 
  scale_fill_manual(name = "Leisure Type", values = blue_orange) +
  scale_shape_manual(name = "Leisure Type", values = c(21, 22)) +
  labs(title = "Traffic and leisure") + 
  coord_sf(datum = st_crs(28992))

# Handling spatial projections and CRS

municipal_boundaries_NL

ggplot() +
  geom_sf(data = municipal_boundaries_NL) +
  labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))

country_boundary_NL <- st_read(here("data", "nl-boundary.shp"))

ggplot() +
  geom_sf(data = municipal_boundaries_NL) +
  # geom_sf(data = country_boundary_NL, color = "gray18", linewidth =2) +
  labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))

st_crs(municipal_boundaries_NL)$epsg
st_crs(country_boundary_NL)$epsg

boundary_Delft <- st_read(here("data", "delft-boundary.shp"))

ggplot() +
  geom_sf(data = municipal_boundaries_NL) +
  geom_sf(data = boundary_Delft, fill = "purple", color = "purple") +
  labs(title = "Map of Contiguous NL Municipal Boundaries",
       subtitle = "Delft location") +
  coord_sf(datum = st_crs(28992))
  
# Challenge 8

boundary_ZH <- municipal_boundaries_NL %>% 
  filter(ligtInPr_1 == "Zuid-Holland")

ggplot() +
  geom_sf(data = boundary_ZH, aes(color ="color"), show.legend = "line") +
  scale_color_manual(name = "", labels = "Municipal Boundaries in South Holland", values = c("color" = "gray18")) +
  geom_sf(data = boundary_Delft, aes(shape = "shape"), color = "purple", fill = "purple") +
  scale_shape_manual(name = "", labels = "Municipality of Delft", values = c("shape" = 19)) +
  labs(title = "Delft location") +
  coord_sf(datum = st_crs(28992))

st_write(leisure_locations_selection_2,
         here("data_output", 
              "leisure_locations_selection.shp"),
         driver = "ESRI shapefile")

