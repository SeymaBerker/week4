library(sf)
library(dplyr)
library(countrycode)
worldshp <- st_read("/Users/seyma/Downloads/world_Countries.geojson")
gender_data <- read.csv("/Users/seyma/Downloads/HDR23-24_Composite_indices_complete_time_series.csv")
names(gender_data)
gender_subset <- gender_data %>%
  select(iso3, gii_2010, gii_2019) %>%
  filter(!is.na(gii_2010) & !is.na(gii_2019))
gender_subset <- gender_subset %>%
  mutate(difference = gii_2019 - gii_2010)
world_with_gii <- worldshp %>%
  left_join(gender_subset, by = c("ISO" = "iso3"))
print(world_with_gii)
st_write(world_with_gii, "/Users/seyma/Downloads/world_with_gii.geojson")


