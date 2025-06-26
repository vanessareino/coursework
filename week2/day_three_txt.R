library(tidyverse)

magnets <- read_csv("C:/Users/ds3/Desktop/coursework/week2/magnets.csv")

#9.1 TEXTBOOK QUESTIONS

# What is the sample average of the change in score between the patients
# rating before the application of the device and the rating after the application?

summary(magnets) #The mean will be 3.5

# Is the variable active a factor or a numeric variable?

#The variable 'active' is a factor and not a numeric variable as 1 represents the active device 2 represents the placebo. 

#  Compute the average value of the variable change for the patients that
#  received and active magnet and average value for those that received an
#  inactive placebo. (Hint: Notice that the rst 29 patients received an active
#  magnet and the last 21 patients received an inactive placebo. The sub
# sequence of the rst 29 values of the given variables can be obtained via
#  the expression change[1:29] and the last 21 vales are obtained via the
#  expression change[30:50].)

magnets %>% 
  slice(1:29) %>% 
  summarize(mean_change_active = mean(change, na.rm = TRUE))

magnets %>% 
  slice(30:50) %>% 
  summarize(mean_change_placebo = mean(change, na.rm = TRUE))

#  Compute the sample standard deviation of the variable change for the
#  patients that received and active magnet and the sample standard deviation 
#  for those that received an inactive placebo.

magnets %>% slice(1:29) %>% summarize(sd_change_active = sd(change, na.rm = TRUE))
magnets %>% slice(30:50) %>% summarize(sd_change_placebo = sd(change, na.rm = TRUE))

#  Produce a boxplot of the variable change for the patients that received
#  and active magnet and for patients that received an inactive placebo.
#  What is the number of outliers in each subsequence?

magnets %>% 
  slice(1:29) %>% 
  ggplot(aes(y = change)) + 
  geom_boxplot()

magnets %>% 
  slice(30:50) %>% 
  ggplot(aes(y = change)) + 
  geom_boxplot()


#10.1 & 10.2 TEXTBOOK QUESTIONS 

#  Simulate the sampling distribution of average and the median of a sample
#  of size n = 100 from the Normal(3,2) distribution. Compute the expectation 
#  and the variance of the sample average and of the sample median.
#  Which of the two estimators has a smaller mean square error?

mu <- 3 
sig <- sqrt(2)
X.bar <- rep(0, 10^5)
X.med <- rep(0,10^5)
for(i in 1:10^5){
    X <- rnorm(100, mu, sig)
    X.bar[i] <- mean(X)
    X.med[i] <- median(X)
}

mean(X.bar)
mean(X.med)

var(X.bar)
var(X.med)

#  Simulate the sampling distribution of average and the median of a sample
#  of size n = 100 from the Uniform(0.5,5.5) distribution. Compute the
#  expectation and the variance of the sample average and of the sample median. 
#  Which of the two estimators has a smaller mean square error?

a <- 0.5
b <- 5.5
X.bar <- rep(0, 10^5)
mid.range <- rep(0,10^5)

for( i in 1:10^5){
    X <- runif(100, a,b)
    X.bar[i] <- mean(X)
    X.med[i] <- median(X)
    
}


mean(X.bar)
mean(X.med)

var(X.bar)
var(X.med)



# Compute the proportion in the sample of those with a high level of blood
# pressure.

ex2 <- read_csv("C:/Users/ds3/Desktop/coursework/week2/ex2 (1).csv")

ex2 %>% filter(group == "HIGH") %>% summarise(count_high=n()) %>%
    mutate(proportion_high = count_high/150)

# Compute the proportion in the population of those with a high level of
#  blood pressure.

pop2 <- read_csv("C:/Users/ds3/Desktop/coursework/week2/pop2 (1).csv")

p <- pop2 %>% filter(group == "HIGH") %>% summarise(count_high=n()) %>%
    mutate(proportion_high = count_high/100000)

# Simulate the sampling distribution of the sample proportion and compute
#  its expectation.

P.hat <- rep(0,10^5)

for (i in 1:10^5 )
{
    X <- sample(pop2$group, 150)
    P.hat[i] <- mean (X == "HIGH")
}

mean(P.hat)

# Compute the variance of the sample proportion

var(P.hat)

#  It is proposed in Section 10.5 that the variance of the sample proportion
#  is Var( P) = p(1-p)/n, where p is the probability of the event (having a
#  high blood pressure in our case) and n is the sample size (n = 150 in our
#  case). Examine this proposal in the current setting.

p <- mean(P.hat)
n <- 150

p * (1-p) / n

#CHAPTER 2 TEXTBOOK QUESTIONS 

# (a)What proportion of patients in the treatment group and what proportion of patients in the
#  control group died?

proportion_treatment_dead <- 45/69
proportion_control_dead <- 30/34

# (b)One approach for investigating whether or not the treatment is effective is to use a 
# randomization technique.

# i.What are the claims being tested? Use the same null and alternative hypothesis notation
#  used in the section.

#H0 - The results of the control group and the treatment are equal meaning thr treaments is unsuccessful
#HA - The treatment is sucessful with the prortion of alive of the tramnt group is greater than the control
# group. 

# i. The paragraph below describes the setup for such approach, if we were to do it with
# out using statistical software. Fill in the blanks with a number or phrase,whichever is
#  appropriate.

#  We write alive on (blue) cards representing patients who were alive at
#  the end of the study, and dead on (red) cards representing patients
#  who were not. Then,we shuffle these cards and split them into two groups:
#  one group of size (69) representing treatment, and another group of
#  size (34) representing control. We calculate the difference between
#  the proportion of dead cards in the treatment and control groups(treatment
# control)andrecordthisvalue.We repeat this many times to build a distribution
#  centered at (45 - 30 = 15) .Lastly,we calculate the fraction of simulations where
#  the simulated differences in proportions are (0.65, 0.88)  . If this fraction is low,
#  we conclude that it is unlikely to have observed such an outcome by chance and that the null 
#  hypothesis shoul be rejected in favor of the alternative. 

# iii.What do the simulation results shown below suggest about the effectiveness of the 
# transplant program?

#The simulayion results belwo suggect that the transplant program is not effective. 


#EXCERCISE 2.6 

# (a) What are the hypotheses?

# HA - A person yawning causes another person nearby to yawn
# HO - A person yawing does not to cause another person nearby to yawn 

# (b) Calculate the observed difference between the yawning rates under the two scenarios.

proportion_t = 34/50
proportion_c = 16/50

observed_difference = proportion_c - proportion_t

# (c) Estimate the p-value using the figure above and determine the conclusion of the hypothesis
#  test.


# 9.2 TEXTBOOK QUESTION 

expectation <- 3.5
sd_active <- 3
sd_inactive <- 1.5
n <- 29 + 21


