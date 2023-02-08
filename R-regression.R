################################################################################
### Tommaso Viola 10/2022 
### Transport Research Methods
### Workshop on regression in R

#' R is a very powerful tool to run linear models. It provides several utilities
#' to run the model, check the diagnostics, plot the predicted values and obtain
#' the required parameters.
#' 
#' The present tutorial will be mostly based on the mtcars dataset for consistency
#' with previous exercises with R.

#' Let's run this to replace the default theme in plotting:
require(ggplot2)
theme_set(theme_bw())
#' You can add additional options to have them applied to each plot forward.

#' Let's start with our dataset.
#' We might be interested in investigating whether the power of the car influences
#' the fuel economy. This might affect our purchase decision!
#' We therefore have two continuous variables, a perfect scenario for a linear
#' model.
#' 
#' More specifically we have:
#' - Dependent variable: mpg (fuel consumption) [Y]
#' - Independent / explanatory variable: hp     [X]
#' 
#' To concisely remind ourselves, in a linear regression model, we attempt to do 
#' a few things:
#' - describe the relationship between two variables
#' - explain the variance in the outcome variable with the variance in the 
#'   explanatory variable
#' - infer whether the relationship is statistically significant
#' - make predictions in other scenarios
#'
#' R gives us the tool to do everything very easily.
#' 
#' Very briefly, most linear models in R are fitted using a Least Squares method.
#' R finds the best coefficients defining the regression line by minimising the
#' squared errors (the distance between the line and the actual data points).
#' Alternative approaches such as maximum likelihood can be used, and are as easy
#' to implement in R. In case of need I recommend to do some research online!

### First fit ##################################################################
#' In R a regression model is fitted by the function lm()
#' In the function we usually need to specify two main arguments:
#' - Formula: a recurrent expression used in R to describe the relationship 
#'   between variables. The general expression takes the following form:
#'   (Predicted variable) ~ (Predictors)
#' - Data: you should specify the dataset to direct R to the right place!

#' To see this in practice, let's first have a look at our variables in a plot,
#' which is always good practice. Remember, we won't find anything in our analyses
#' unless the data is telling us so!
ggplot(data = mtcars, aes(x = hp, y = mpg)) + geom_point()

#' The plot definitely shows a negative relationship between the variables so that
#' with higher power, there is less fuel economy, as we would expect.
#' Let's model this.
fit = lm(data = mtcars, mpg ~ hp)

#' What we do here is specify the simple linear model. On the right, you can see
#' how the formula is written. Here mpg is predicted by (~) hp.

#' Now that R has fitted the model for us, how do we investigate it? Note too that
#' we had to name the model (fit).
summary(fit)

#' We see a few things:
#' - Residuals: information on the residuals, as the differences between the data
#'   and the predicted values of the model.
#' - Coefficients: the coefficients of the regression line, more on this in a second.
#' - Model fit indexes: standard error of the residuals, R squared and the results
#'   of an F test against an intercept-only model (with no predictors)

#' The most important things for us now are the coefficients, let's have a look 
#' at them.
#' The intercept represents the mean value of mpg when hp is equal to zero.
#' Does it make sense though? Can we have cars with 0 horse-power?
#' In order to obtain a more meaningful interpretation of the intercept, and 
#' a good practice in general, we should standardise (centre) our dependent 
#' variable. We can use the function scale().
#' The scaled predictor will now have a mean = 0 (and sd = 1), and the interpretation 
#' of the model coefficient will make more sense.
#' Try to run the following model and inspect the summary:
fit = lm(data = mtcars, mpg ~ scale(hp))

#' Does the intercept correspond to the mean(mtcars$hp)?

#' Now let's have a look at the second coefficient. In addition to summary, you
#' can use:
coef(fit)

