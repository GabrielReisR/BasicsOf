################# SIMPLE REGRESSION #################

#' Analysis and data are derived from the book
#' 'Discovering Statistics Using R'
#' by Andy Field Jeremy Miles & Zöe Field (2012)
#' Explanations and interpretations are mine

#' This is a tutorial to remember key concepts and 
#' to store code that I could use in the future

####################################################

# Reading packages
library(boot)
library(car)
library(ggplot2)
library(QuantPsyc)


# Simple regression #

#' Data
album1 <- read.csv("https://raw.githubusercontent.com/GabrielReisR/BasicsOf/master/Data%20Files/Album%20Sales%201.csv",
                   sep = ",")
head(album1)

#' In this data, we have the records of sales (in thousands) and the amount 
#' of money spent on advertising (in thousands of $) for a recording company


#' Looking at the two variables
albumPlot <- ggplot(album1, aes(x = adverts, y = sales)) + 
             labs(x = "Money spent on advertising (in thousands of $)", 
                  y = "Sales (in thousands)") +
             geom_point() + geom_smooth(method = "lm", colour = "#06A9CF", se = F) + 
             theme_minimal()
            

albumPlot


#' Seems like there is a positive association between the two variables.
#' This is to say, the more money spent on advertising an album, the more this
#' particular album will sell.
#' This doesn't answer the question, though. 
#' We want to predict the sales based on the money spent on advertising.
#' The question is:
#' 'how many 1 (thousands) sales increase with the increase
#' of 1 (thousands of $) in money spent on advertising?'


# Model 1 #
albumRegressionModel1 <- lm(sales ~ adverts, data = album1)
summary(albumRegressionModel1)

#' Analysing output of M1:


####################################################

# Residuals:
#     Min       1Q   Median       3Q      Max 
#-152.949  -43.796   -0.393   37.040  211.866 

#Coefficients:
#               Estimate Std. Error t value   Pr(>|t|)    
#  (Intercept) 1.341e+02  7.537e+00  17.799   <2e-16 ***
#  adverts     9.612e-02  9.632e-03   9.979   <2e-16 ***

# Residual standard error: 65.99 on 198 degrees of freedom
# R-squared:  0.3346,	Adjusted R-squared:  0.3313 
# F-statistic: 99.59 on 1 and 198 DF,  p-value: < 2.2e-16

####################################################


# Results #

# R-squared is accounting for approximately 33% of the variance (R² = 0.3313).

# p for the intercept and adverts are both < .05. This isn't as important as the
# values for each, though.

# As with the scatterplot, we see that when Y(0) = 134,10
# That is: when X = 0 (no money on advertising),
# y = 134.10 (134,100 thousands of albums sold)

# Regression formula => Y = (b0 + b1 * x1) + error
# Y = AlbumSales, b0 = Intercept, b1 = AdvertsCoefficient, x1 = MoneyOnAdverts
# Replacing the values for the regression formula, We have the following:
# AlbumSales = 134,10 + 0,0961 * MoneyOnAdverts (+ error)

# If this company were to spend nothing ($0) on  the advertising for a new album, 
# they could expect to sell approximately:
# AlbumSales = 134,10 + 0,0961 * (0) = 134,10 * 1000 = 134100 albums.

# If this company were to spend $1000 on  the advertising for a new album, 
# they could expect to sell approximately:
# AlbumSales = 134,10 + 0,0961 * (1) = 134196 albums.


# Discussion #

#' $1000 spent on advertising is equal to somewhat 96 MORE albums sold. 
#' This doesn't look so good.
#' Why spend money on advertising if my baseline for selling albums is 134100?!
#' If we were to sell each album for $10, we'd have only more $960 in revenue,
#' meaning a -$40 loss.

#' It seems like more variables are at play. Although it seems great to
#' predict 33% with just one variable, our model doesn't seem 
#' too robust right now. We'll have to rethink about what's influencing
#' the number of sales. Another variables seems to be at play.
#' This brings us to multiple regression.
####################################################
