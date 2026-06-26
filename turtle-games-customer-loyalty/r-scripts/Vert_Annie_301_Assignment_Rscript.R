library(tidyverse)
setwd('/Users/annievert/Desktop/LSE COURSE EVERYTHING/Course 3 /ASSIGNMENT/LSE_DA301_assignment_files_new/')
getwd()

# load data
turtle <- read.csv('turtle_reviews.csv', header=TRUE)

# view
head(turtle)

# rename columns
turtle <- turtle[, !names(turtle) %in% c('language', 'platform')]

library(dplyr)
turtle <- turtle %>% rename(remuneration = remuneration..k..,
                    spending_score = spending_score..1.100.)

head(turtle)

summary(turtle)

# plotting salary and loyalty points based on gender
ggplot(turtle,
       mapping=aes(x=remuneration, y=loyalty_points)) +
  geom_point(color='blue',
             alpha=0.75,
             size=2.5) +
  scale_x_continuous(breaks=seq(0, 150, 10), "remuneration ($1,000)") +
  scale_y_continuous(breaks=seq(0, 7000, 1000), "loyalty points") +
  labs(title="Relationship between remuneration and loyalty points") + 
  facet_wrap(~gender)


ggplot(turtle, mapping=aes(x=age)) +
  geom_histogram(color='blue') +
  labs(title="Age Distribution") +
  facet_wrap(~gender)

# age vs loyalty points 
ggplot(turtle, aes(x=age, y=loyalty_points)) +
  geom_point() + geom_smooth(method='lm')


# spending score vs loyalty points 
ggplot(turtle, aes(x=spending_score, y=loyalty_points)) + 
  geom_point() + geom_smooth(method='lm')

# FINDING: spending score is almost perfectly evenly distributed 

# loyalty points by education level
ggplot(turtle, aes(x=education, y=loyalty_points)) +
  geom_boxplot()


# loyalty points by gender
ggplot(turtle, aes(x=loyalty_points, fill=gender)) +
  geom_density(alpha=0.5) +
  labs(title="Loyalty Points Distribution by Gender")

#loyalty points by edu level 
ggplot(turtle, aes(x=loyalty_points, fill=education)) +
  geom_density(alpha=0.5) +
  labs(title="Loyalty Points Distribution by Education")


turtle <- turtle %>%
  mutate(spend_segment = case_when(
    spending_score < 33 ~ "Low",
    spending_score < 66 ~ "Medium",
    TRUE ~ "High"
  ))

# spending score segments 
ggplot(turtle, aes(x=spend_segment, y=loyalty_points, fill=spend_segment)) +
  geom_violin() +
  labs(title="Loyalty Points by Spending Segment")

install.packages("GGally")
library(GGally)

turtle %>% 
  select(age, remuneration, spending_score, loyalty_points) %>%
  ggpairs() +
  labs(title= 'Relationship Pairplot')

ggpairs(turtle, 
        columns = c("age", "remuneration", "spending_score", "loyalty_points"),
        lower = list(continuous = wrap("points", color = "blue", alpha = 0.3)),
        diag = list(continuous = wrap("densityDiag", fill = "blue", alpha = 0.5))) +
  labs(title= 'Relationship Pairplot')

# loyalty points are primarily driven by spending behaviour 
# and income level, not age. The fact that remuneration and
# spending score are largely independent of each other (0.006) 
# both strongly predict loyalty points is also worth flagging
# they seem to be capturing different aspects of customer value.
# highest spenders have the most points and higher earners have more points 


## checking for normal distrubution 

# Specify the qqnorm function.

qqnorm(turtle$loyalty_points,
       col='blue',
       xlab="z Value",
       ylab='Points')

# Specify the qqline function.
# Add a reference line to the qqplot.
qqline(turtle$loyalty_points,
       col='red',
       lwd=2) 

# Run a Shapiro-Wilk test.
shapiro.test(turtle$loyalty_points)

