# Libraries
library(mapsapi)
library(leaflet)

# Your private key
key = "XXX"

# Getting the directions from the Google Maps Directions API
doc = mp_directions(
  origin = "Oegstgeest",
  destination = "Alphen aan den Rijn",
  mode = "walking",
  alternatives = TRUE,
  key = key,
  quiet = TRUE
)

# Extract routes from the response
routes = mp_get_routes(doc)

# Visualize using leaflet
palette = colorFactor(palette = "Set2", domain = routes$alternative_id)

leaflet() %>% 
  addProviderTiles(provider = providers$CartoDB.Positron) %>%
  addPolylines(data = routes, 
               opacity = 1, 
               weight = 7, 
               color = ~palette(alternative_id),
               label = ~distance_text,
               labelOptions = labelOptions(noHide = TRUE))
