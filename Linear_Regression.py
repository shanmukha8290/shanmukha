# -*- coding: utf-8 -*-

#Importing Libraries

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline
#Importing Dataset

df= pd.read_csv("USA_Housing.csv")
df.head()

#Total Number of Columns, total entries and the type of object of each column
df.info()

#Getting some statistical data such as mean, min, max of each column
df.describe()

#Column names
df.columns

#Plotting some useful Info
sns.pairplot(df)
sns.distplot(df['Price'])
df.corr()
sns.heatmap(df.corr(),annot = True)

#Skipping the address info for training the data as it is a string object
X = df.iloc[:,:-2].values
y = df.iloc[:,5].values

#spitting the data
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)

#create and train the Linear Regression model
from sklearn.linear_model import LinearRegression
lm = LinearRegression()
lm.fit(X_train, y_train)

#Checking the coefficients of Linear Regression model
print(lm.intercept_)
cdf = pd.DataFrame(lm.coef_, X.columns, columns = ['Coeff'])

#predicting values
predictions = lm.predict(X_test)

#comparing the y_test with predictions
plt.scatter(y_test,predictions)
#using distribution plot in seaborn
sns.distplot((y_test-predictions))

#Evaluating the metrics
from sklearn import metrics
print(metrics.mean_absolute_error(y_test, predictions))
print(metrics.mean_squared_error(y_test,predictions))
print(np.sqrt(metrics.mean_squared_error(y_test,predictions)))












