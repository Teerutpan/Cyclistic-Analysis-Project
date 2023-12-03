# Cyclistic-Analysis-Project
This is my first data analysis project from Google Data Analytics Course from Coursera.

## Introduction
Welcome to the Cyclistic bike-share analysis case study! In this case study, I will perform many real-world tasks of a data analyst. I will work for a fictional company, Cyclistic, and meet different characters and team members. In order to answer the key business questions, I will follow the steps of the data analysis process: ask, prepare, process, analyze, share, and act. 

## Scenario
I am a data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. 

One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members. 

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

## Ask
#### Business Task
1.	Analyze the data to understand how annual members and casual riders use Cyclistic bikes differently.
2.	Insights gained from this analysis will help marketing teams develop strategies and use digital media to persuade more casual drivers to become members.

#### key stakeholders
Lily Moreno: The director of marketing and your manager.
Cyclictic marketing analytics team : team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
Cyclistic executive team: The notoriously detail-oriented executive team who will decide whether to approve the recommended marketing program.

## Prepare
I will use Cyclistic’s historical trip data to analyze and identify trends. Note: The datasets have a different name because Cyclistic is a fictional company. This is public data that I can use to explore how different customer types are using Cyclistic bikes. I'll be using data from November 2022 to October 2023. The data is organized into individual .csv files, with each file corresponding to a specific month. After preliminary inspection I can confidently confirm that the source data is Reliable, Original, Comprehensive, Current and Cited.
I chose R studio desktop for analysis because it’s a large dataset making it impractical to manage with spreadsheet. But I choose one month’s data (Dec 2022) for sampling analysis with google sheet to familiar with data before performing actual analysis.

#### Preparing step in R studio desktop.
1.	Install required packages including “tidyverse” and “lubridate” packages.
2.	Collect data (Upload Divvy datasets) CSV file from Nov 2022 to Oct 2023.
3.	Stack individual data frames into one big data frame.
4.	Inspect the new table that has been created.

## Process
Before processing data with R studio desktop, I choose one month’s data (Dec 2022) file name 202212-divvy-tripdata.csv for sampling analysis with google sheet to familiar with data before performing actual analysis. 

#### Process for sampling data(Dec 2022) by google sheet.
After cleaning data in google sheet (delete missing value, duplicate rows).
I created more three columns.
1.	“ride_length” for calculate the length of each ride by subtracting the column “started_at” from the column “ended_at”. 
2.	“day_of_week” for calculate the day of the week that each ride started using the “WEEKDAY” command. Google sheet command : WEEKDAY(date, [type])
3.	“started_at(H)” for creating hour in day from the date. Google sheet command : TEXT(number, format)

#### Analyze and create visualization for sampling data (Dec 2022) by google sheet.
Then I proceed to the basic sampling analyze step for one month (Dec 2022). The result is shown in chart below.

Number of Rides by User (Dec 2022)
Average Duration of Rides by User (Dec 2022)
Percentage of using Bicycle Type (Dec 2022)
Number of Rides per 1 Hour (Dec 2022)
Number of Rides - Day of Week (Dec 2022)
Average Duration of Rides per 1 Hour (Dec 2022)
Average Duration of Rides - Day of Week (Dec 2022)
Top 15 favorite station for casual (Dec 2022)
Top 15 favorite station for member (Dec 2022)

#### Analyze sampling data from google sheet.
Key findings (Dec 2022)
1.	Member take rides approximately three times as much as Casual during the specified period. Member take rides 136,754 times, while Casual take rides 44,720 times.
2.	Casual’s rides duration time is slightly longer than Member during the specified period. Casual’s rides duration time around 12.14 minutes, while Member’s rides duration time around 9.57 minutes.
3.	Casual prefer to use electric bicycles more than classic bicycles, while Member uses both types of bicycles almost equally.
4.	Member shows 2 peaks throughout the day in terms of number of rides. One is early in the morning at around 7.00 to 8.00 and other is in the evening at around 16.00 to 18.00 while number of rides for Casual riders increase consistently over the day until 17.00 and then decrease afterwards.
5.	Member’s number of rides on weekdays more than on weekends, while Casual’s number of rides on Thursday to Saturday more than other days.
6.	Casual’s average duration of bike is peak on 10.00 – 15.00 around 14 minutes, while Member’s average duration of bike is around 10 minutes throughout the day.
7.	Both Member and Casual’s average duration of bike is more on weekends. Casual’s average duration of bike on weekends is around 13 minutes while Member is around 10 minutes.
8.	Top 5 favorite station for member are : 
1.	Kingsbury St & Kinzie St
2.	Clinton St & Washington Blvd
3.	Clark St & Elm St
4.	State St & Chicago Ave
5. Clinton St & Madison St
9. Top 5 favorite station for casual are
1. Shedd Aquarium
2. Streeter Dr & Grand Ave
3. Millennium Park
4. DuSable Lake Shore Dr & Monroe St
5. Kingsbury St & Kinzie St

