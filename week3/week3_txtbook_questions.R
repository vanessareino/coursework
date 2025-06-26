body <- read_table("body.dat.txt")

weight <- body$height[116:120]
height <- body$height[122:126]

body %>%
    ggplot(aes(x= x23, y = x24)) + geom_point()

library(tidyverse)

model <- lm(x23 ~ x24, data = body)
model

#3.6.3

lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

lm.fit <-lm(medv~., data = Boston)
summary(lm.fit)

library(car)
vif(lm.fit)

lm.fit1 <-lm(medv~.- age, data = Boston)
summary(lm.fit1)

lm.fit1 <-update(lm.fit,~.- age)


#3.6.4
summary(lm(medv~lstat * age, data = Boston))

#3.6.5
lm.fit2 <-lm(medv∼lstat + I(lstat^2))
summary(lm.fit2)
lm.fit <-lm(medv∼lstat)
anova(lm.fit, lm.fit2)

par(mfrow = c(2, 2))
plot(lm.fit2)

lm.fit5 <- lm(medv ∼ poly(lstat, 5))
summary(lm.fit5)
summary(lm(medv ∼ log(rm), data = Boston))

#3.6.6
head(Carseats)
lm.fit <- lm(Sales ∼ . + Income:Advertising + Price:Age, data = Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)

#6.1


#6.2


#6.3