#' The coefficient for hp corresponds to the slope of the regression line and 
#' can be seen as an effect size, since it indicates the "strength" of the
#' relationship. More specifically it can be interpreted as: the change in the
#' dependent variable for a unit-increase of the independent variable. 
#' In other words, it tells us how heavily the fuel economy is affected by hp.
#' If we want to visualise this effect we can easily plot a regression line in
#' our previous ggplot:
ggplot(data = mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

### Evaluation #################################################################
#' Now that we described the relationship, and we have an overall idea of what
#' the line looks like, we may ask ourselves if this relationship is statistically
#' significant. To do that we need to check the additional information provided
#' for the coefficients. (run summary() again)
#' - Standard error of the model coefficients
#' - t-value: t-statistic to check whether the coefficient is different from 0 
#' - p-value: corresponding p-value for the t-test on the coefficient.
#' 
#' The easiest and most straightforward way of evaluating significance of a 
#' predictor is checking the p-value. If below your alpha level (.05, usually),
#' you can infer that the null hypothesis (the coefficient is 0) can be rejected.
#' 
#' If we reject the null, we can infer that the effect size of the relationship
#' between the variables is NOT 0 and therefore that hp has an effect on mpg.
#' 
#' Another aspect to consider is the R squared. This index of model fit tells us
#' the amount of variance explained by the model. It corresponds to the squared 
#' correlation coefficient, and can be take any number between 0 to 1. Higher 
#' values are preferred. This index can be used to compare different models.
#' 
#' Finally we could have a look at the F-test which compared our model with one
#' without predictors. If significant, we can infer our model explained more 
#' variance than the baseline model and therefore our predictor has an effect 
#' on our dependent variable. 


#' ### Little exercice ########################
#' - Fit another model (fit2) that has no predictors (google how to, if needed)
#' - Run an F-test using the anova("fit1", "fit2") function 
#' - Compare the F-statistics to our original summary

### Diagnostics ########################
#' As you should know by now, regression models have a few assumptions that can 
#' be easily investigated in R. 
#' The most straightforward way is to make some plots:
#par(mfrow = c(2, 2)) # this will allow 4 plots at the same time, run if you want to
plot(fit)
#' Here we see:
#' - Residuals vs fitted: linear relationship assumption, good if a straight line
#' - Q-Q: whether residuals are normally distributed
#' - Scale-location: homoscedasticity, homogeneity of variance of the residuals
#' - Residuals vs leverage: identification of influential cases
#' 
#' After checking the assumptions, do you think the model is appropriate?

#' A more relaxed alternative of model diagnostic is checking only the normality
#' of the residuals:
hist(residuals(fit))

### Prediction #################################################################
#' Another reason for fitting a linear regression model is to make predictions.
#' In fact we can use the coefficients we just extracted to write an equation 
#' and apply it to scenarios we might be interested to.
#' Let's refit the model using the non-normalised variable (to keep the units
#' physically meaningful):
fit = lm(data = mtcars, mpg ~ hp)

#' Let's create a little function to make a simple prediction:
pred.ict = function(x, model) {
  # Take the coefficients
  inter.cept = as.numeric(coef(model)[1])
  slop.e = as.numeric(coef(model)[2])
  # Build the equation
  predict.equation = inter.cept + (slop.e*x)
  
  return(predict.equation)
  
}

#' Thankfully there is a built-in tool in R that does the job for us. We just 
#' need to specify the model and the value for our independent variable:
predict(fit, data.frame(hp = 150))

#' We can also check whether our function predicts the same value as the R 
#' function. Try to evaluate pred.ict and predict with the same X value and 
#' compare the predictions.

### Multiple Regression ########################################################
#' Up until now we only looked at simple models with only one predictor. What if
#' we wanted to consider an additional (or more) predictors?
#' Our previous model tested the effect of power on fuel economy. We might believe
#' that weight of the car could have an effect too. 
#' Can we build a model with both predictors?
#' Introducing multiple regression!
#' 
#' In R multiple regression is just an extension of the models we saw so far.
#' Defining the model takes the same exact form as before, but we add (+) a
#' predictor:
mfit = lm(data = mtcars, mpg ~ hp + wt)

#' Here we added to our formula the predictor "wt" using the "+" operator. There
#' are other potential operators that can be used for other purposes (e.g.
#' interactions), but that will be for another day!

#' If we inspect the model, we will see a familiar output:
summary(mfit)

#' The interpretation is slightly different than before: 
#' - The intercept is still the mean mpg when the hp and wt are equal to 0
#' - Each estimate for the slopes (say hp) is the measures of change of mpg for 
#'   a unit increase of hp holding wt constant (vice-versa for wt)
#'   
#' As before, we have the issue of interpreting the intercept as having hp and 
#' wt equal to 0 is not meaningful. To solve it we can scale the explanatory
#' variables. 

#' ### Little exercice ########################
#' Refit the model with normalised predictors and summarise it. Then compare the
#' intercept to the mean value of mpg.

#' Another perk of normalising the predictors is the possibility of comparing 
#' effect sizes. If we didn't, hp and wt would have different scales and the 
#' relative effects could not be compared!
#' After the normalisation it is possible to check which of the predictors has
#' a stronger relative effect on our fuel consumption variable. 

#' Can you tell which of the predictors has a stronger effect?

#' ### Little exercice ########################
#' Now that we fitted a fancier model, we expect it to be better than our simpler
#' one used before. Can we compare the two?
#' Remember the indexes of model fit we mentioned earlier!
#' - Refit the two models
#' - Compare them using the R2 index
#' - Pick the one you think is better. 

#' It is important to add however that R2 is not the most ideal way of comparing 
#' models. In fact it always increases for any additional predictor added to the 
#' model. We can hence cause overfitting. 
#' A potential alternative you might consider in the future is the AIC index, 
#' which includes a penalty for the number of predictors. Lower values are better.

#' When it comes to diagnostics, it works the same way as simple univariate 
#' regression.
#' Here I will just look at the distribution of the residuals:
hist(residuals(mfit))
#' As before, the residuals are reasonably well distributed but the model might
#' require some attention. Let's keep it as it is for today. 
#' (we can discuss what to do in these cases later)

#' What if we wanted to do some predictions? As before we just need to specify
#' the values for the predictor variables:
predict(mfit, data.frame(hp = 60, wt = 3))

### Final exercise #############################################################
#' You should have everything you need to build a model from scratch. 
#' This time however, we are interested in modelling the 1/4 mile time with hp 
#' as a predictor.
#' - Build your first linear model on qsec and hp, summarise it and plot it
#' - We have other variables that might be interesting for qsec. Pick two 
#'   additional variables and add them to the model (call it in a different way)
#' - Check the model and make sure you did the preliminary operations for correct
#'   interpretation.
#' - Compare your two models.
#' - Bonus: compare the AIC values (function is AIC()).

