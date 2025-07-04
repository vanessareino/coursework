########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)

  ggplot(trips, aes(x = tripduration)) + geom_histogram(bins = 30) + scale_x_log10(labels = comma)
  ggplot(trips, aes(x = tripduration)) + geom_density(fill = 'blue') + scale_x_log10(labels = comma) 


# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
  ggplot(trips, aes(x = tripduration, fill = usertype )) + geom_histogram() + scale_x_log10(labels = comma) + labs(fill = "User Type")
  ggplot(trips, aes(x = tripduration, fill =  )) + geom_density() + scale_x_log10(labels = comma) + labs(fill = "User Type")

# plot the total number of trips on each day in the dataset

trips %>%  mutate(date = as.Date(starttime)) %>% ggplot(aes(x = date)) + geom_histogram(bins=365)

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

trips %>% group_by(birth_year, gender) %>% ggplot(aes(x = birth_year, fill = gender)) + geom_histogram()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

trips %>% mutate(year = year(starttime)) %>% mutate(age = year - birth_year) 
group_by(gender, age ) %>% summarise(count= n()) %>% 
pivot_wider(names_from = gender, values_from = count) %>% 
mutate(gender_ratio = Male/Female) %>% ggplot(aes(x= age, y= gender_ratio)) + geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>% pivot_longer(cols = c(tmin, tmax), names_to = "temp_type", values_to = "temp_value") %>% ggplot(aes(x = ymd, y = temp_value, color = temp_type)) + geom_line()
 
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather %>% group_by(date, tmin) %>% summarise (count = n()) %>% ggplot(aes(x = count, y = tmin)) + geom_point()
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

 trips_with_weather %>% group_by(date, tmin) %>% summarise (count = n(), avg_prcp = mean(prcp)) %>% mutate(substantial_prcp = prcp >= avg_prcp) %>% ggplot(aes(x = count, y = tmin)) + geom_point(color = substantial_prcp) 


# add a smoothed fit on top of the previous plot, using geom_smooth

 trips_with_weather %>% group_by(date, tmin) %>% summarise (count = n(), avg_prcp = mean(prcp))  %>% ggplot(aes(x = count, y = tmin)) + geom_point() + facet_wrap(~ avg_prcp) + geom_smooth(method = 'lm')


# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package
# plot the above

trips %>% mutate ( date = as_date(starttime), hours = hour(starttime)) %>% count (date, hours) %>% group_by(hours) %>% summarise (avg_trips = mean(n), Stand_Dev_Trips = sd(n)) %>% ggplot (aes(x= hours , y= avg_trips )) + geom_line(aes(color = avg_trips)) + geom_ribbon(aes(ymin = avg_trips - Stand_Dev_Trips, ymax = avg_trips + Stand_Dev_Trips),alpha = 0.25 )


# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

trips %>% mutate ( date = wday(starttime, label = TRUE), hours = hour(starttime)) %>% count (date, hours) 
%>% group_by(date) %>% summarise (avg_trips = mean(n), Stand_Dev_Trips = sd(n)) %>% ungroup() 
%>% ggplot (aes(x= date , y= avg_trips )) + geom_line(aes(group = 1)) 
+ geom_ribbon(aes(ymin = avg_trips - Stand_Dev_Trips, ymax = avg_trips + Stand_Dev_Trips, group = 1),alpha = 0.25 )
