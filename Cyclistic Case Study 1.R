

# First install packages

# 1.tidyverse  2.skimr  3.readxl  4.readr  5.dplyr  6.tidyr  7.data.table 


install.packages("tidyverse")
install.packages("skimr")
install.packages("readxl")
install.packages("readr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("data.table")


library(tidyverse)
library(skimr)
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(data.table)


# next is import data files

nov_2020 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/nov_2020.xlsx")
dec_2020 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/dec_2020.xlsx")
jan_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/jan_2021.xlsx")
feb_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/feb_2021.xlsx")
mar_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/mar_2021.xlsx")
apr_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/apr_2021.xlsx")
may_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/may_2021.xlsx")
jun_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/jun_2021.xlsx")
jul_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/jul_2021.xlsx")
aug_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/aug_2021.xlsx")
sep_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/sep_2021.xlsx")
oct_2021 <- read_excel("C:/Users/Fola/Desktop/excel work around/excel clean/oct_2021.xlsx")


# next is combine data files into one data frame

all_trips <- rbind(nov_2020, dec_2020, jan_2021, feb_2021, mar_2021, apr_2021, may_2021, jun_2021, jul_2021, aug_2021, sep_2021, oct_2021)


# next is calculate ride length. by end time - start time

all_trips_v2 <- all_trips %>% 
  mutate(ride_length = difftime(ended_at, started_at, units = "mins"))


# check for negative/ ride length less than zero

nrow(subset(all_trips_v2, ride_length < 0))


# drop ride length less than zero because this information is incorrect. 

all_trips_v3 <- all_trips_v2[!(all_trips_v2$ride_length < 0),]


# check for test rides

nrow(subset(all_trips_v3, start_station_name %like% "TEST"))
nrow(subset(all_trips_v3, start_station_name %like% "test"))
nrow(subset(all_trips_v3, start_station_name %like% "Test"))


# drop all test rides

all_trips_v4 <- all_trips_v3[!((all_trips_v3$start_station_name %like% "TEST")),]


# export csv file

write.csv(all_trips_v4,'all_trips_v4.csv')

