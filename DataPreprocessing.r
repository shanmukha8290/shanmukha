iris
data ("iris")
head(iris)

ggplot(data = iris, aes (x = Petal.Width, y= Petal.Length, color = Species))+
  geom_point()

iris_norm <- apply(iris[, 1:4],2,function(x)(x - min(x))/(max(x)-min(x)))
iris_norm

iris_df <- as.data.frame(iris_norm)

#Adding New column to DF

iris_df$Species <- iris$Species

iris_df

summary(iris_df)
ggplot(data = iris_df, aes(x = Petal.Length))+geom_density()
