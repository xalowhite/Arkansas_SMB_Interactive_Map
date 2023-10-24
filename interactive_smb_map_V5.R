 # Load required packages
 library(leaflet)
 library(dplyr)  # for data manipulation
 
   # Read the CSV file
   fishdata <- read.csv('/Users/carterw/School Stuff/Douglas Lab Things/smb_full_roster.csv')
   
   # Categorize fish sizes into more detailed ranges based on the summary statistics
   # Categorize fish sizes into more detailed ranges based on the summary statistics
   fishdata <- fishdata %>%
     mutate(size_category = case_when(
       length_mm < 150 ~ "Very Small",
       length_mm >= 150 & length_mm < 200 ~ "Small",
       length_mm >= 200 & length_mm <= 230 ~ "Medium-Small",
       length_mm > 230 & length_mm <= 250 ~ "Medium",
       length_mm > 250 & length_mm <= 268 ~ "Medium-Large",
       length_mm > 268 & length_mm <= 300 ~ "Large",
       length_mm > 300 ~ "Very Large",
       is.na(length_mm) ~ "Unknown",  # Handle NA values
       TRUE ~ "Unknown"
     ))
   
   # Define the order of the size categories
   ordered_levels <- c("Very Small", "Small", "Medium-Small", "Medium", "Medium-Large", "Large", "Very Large", "Unknown")
   
   # Convert 'size_category' to an ordered factor
   fishdata$size_category <- factor(fishdata$size_category, levels = ordered_levels, ordered = TRUE)
   
   # ... (rest of the code remains the same)
   
   
     # Create a color palette to map size categories to colors
     color_mapping <- colorFactor(
           palette = c("red", "orange", "yellow", "green", "blue", "magenta", "violet", "grey"),
           domain = fishdata$size_category
       )
     
       # Create popup text for each point, showing its coordinates, size category, and actual length
       popup_text <- paste(
             "Latitude: ", fishdata$latitude, "<br>",
             "Longitude: ", fishdata$longitude, "<br>",
             "Actual Length (mm): ", fishdata$length_mm , "<br",
             "Size Category: ", fishdata$size_category, "<br>"
         )
       
         # Create an interactive map using leaflet
         leaflet(data = fishdata) %>%
             # Set the initial map to be centered around Fayetteville, Arkansas
             setView(lng = -94.1719, lat = 36.0822, zoom = 10) %>%
             # Add a default map layer
             addProviderTiles(providers$OpenStreetMap) %>%
             # Add points from the fishdata data frame
             addCircleMarkers(
                   lng = ~longitude, lat = ~latitude,
                   color = ~color_mapping(size_category),
                   radius = 3, stroke = FALSE, fillOpacity = 0.6,
                   popup = popup_text
               ) %>%
             # Add a legend to explain the color mapping
             addLegend(
                   pal = color_mapping,
                   values = ~size_category,
                   title = "Fish Size",
                   position = "bottomright"
               )
       
        