# Compute the rate for table2, and table4a + table4b. You will need to perform four operations:
# Extract the number of TB cases per country per year.
# Extract the matching population per country per year.
# Divide cases by population, and multiply by 10000.
# Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?
#rate = cases / population

table2_wider <- pivot_wider(table2, names_from = type, values_from = count) %>% 
mutate( rate_table2 = cases/population)

table4a_longer <- pivot_longer(table4a, cols = c('1999','2000'), names_to = 'Year', values_to = 'Cases' ) 
table4b_longer <- pivot_longer(table4b, cols = c('1999','2000'), names_to = 'Year', values_to = 'Population' ) %>% 
    inner_join(table4a, table4b)

rate_table4a_table4b <- inner_join(table4a_longer, table4b_longer) %>% mutate(Rate = (Cases / Population) *1000)

# Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
# (Hint: look at the variable types and think about column names.)

# pivot_longer() and pivot_wider() are not perfectly symmetrical becuase in pivot_wider() each unique value will be turned into a column name 
# while in pivot_longer() calls keys and valuse columns to create new columns in order to made the data "longer"

# Why does this code fail?

table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

#This code fails becuase the columns names 1999 and 2000 must be in quotes due to their data type being integers and without them R will
# interpret the column names as number values. 

table4a %>% 
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

# What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

people <- tribble(

  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

# This is a bad data set there must be another column that has a unique identody to be ble to dignies bewyeen people who have the same name, age or hieght. 

#5.2 TEXTBOOK QUESTIONS





  

