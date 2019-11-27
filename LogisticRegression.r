titanic <- read.csv('Titanic_Data.csv', header=T, na.strings=c(""))

# Number of columns
ncol(titanic)
# number of rows
nrow(titanic)

head(titanic)

str(titanic)

# sapply(data, function), is.na(woman) returns TRUE for NA
#sapply(titanic, function(f(x)) sum(is.na(f(x))))
sapply()
# unique value of data
sapply(titanic, function(f(x)) length(unique(f(x))))

## Missing Value

library(Amelia)
missmap(titanic, main = "Missing Values vs. Observed")

# df <- na.omit(titanic)

# nrow(df)
# sum(is.na(titanic$Cabin))

titanic_df <- subset(titanic, select = c(2,3,5,6,7,8,10,12))
ncol(titanic_df)

missmap(titanic_df, main = "Missing Values vs. Observed")
sum(is.na(titanic_df$Age))

avg.age <- mean(titanic_df$Age, na.rm = T)

print(avg.age)

titanic_df$Age[is.na(titanic$Age)] = avg.age

titanic_df$Age

missmap(titanic_df,main="Missing Values Vs Observed")

titanic_df <- na.omit(titanic_df)
missmap(titanic_df,main="Missing Values Vs Observed")
nrow(titanic_df)

gg <- ggplot(titanic_df,aes(x=Survived, fill=Sex))


gg + geom_bar(position="dodge") +
  labs(title = "Titanic - Male vs Female in Each Class")

##
ggplot(titanic,aes(x=Pclass,fill=Sex))+
  geom_bar(position="dodge")+
  facet_grid(". ~ Survived") +
  labs(title = "Titanic - Survived vs Not Survived in Each PClass")

# Splitting The Data Sets

split_data <- sample.split(titanic_df ,SplitRatio = 0.8)

train_data = subset(titanic_df, split_data==T)

test_data = subset(titanic_df, split_data==F)

# Logistic Regression

# Model
logit_model <- glm(Survived ~.,family=binomial(link='logit'),
                   data = train_data)
summary(logit_model)

res <- predict(logit_model,test_data,type="response")
summary(res)
print(res)

#Confusion Matrix
table(res>0.4,test_data$Survived)

library(ROCR)
predicted_val = predict(logit_model, newdata = test_data)
ROCRPred <- prediction(predicted_val,test_data$Survived)
ROCRPref <- performance(ROCRPred,"tpr","fpr")

# Receiver Operating Characteristic Curve(ROC)
plot(ROCRPref,colorize=TRUE,print.cutoffs.at=seq(0.1))