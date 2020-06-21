# REGRESSION #

# The analysis and data are derived from the book
# 'Discovering Statistics Using R'
# by Andy Field Jeremy Miles & Zöe Field (2012)

# This is a tutorial to remember key concepts and 
# to store code that I could use in the future


# Reading packages
library(boot)
library(car)
library(ggplot2)
library(QuantPsyc)


# 1 - Simple regression #

# Data
album1 <- read.csv("https://raw.githubusercontent.com/GabrielReisR/BasicsOf/master/Data%20Files/Album%20Sales%201.csv",
                   sep = ",")
head(album1)

# In this data, we have the records of sales (in thousands) and the amount 
# of money spent on advertising (in thousands of $) for a recording company


# Looking at the two variables
albumPlot <- ggplot(album1, aes(x = adverts, y = sales)) + 
             labs(x = "Money spent on advertising (in thousands of $)", 
                  y = "Sales (in thousands)") +
             geom_point() + geom_smooth(method = "lm", colour = "#06A9CF", se = F) + 
             theme_minimal()
            

albumPlot


# Seems like there is a positive association between the two variables.
# This is to say, the more money spent on advertising an album, the more this
# particular album will sell.
# This doesn't answer the question, though. 
# We want to predict the sales based on the money spent on advertising.
# The question is:
# 'how many 1 (thousands) sales increase with the increase
# of 1 (thousands of $) in money spent on advertising?'


# Model 1
albumRegressionModel1 <- lm(sales ~ adverts, data = album1)
summary(albumRegressionModel1)

# Analysing output of M1:



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



# R-squared is accounting for approximately 33% of the variance (R² = 0.3313).

# p for the intercept and adverts are both < .05. This isn't as important as the
# values for each, though.

# As with the scatterplot, we see that when X = 0 (no money on advertising), 
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


# $1000 spent on advertising is equal to somewhat 96 MORE albums sold. 
# This doesn't look so good.
# Why spend money on advertising if my baseline for selling albums is 134100?!
# If we were to sell each album for $10, we'd have only more $960 in revenue,
# meaning a -$40 loss.

# It seems like more variables are at play.
# This brings us to multiple regression.


# 2 - Multiple regression #
# Data
album2<-read.csv("https://raw.githubusercontent.com/GabrielReisR/BasicsOf/master/Data%20Files/Album%20Sales%202.csv",
                   sep = ",")
head(album2)

# Question: 'how many 1000 sales increase with the increase of 1 in adverts, 
# 1 in airplay quantity and 1 in mode of band attraction?'

albumSalesRegression2 <- lm(sales ~ adverts, data = album2)
albumSalesRegression3 <- lm(sales ~ adverts + airplay + attract, data = album2)
summary(albumSalesRegression2)
summary(albumSalesRegression3)

# Comparing models
# Question: 'is model 3 better (has less residuals) than model 1?'
anova(albumSalesRegression1, albumSalesRegression3)

# Standardized beta-values
# Question: 'how many standard deviations (SDs) in y will occur when increasing 
# 1 SD of B?'
lm.beta(albumSalesRegression3)

# Confidence interval for the parameters
confint(albumSalesRegression3)


# 3 - Assessing outliers and influential cases #

# Creating these variables to join them after so we can compare the values
album2$residuals<-resid(albumSales.3)
album2$standardized.residuals<-rstandard(albumSales.3)
album2$studentized.residuals<-rstudent(albumSales.3)
album2$cooks.distance<-cooks.distance(albumSales.3)
album2$dfbeta<-dfbeta(albumSales.3)
album2$dffits<-dffits(albumSales.3)
album2$hatvalues<-hatvalues(albumSales.3)
album2$covariance.ratios<-covratio(albumSales.3)

# Saving them in a table
round(album2, digits = 3)
names(album2)
write.table(album2, "Album Sales with Diagnostics.xls", sep = "\t",
            row.names = FALSE)

#Verificar dados segundo um ponto de corte, e salvá-los como outra variável#
album2$standardized.residuals > 2 | album2$standardized.residuals < -2
album2$large.residuals<-album2$standardized.residuals > 2 | album2$standardized.residuals < -2
  #Quantos casos?#
  sum(album2$large.residuals)
  #Quais casos? - rodar o dataframe especificando quais casos e quais variáveis ver#
  album2[album2$large.residuals == TRUE, c("sales", "airplay", "attract", "adverts", "standardized.residuals")]
  album2[album2$large.residuals == TRUE, c("cooks.distance", "hatvalues", "covariance.ratios")]

# 4 - Assessing assumptions #

# Assessing the assumption of independence - será que há correlação entre os erros do modelo? (1<x<3)#
dwt(albumSales.3)

#Assessing the assumption of multicollinearity - será que há correlação entre os preditores do modelo?#
vifA3 <- vif(albumSales.3)
#tolerance - problemas quando 1/vif < 0.2#
1/vifA3
mean(vifA3)

# Assessing dispersion of residuals
plot(albumSales.3)
hist(album2$studentized.residuals)

# Bootstrapping a regression
library(boot)
bootReg <- function (formula, data, indices)
{
  fit <- lm(formula, data = data[indices,])
  return(coef(fit))
}
bootResults <- boot(statistic =bootReg, formula = sales ~ adverts +airplay +
                    attract, data =album2, R =2000)
bootResults
boot.ci(bootResults, type = "bca", index = 1)
boot.ci(bootResults, type = "bca", index = 2)
boot.ci(bootResults, type = "bca", index = 3)
boot.ci(bootResults, type = "bca", index = 4)

# 5 - Useful things like dummy coding

# Dummy coding categorical variables
glastonburyFestival <- read.csv("https://raw.githubusercontent.com/GabrielReisR/BasicsOf/master/Data%20Files/GlastonburyFestivalRegression.csv",
                                  sep = ",")
names(glastonburyFestival)

# Setting it almost aumotically
contrasts(glastonburyFestival$music) <- contr.treatment(4, base = 4)
glastonburyFestival$music

# Giving helpful names
music_Crusty <- c(1,0,0,0)
music_Indie <- c(0,1,0,0)
music_Metaller <- c(0,0,1,0)
contrasts(glastonburyFestival$music) <- cbind(music_Crusty, music_Indie, music_Metaller)

# Now we can run a regression
glastonburyModel <- lm(change ~ music, data = glastonburyFestival)
summary(glastonburyModel)
