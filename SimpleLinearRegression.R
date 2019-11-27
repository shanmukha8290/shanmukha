library(corrplot)
library(plotly)
library(reshape2)
library(dplyr)
library(caTools)
library(mlbench)
library(readr)
library(datasets)


data("BostonHousing")
head(BostonHousing)

class(BostonHousing)
summary(BostonHousing)

#MEDV is normalized or not
#for that we need to plot density and distribution graph
#because y for the supervised regression data should be normalized

medv_plot <- ggplot(data = BostonHousing, aes(x=medv)) + geom_histogram(color = "red", fill="blue", bins =30)

medv_plot <- ggplot(data = BostonHousing, aes(x=medv)) + geom_histogram(aes(y=..density..),color = "red", fill="blue", bins =30)+
              geom_density(color = 'black',alpha= 0.4)
print(medv_plot)

#OutLiers in MEDV
ggplot(BostonHousing,aes(y=medv))+geom_boxplot(aes(y=medv), outlier.colour = "red")

#correlation
corrplot(cor(select(BostonHousing, -chas)),method = "number")

library(RColorBrewer)

gg <- ggplot(df, aes(x=Var1, y=Var2, fill=value, label=value)) +
  geom_tile() + theme_bw() +
  geom_text(aes(label=value, size=2)) +
  labs(title="Correlation Plot") +
  theme(text=element_text(size=12), legend.position="none")

gg + scale_fill_distiller(palette="Reds")


#LinearRegression

install.packages("caret")
library(caret)

#Scaling or Normalization
housing_scale <- cbind(scale(as.matrix(sapply(BostonHousing[1:13], as.numeric))),
                       BostonHousing[14])
                  
colnames(housing_scale)

## MODEL 3
colnames(housing_scale)
lm_model_2 <- lm (medv ~ crim + zn + nox + rm + dis +
                    rad + tax + ptratio + b + lstat, data = train_data)


summary(lm_model_2)

pred_lm2 <- predict(lm_model_2, newdata = test_data)

# Root-mean squared error
mse_lm <- sum((pred_lm2 - test_data$medv)^2/ length(test_data$medv))
mse_lm
rmse_lm <- sqrt(sum((pred_lm2 - test_data$medv)^2)/ length(test_data$medv))
rmse_lm


### DATA Partitioning #######

# Split Train & Test Dataset

# set.seed(123)

# split data will store TRUE for training i.e 80% sample
# False for Testing i.e. 20% sample
split_data <- sample.split(housing_scale, SplitRatio = 0.8)
## 80 % Data Samples
train_data <- subset(housing_scale, split_data==TRUE)
## 20% Data Samples
test_data <- subset(housing_scale, split_data==FALSE)

head(train_data)

library(ROCR)


