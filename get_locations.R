# Libraries
library(mapsapi)
library(leaflet)

# Your private key
key = "XXX"

# Getting the geolocations from the Google Maps Directions API
addresses = c("Oegstgeest", "Katwijk aan Zee", "Leiden", "Warmond",
               "Voorschoten", "Alphen aan den Rijn")

doc = mp_geocode(
  addresses = addresses,
  key = key
)

# Extract pointss from the response
point = mp_get_points(doc)

# Visualize using leaflet
palette = colorFactor(palette = "Set2", domain = point$location_type)

leaflet() %>% 
  addProviderTiles(provider = providers$CartoDB.Positron) %>%
  addCircleMarkers(data = point)