# install moments package 
install.packages("moments")
library(moments)

# Specify the skewness and kurtosis functions.
skewness(turtle$loyalty_points)
kurtosis(turtle$loyalty_points)

# checking for normality
shapiro.test(turtle$age)
shapiro.test(turtle$remuneration)
shapiro.test(turtle$spending_score)
# none of these values are normally distributed 

# running model 
# Select only the numeric columns for correlation
sub_turtle <- turtle[, c("age", "remuneration", "spending_score", "loyalty_points")]

# Create a correlation matrix
cor(sub_turtle)

# installing psych for layout
install.packages("psych")
library(psych)
pairs.panels(sub_turtle)

# build an MLR model 
model <- lm(loyalty_points ~ age + remuneration + spending_score, data = turtle)

# View the results
summary(model)

# test the model 

# new data frame for a test customer
new_customer <- data.frame(age = 37, 
                           remuneration = 52, 
                           spending_score = 75)

# show prediction
predict(model, newdata = new_customer)


# plot predicted values vs actual values 
#generate all predicted values 
predictions <- predict(model)

#plot
plot(turtle$loyalty_points, predictions,
     main = "Actual vs. Predicted Loyalty Points",
     xlab = "Actual Points",
     ylab = "Predicted Points",
     pch = 19, 
     col = adjustcolor("blue", alpha.f = 0.4)) 

# Add a reference line
abline(0, 1, col = "red", lwd = 2)

# performing log transformation on loyalty points to adjust for uncertainty in point accumulation 

# adding new column
turtle$log_loyalty <- log(turtle$loyalty_points + 1)

# creating model 
model_log <- lm(log_loyalty ~ age + remuneration + spending_score, data = turtle)

# View results
summary(model_log)
turtle$log_loyalty <- log(turtle$loyalty_points + 1)

## FINDING
# R squared value decreases when loyalty points has been transformed with log function (0.83->0.81)

# visualize difference in actual vs predicted with log model 
# Generate predictions 
log_preds <- predict(model_log)

# Plot
plot(turtle$log_loyalty, log_preds,
     main = "Log-Transformed: Actual vs. Predicted",
     xlab = "Actual (Log Scale)",
     ylab = "Predicted (Log Scale)",
     pch = 19, col = adjustcolor("darkgreen", alpha.f = 0.4)) +
  abline(0, 1, col = "red", lwd = 2)



# RANDOM FOREST MODEL 
install.packages("randomForest")
library(randomForest)

# Train/test split (80/20)
set.seed(123)
train_index <- sample(1:nrow(turtle), 0.8 * nrow(turtle))
train_data <- turtle[train_index, ]
test_data <- turtle[-train_index, ]

# Build the model on training data only
rf_model <- randomForest(loyalty_points ~ age + remuneration + spending_score, 
                         data = train_data,  
                         ntree = 500, 
                         importance = TRUE)

# Predict on test data
rf_preds <- predict(rf_model, newdata = test_data)

# Plot actual vs predicted on test data
plot(test_data$loyalty_points, rf_preds,
     main = "Random Forest: Actual vs. Predicted (Test Set)",
     xlab = "Actual Points",
     ylab = "Predicted Points",
     pch = 19, col = adjustcolor("purple", alpha.f = 0.4))
abline(0, 1, col = "red", lwd = 2)

# Calculate actual accuracy on test set
test_actual <- test_data$loyalty_points
ss_res <- sum((test_actual - rf_preds)^2)
ss_tot <- sum((test_actual - mean(test_actual))^2)
r_squared_test <- 1 - (ss_res / ss_tot)
print(paste("Test set R-squared:", round(r_squared_test, 4)))


## FINDING very high rsquared value after being split to avoid overfitting 
## positions the random forest model as the best fit for predicting future outcomes 
## RF model should be used moving forward to predict Loyalty points based on 
## age, remuneration and spending score



















