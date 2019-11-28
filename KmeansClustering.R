# install.packages("tidyverse")
# install.packages("cluster")
# install.packages("factoextra")
library(datasets) # USA Arrests
library(tidyverse) # data manipulation
library(cluster) # clustering algorithms
library(factoextra) # clustering algorithms & visualization
data ("USArrests")
head(USArrests)

View(USArrests)

df <- USArrests

sum(is.na(USArrests))

df <- na.omit(df)

df <- scale(df)

head(df)
'
get_dist: for computing a distance matrix between the rows of a data matrix. 
The default distance computed is the Euclidean; however, get_dist also supports 
distanced described in equations 2-5 above plus others.
fviz_dist: for visualizing a distance matrix'

distance <- get_dist(df)
fviz_dist(distance, gradient = 
list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

k2 <- kmeans(df, centers = 2, nstart = 25)

str(k2)

k2
# Display each rows value of cluster
k2$cluster

# Centroids of both clusters
k2$centers

# total wcss
k2$tot.withinss

fviz_cluster(k2, data = df)

df %>%
as_tibble() %>%
mutate(cluster = k2$cluster,
state = row.names(USArrests)) %>%
ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
geom_text()

k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point", data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point", data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point", data = df) + ggtitle("k = 5")
print

library(gridExtra)

grid.arrange(p1, p2, p3, p4, nrow = 2)

set.seed(123)

# function to compute total within-cluster sum of square 
wss <- function(k) {
kmeans(df, k, nstart = 10 )$tot.withinss
}

# Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)
print(wss_values)

## Elbow Method
plot(k.values, wss_values,
type="b", pch = 19, frame = FALSE, 
xlab="Number of clusters K",
ylab="Total within-clusters sum of squares")

set.seed(123)

## Plotting WCSS vs K Clusters 
fviz_nbclust(df, kmeans, method = "wss")

cluster_1 <- kmeans(df, centers = 4, nstart = 10)

str(cluster_1)

cluster_1
# Display each rows value of cluster
cluster_1$cluster

# Centroids of clusters
cluster_1$centers

# total wcss
cluster_1$tot.withinss

fviz_cluster(cluster_1, data = df)