## Process for all data (Nov 2022 - Oct 2023) by R studio desktop.
After that I start processing data with R studio desktop for Nov 2022 – Oct 2023 as the method below.
Clean up and add data to prepare for analysis. After inspecting the new table that has been created, I start to process the data as step below.
1. Select analysis column only, including rideable_type, started_at, start_station_name, ended_at, and member_casual.
2. Check for the missing values.
3. Remove all the missing values.
4. Check for duplicate rows.
5. Remove duplicate rows.
6. Add columns that list the date, month, day, and year of each ride. This will allow us to aggregate ride data for each month, day, or year.
7. Create column ride length to calculate duration since the data did not have the trip duration.
8. Convert "ride_length" from Factor to numeric so we can run calculations on the data.
9. There are some rides where trip duration shows up as negative, including several hundred rides where Divvy took bikes out of circulation for quality control reasons. I want to delete these rides by filter only “ride_length” >= 1 and <= 480 minutes.
10. Notice that the days of the week and month are out of order so, let's fix that.

## ANALYZE & SHARE
1. Conduct descriptive analysis by compare members and casual users.
2. Analyze and create visualization in the same command with pipe operator.

Number of Rides by User (Nov 2022 - Oct 2023)
Average Duration of Rides by User (Nov 2022 - Oct 2023)
Number of Rides by Bicycle Type (Nov 2022 - Oct 2023)
Number of Rides per 1 Hour (Nov 2022 - Oct 2023)
Number of Rides - Day of Week (Nov 2022 - Oct 2023)
Number of Rides by Month (Nov 2022 - Oct 2023)
Average Duration of Rides per 1 Hour (Nov 2022 - Oct 2023)
Average Duration of Rides - Day of Week (Nov 2022 - Oct 2023)
Average Duration of Rides by Month (Nov 2022 - Oct 2023)
Top 15 favorite station for casual (Nov 2022 - Oct 2023)
Top 15 favorite station for member (Nov 2022 - Oct 2023)

### After analyzing and creating visualization, I found both the similarities and differences between member and usual including insights gained from the analysis as below.
Key findings (Nov 2022 – Oct 2023)
1.	Member take rides almost twice as much as Casual during the specified period. Member take rides 2,983,881 times, while Casual take rides 1,687,261 times.
2.	Casual’s rides duration time almost twice as much as Member during the specified period. Casual’s rides duration time around 20.9 minutes, while Member’s rides duration time around 12.1 minutes.
3.	Members prefer to use classic bicycles more than electric bicycles, while Casual uses both types of bicycles almost equally.
4.	Member shows 2 peaks throughout the day in terms of number of rides. One is early in the morning at around 7.00 to 8.00 and other is in the evening at around 16.00 to 18.00 while number of rides for Casual riders increase consistently over the day until 17.00 and then decrease afterwards.
5.	Member’s number of rides on weekdays more than on weekends, while Casual’s number of rides on weekends more than weekdays.
6.	Both Member and Casual prefer to take rides on May to October. The peak month of number of rides are July and August.
7.	Casual’s average duration of bike is peak on 10.00 – 15.00 around 25 minutes, while Member’s average duration of bike is around 12 minutes throughout the day.
8.	Both Member and Casual’s average duration of bike is more on weekends. Casual’s average duration of bike on weekends is around 24 minutes while Member is around 13 minutes.
9.	Casual’s average duration of bike is highest from April to October, while Member’s average duration of bike is almost all year round, with April to October being longer than other months, but there is not much difference.
Top 5 favorite station for member are : 
1. Kingsbury St & Kinzie St     
2. Clinton St & Washington Blvd 
3. Clark St & Elm St            
4. Wells St & Concord 
5. University Ave & 57th St     
11. Top 5 favorite station for casual are
1. Streeter Dr & Grand Ave            
2. DuSable Lake Shore Dr & Monroe St  
3. Michigan Ave & Oak St              
4. DuSable Lake Shore Dr & North Blvd 
5. Millennium Park                    

Compare data analyze between sampling data (Dec 2022) analyzed from google sheet and all data (Nov 2022 – October 2023) analyzed from R studio desktop gives the result in the same direction. But some results are not exactly the same. In case we don’t have data for the entire year. We can use monthly data for analysis. But it is better to use long-term data to get more accurate results.

## Act 
Based on data analysis Casual normally use bike for exercise and travel while Member use bike to go to work. To convert casual riders into annual members. A new marketing strategy should follow the sections below.
1.	Since Casual’s average duration and number of bikes is highest from April to October. Therefore, marketing campaigns should be started before April.
2.	Since Casual’s rides duration time almost twice as much as Member. Therefore, marketing campaigns should focus on time-based costs. For example, there may be promotions such as the longer the rental period, the cheaper it is.
3.	Since Casual’s number of rides on weekends more than weekdays and Casual’s average duration time is peak on 10.00 – 15.00. Marketing campaigns should therefore offer weekend memberships and also daytime memberships.
4.	A marketing campaign should be created about the benefits of using bicycles for work. For example, everyone will be able to exercise every day while traveling to work. on all platforms, including websites, social media, brochures, and concentrate on the top 10 favorite stations for Casual.

## Wrap-up
After finishing the Cyclistic bike-share case study using the steps from the ask, prepare, process, analyze, share, and act. This case study will demonstrate these fundamental skills what I have learned from the Google Data Analytics Certificate. Thank you Google for excellent course, I learned a lot from you and I really recommend this course for all who are interested in data analytics field.
