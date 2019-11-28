# Hierarchical Clustering

# Importing the dataset
dataset = read.csv('E:/R/RData/Mall_Customers.csv', header = TRUE)
View(dataset)

dataset = dataset[4:5]

View(dataset)
dataset$
# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Annual.Income..k.., SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Using the dendrogram to find the optimal number of clusters
# hclust : to create hierarchical clustering
dendrogram = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')
plot(dendrogram,
main = paste('Dendrogram'),
xlab = 'Customers',
ylab = 'Euclidean distances')

# Fitting Hierarchical Clustering to the dataset
hc = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')
y_hc = cutree(hc, 5)
hc
# Visualising the clusters
library(cluster)
clusplot(dataset,
y_hc,
lines = 0,
shade = TRUE,
color = TRUE,
labels= 2,
plotchar = FALSE,
span = TRUE,
main = paste('Clusters of customers'),
xlab = 'Annual Income',
ylab = 'Spending Score')
