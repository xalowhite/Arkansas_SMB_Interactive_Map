# Arkansas_SMB_Interactive_Map
An interactive map of Arkansas with points plotted for where smallmouth bass were caught as well as their documented length(mm).
Fish Size Visualization README
Table of Contents
Overview
Requirements
Code Walkthrough
Data Loading and Manipulation
Categorizing Fish Sizes
Creating an Ordered Factor
Mapping and Visualization
Running the Code
Contributing
License
Contact
Overview
This R code is designed to visualize the sizes of fish collected from a specific location. It uses the leaflet package to create an interactive map that displays fish sizes as color-coded circle markers. The map initially centers around Fayetteville, Arkansas, but this can be adjusted based on your data's geographical scope.

Requirements
To run the code, you'll need to install the following R packages:

leaflet: For creating interactive maps.
dplyr: For data manipulation.
You can install these packages using install.packages() if you haven't already.

R
Copy code
install.packages("leaflet")
install.packages("dplyr")
You'll also need access to a CSV file (smb_full_roster.csv) containing the following columns:

latitude: Latitude of the data point.
longitude: Longitude of the data point.
length_mm: Length of the fish in millimeters.
Make sure to update the file path in the read.csv() function to point to your data file.

Code Walkthrough
Data Loading and Manipulation
The code starts by loading the necessary libraries and reading a CSV file that contains the fish data:

R
Copy code
fishdata <- read.csv('/Users/carterw/School Stuff/Douglas Lab Things/smb_full_roster.csv')
Categorizing Fish Sizes
Fish sizes (length_mm) are categorized into detailed ranges based on summary statistics:

R
Copy code
fishdata <- fishdata %>%
  mutate(size_category = case_when(
    ...
  ))
The size categories range from "Very Small" to "Very Large," and there is an "Unknown" category for missing or erroneous data.

Creating an Ordered Factor
The size categories are converted into an ordered factor to maintain their ordinal nature:

R
Copy code
fishdata$size_category <- factor(fishdata$size_category, levels = ordered_levels, ordered = TRUE)
Mapping and Visualization
A color palette is defined to map the size categories to colors:

R
Copy code
color_mapping <- colorFactor(
  ...
)
Popup text is created to display information about each data point when clicked:

R
Copy code
popup_text <- paste(
  ...
)
Finally, the interactive map is created using leaflet:

R
Copy code
leaflet(data = fishdata) %>%
  ...
Running the Code
Make sure you've installed the required packages and have the CSV data file.
Update the file path in read.csv() to your data file.
Run the script in R or RStudio.
Contributing
If you wish to contribute to this project, please fork the repository and submit a pull request.

License
This project is licensed under the MIT License.

Contact
For any questions, please contact the maintainer of this project.

