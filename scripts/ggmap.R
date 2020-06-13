# Libraries
library(ggmap)
library(dplyr)

# Your private key
key = "XXX"

# This sets your google maps key for this session
register_google(key = key)

# Get a static map
map <- get_googlemap("the netherlands", zoom = 7)

# EXAMPLE 1
# Make a plot to display stations in the Netherlands # requires maps static api
data_stations <- read.csv("data/stations-2020-01-nl.csv")

ggmap(map) +
  geom_point(data = data_stations, 
             aes(x = geo_lng, y = geo_lat, color = type)) +
  ggtitle("Stations in the Netherlands") +
  theme_void()


# EXAMPLE 2
# Get a static map
map <- get_googlemap("tilburg, the netherlands", zoom = 8)

# Load the data
data_supermarkets <- read.csv("data/albertheijn-top10.csv", sep = ";",
                              stringsAsFactors = FALSE)

# Addresses have to be converted to a geolocation
data_supermarkets <- data_supermarkets %>%
  mutate_geocode(Straat_volledig) %>%
  mutate(vvo = as.numeric(vvo))

# Make the plot
ggmap(map) +
  geom_point(data = data_supermarkets, 
             aes(x = lon, y = lat, size = vvo),
             colour = "navy")  +
  ggtitle("Top 10 biggest Albert Heijn supermarkets") +
  scale_size_continuous(name = "Sales surface area (m2)",
                        range = c(3, 7)) +
  theme_void()