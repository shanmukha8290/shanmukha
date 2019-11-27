library(ggplot2)
library(caret)
install.packages("tree")

data(iris)

# View -> Opens the dataset in a tabular format
View(iris)

qplot(Petal.Width, Sepal.Width, data = iris, color = Species)

library(tree)


#Decision Tree
tree_clf <- tree(Species ~ Petal.Width+Sepal.Width,data = iris)

summary(tree_clf)

# Decision Tree Classification

plot(iris$Petal.Width, iris$Sepal.Width,
     col = as.numeric(iris$Species),pch = 20)
partition.tree(tree_clf, label = "Species", add = TRUE)

# Using rpart
install.packages("rpart")
library(rpart)
rpart_clf <- rpart(Species ~ .,data = iris,method = 'class')
rpart_clf

#using rattle
install.packages('rattle')
library(rattle)
fancyRpartPlot(rpart_clf, main = "IRIS TREE")