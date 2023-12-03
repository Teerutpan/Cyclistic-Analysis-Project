# Google Data Analytics Capstone Project : Cyclistic Bike Share
# This is my first data analysis project

# 1. PREPARE
# Install required packages

library(tidyverse)
library(lubridate)

# Collect data (Upload Divvy datasets)

X202211 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202211-divvy-tripdata.csv")
X202212 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202212-divvy-tripdata.csv")
X202301 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202301-divvy-tripdata.csv")
X202302 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202302-divvy-tripdata.csv")
X202303 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202303-divvy-tripdata.csv")
X202304 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202304-divvy-tripdata.csv")
X202305 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202305-divvy-tripdata.csv")
X202306 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202306-divvy-tripdata.csv")
X202307 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202307-divvy-tripdata.csv")
X202308 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202308-divvy-tripdata.csv")
X202309 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202309-divvy-tripdata.csv")
X202310 <- read_csv("C:/Users/teerutp/Desktop/Google Data Analytics/8.Capstone project/202310-divvy-tripdata.csv")

# Stack individual data frames into one big data frame

btrips <- bind_rows(X202211, X202212, X202301, X202302, X202303, X202304, X202305,
                    X202306, X202307, X202308, X202309, X202310)

# Inspect the new table that has been created
colnames(btrips)
nrow(btrips)
head(btrips)
str(btrips)
View(btrips)

# 2. PROCESS
# Clean up and add data to prepare for analysis

# Select analysis column only
trip <- select(btrips, rideable_type, started_at, start_station_name, ended_at, member_casual)
View(trip)

# Check for the missing values
sum(is.na(trip))
# Remove all the missing values
trip <- na.omit(trip)

# Check for duplicate rows
nrow(trip[duplicated(trip), ])
# Remove duplicate rows
trip <- distinct(trip)

# Add columns that list the date, month, day, and year of each ride
trip$date <- as.Date(trip$started_at)
trip$month <- format(as.Date(trip$date),"%m")
trip$day <- format(as.Date(trip$date),"%d")
trip$year <- format(as.Date(trip$date),"%Y")
trip$day_of_week <- format(as.Date(trip$date),"%A")
trip$hour <- lubridate::hour(trip$started_at)
trip <- trip %>% mutate(weekday = wday(trip$started_at, label = TRUE))

# Create column ride length to calculate duration
trip <- trip %>% mutate(ride_length = difftime(ended_at, started_at, units = "min"))

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
trip$ride_length <-as.numeric(as.character(trip$ride_length))
# Check ride_length is numeriC
is.numeric(trip$ride_length)

# Filter only ride_length >= 1 and <= 480 minutes 
trip <- trip %>% filter(ride_length >= 1) %>%
                 filter(ride_length <= 480)

# Order column day of week and month
trip$day_of_week <- ordered(trip$day_of_week, levels = c("Sunday", "Monday",
"Tuesday", "Wednesday", "Thursday","Friday", "Saturday"))
trip$month <- ordered(trip$month, levels = c("11", "12", "01",
  "02", "03", "04", "05", "06", "07", "08", "09", "10"))

# Conduct descriptive analysis
aggregate(trip$ride_length~trip$member_casual, FUN = mean )
aggregate(trip$ride_length~trip$member_casual, FUN = median )
aggregate(trip$ride_length~trip$member_casual, FUN = max )
aggregate(trip$ride_length~trip$member_casual, FUN = min )
aggregate(trip$ride_length~trip$member_casual + trip$day_of_week, FUN = mean )
aggregate(trip$ride_length~trip$member_casual + trip$weekday, FUN = mean )
summary(trip$ride_length)

# 3. ANALYZE & SHARE
# Analyze and create visualization in the same command with pipe operator

# Number of Rides by User(Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual) %>%
  ggplot(aes(x = member_casual, y = number_of_ride )) +
  geom_col() + labs(title = "Number of Rides by User(Nov 2022 - Oct 2023)", 
  x = "User", y = "Number of Rides")

# Average Duration of Rides by User(Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual) %>%
  ggplot(aes(x = member_casual, y = average_duration )) +
  geom_col() + labs(title = "Average Duration by User(Nov 2022 - Oct 2023)", 
  x = "User", y = "Duration ( minutes )")

# Number of Rides by Bicycle Type (Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual, rideable_type) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual) %>%
  ggplot(aes(x = rideable_type, y = number_of_ride, fill = member_casual)) +
  geom_col() + labs(title = "Number of Rides by Bicycle Type (Nov 2022 - Oct 2023)", 
                    x = "Bicycle Type", y = "Number of Rides") + scale_fill_discrete(name="User")

# Number of Rides per 1 Hour(Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual, hour) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, hour) %>%
  ggplot(aes(x = hour, y = number_of_ride, group = member_casual, 
             color = member_casual)) +
  geom_point() + geom_line() + labs(title = "Number of Rides per 1 Hour(Nov 2022 - Oct 2023)", 
  x = "Daily Hour", y = "Number of Rides") + scale_fill_discrete(name="User")

# Number of Rides - Day of Week (Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual, weekday) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = number_of_ride, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.7) + labs(title = "Number of Rides - Day of Week (Nov 2022 - Oct 2023)", 
  x = "Day", y = "Number of Rides") + scale_fill_discrete(name="User")

# Number of Rides by Month (Nov 2022 - Oct 2023)
trip %>% 
  group_by(month, member_casual) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(month, member_casual) %>%
  ggplot(aes(x = month, y = number_of_ride, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.7) + labs(title = "Number of Rides by Month (Nov 2022 - Oct 2023)", 
  x = "Month (Start from Nov 2022)", y = "Number of Rides") + scale_fill_discrete(name="User") 

# Average Duration of Rides per 1 Hour(Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual, hour) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, hour) %>%
  ggplot(aes(x = hour, y = average_duration, group = member_casual, 
             color = member_casual)) +
  geom_point() + geom_line() + labs(title = "Average Duration per 1 Hour(Nov 2022 - Oct 2023)", 
  x = "Daily Hour", y = "Duration ( minutes )") + scale_fill_discrete(name="User")

# Average Duration of Rides - Day of Week (Nov 2022 - Oct 2023)
trip %>% 
  group_by(member_casual, weekday) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.7) + labs(title = "Average Duration of Rides - Day of Week(Nov 2022 - Oct 2023)", 
  x = "Day", y = "Duration ( minutes )") + scale_fill_discrete(name="User")

# Average Duration of Rides by Month (Nov 2022 - Oct 2023)
trip %>% 
  group_by(month, member_casual) %>%
  summarise(number_of_ride = n(),
            average_duration = mean(ride_length)) %>%
  arrange(month, member_casual) %>%
  ggplot(aes(x = month, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.7) + labs(title = "Average Duration by Month (Nov 2022 - Oct 2023)", 
  x = "Month", y = "Duration ( minutes )") + scale_fill_discrete(name="User") 

# Top 15 favorite station for casual (Nov 2022 - Oct 2023)
no_station_casual <- trip %>%
  group_by(start_station_name, member_casual) %>%
  summarise(number = n()) %>%
  filter(member_casual == "casual") %>%
  arrange(desc(number)) %>%
  head(15)

# Top 15 favorite station for member (Nov 2022 - Oct 2023)
no_station_member <- trip %>%
  group_by(start_station_name, member_casual) %>%
  summarise(number = n()) %>%
  filter(member_casual == "member") %>%
  arrange(desc(number)) %>%
  head(15)





