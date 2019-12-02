# -*- coding: utf-8 -*-
"""
Created on Mon Dec  2 18:39:43 2019

@author: shponnur
"""

#Importing Libraries
import pandas as pd


#Reading and splitting data
dF = pd.read_csv("test.csv")
X = dF.iloc[:, 0:1]
y = dF.iloc[:, -1]

from sklearn.preprocessing import PolynomialFeatures
regressor_X = PolynomialFeatures(degree = 3)
poly_X = regressor_X.fit_transform(X)

# using Linear Regression
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(poly_X,y)


#Plotting the polynomial trained data
import matplotlib.pyplot as plt
plt.scatter(X,y,color = 'red')

plt.plot(X,regressor.predict(poly_X),color = 'blue')