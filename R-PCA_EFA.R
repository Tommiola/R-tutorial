################################################################################
### Tommaso Viola 10/2022 
### Transport Research Methods
### Workshop on dimensionality reduction techniques.


#' This script will take you through some examples and exercises on two popular
#' dimensionality reduction techniques:
#' - Principal Component Analysis (PCA)
#' - Exploratory Factor Analysis  (EFA)
#' 
#' Since the theory and the underlying mathematics is quite complex, and escapes
#' the scope of this tutorial, I highly suggest referring to a good multivariate
#' statistical analysis manual.
#' Here we will see some simple and hopefully intuitive applications.
#' 
#' First we need to understand why these techniques are used.
#' Reducing the dimensions is one purpose but there can be others which we will 
#' not get into.
#' Often we find ourselves in situations where the dataset we work on has many, 
#' if not too many, variables to work with, especially in the exploratory phase 
#' of out research. Variables that are supposed to be in the same model are likely
#' to be interrelated. The issue is that all traditional linear models share the
#' requirement of not-perfect multicollinearity: this means that variables should
#' not be too linearly correlated. In these cases we might have to drop some 
#' variables following some criteria, and  run our simplified model. The issue
#' here is that the inclusion of these variables might be motivated by theory or
#' experimental reasons. So what do we do? One possibility is using Principal
#' Component Analysis (PCA). This technique, in the simplest way possible allows
#' us to reduce the original dataset to a series of Principal Components which 
#' represent a linear combination of our original correlated variables. In this way we
#' can then use the principal component instead of the individual variables, also
#' reducing the risks of overfitting. 
#' 
#' Another instance might be when you have a dataset obtained from a questionnaire.
#' This questionnaire might have 30 different items, which had been designed to 
#' measure 4 aspects of human traits. We might then expect two things: 
#' First, since these 30 items were made to measure 4 traits, we expect them to
#' be heavily correlated with each other; second, we might expect that these 30
#' items are driven by those 4 traits which are not directly observable. These 
#' underlying variables supposedly driving the dataset variance are called latent
#' variables (or construct). If we were interested to not only reduce the dimensions
#' of our dataset, but also to get an estimate of these latent constructs, we 
#' might consider using exploratory factor analysis (EFA). 
#' 
#' Although sometimes used interchangeably, the two methods are fundamentally 
#' different. Without going into the mathematics of it, the PCA obtains principal
#' components which are weighted linear combinations of the original variables. 
#' EFA, on the other hand, attempts to extract the latent factors which are thought
#' to drive the variance in our variables - effectively solving a formal model.
#' 
#' In other (simplified) words:
#' -PCA: components are linear combinations of the variables
#' -EFA: variables are linear combinations of the factors.
#' 
#' Sometimes this techniques can obtain similar end results, especially for very
#' large sample sizes. However, the choice should be driven by your purposes.
#' 
#' Before moving into some examples, I highly recommend reviewing the literature
#' following appropriate resources!

#' Finally, to do some of the exercises we need a package called psych. Install 
#' it on your Rstudio using the following command and then load it:
install.packages("psych")
library(psych)

### Principal Component Analysis ###############################################
#' We will start by doing a simple PCA on the "iris" built-in R dataset.
#' This dataset includes 4 variables on the length and width of petal and sepal
#' for 3 species of iris. 
#' A simple application of PCA on the 4 continuous variables might allow us to 
#' combine the variables in 1 or 2 components and then compare these components
#' across the species.

#' Before extracting the components, we need to check a couple of things on the
#' dataset.

#' PCA operates on the correlation matrix of the variables (covariance as well),
#' so firstly let's get the dataset with only the continuous variables and obtain
#' the correlation matrix.
data = iris[,-5]
data.cor = cor(data)

#' We can visualise it too:
corPlot(data[,-5])

#' If you inspect the correlation matrix, you will see that we have high values
#' across the board which meant we could've run into multicollinearity. This is
#' however a good case for PCA.

#' We can also check whether the correlations are appropriate using the Bartlett
#' test which verifies whether the correlation matrix is not an identity matrix:
cortest.bartlett(data.cor, n = nrow(data))

#' The test is significant > we have good enough correlations for PCA

#' Another test we can run is the Kaiser-Meyer-Olkin (KMO) test for sampling 
#' adequacy. This verifies there is enough variance shared across the variables
#' and therefore that is appropriate for PCA (actually better for EFA, but let's
#' give it a try anyway)
KMO(data.cor)

#' 0.54 is, in Kaisers' terms, "miserable" but good enough (>.50) for PCA.

#' In R, when you run the PCA with standard parameters you will get as many p.
#' components as the number of variables. However, we want to reduce the dimension!
#' How do we find the best number of components that simplifies the dataset, 
#' without missing any relevant information?
#' One way of doing this is parallel analysis:
fa.parallel(data.cor, n.obs = nrow(data), fa = "pc")

#' Running this we see the so called scree plot. The blue line represents the 
#' eigenvalues obtained from the decomposition of our correlation matrix. 
#' The red line, on the other hand, represents the decomposition of many random
#' datasets (uncorrelated) that R did for us. Since these datasets are random,
#' we are not expecting any effective correlations so, we need to look at where
#' the two lines intersect to understand where to stop in our PCA. The idea is 
#' that eigenvalues (variance explained) above the ones obtained from random-junk 
#' data are meaningful for us. 
#' Alternatively we can just look at the scree plot of our dataset and pick as
#' many components (points in the plot) that are above the inflection point, which
#' is the "elbow" of the curve - or the plateau.
#' Taken these two methods together, two components seem to be adequate in our 
#' case.

#' We can then run our PCA:
iris.pca = principal(data, 
                     nfactors = 2, 
                     rotate = "none", 
                     scores = TRUE)

#' and inspect it
iris.pca

#' We can spend a long time discussing the output of a PCA, so let's stick to the
#' most relevant stuff.

#' First we see the standardised loadings. These are the weights of each variable
#' in their linear combinations to compute the principal components. Since the 
#' components are not correlated, they are both regression and correlation 
#' coefficients.
#' One way of interpreting these is the relevance of each variable for each component. 
#' We would expect variables found (more relevant for) in each competent to be 
#' correlated. 
#' Looking at these loadings, we can see that the first one is associated with
#' sepal length, petal length and petal width. All of these loadings are positive,
#' which means that changes in each of these variables will result in an increase
#' in the respective component. On the other hand, Sepal Length seems to be 
#' related to the second component.
#' 
#' Another important part of the output is what can be seen below. Here we can 
#' find how the variance of our correlation matrix is explained by the principal
#' components. We can see that the first component explains 76% of the variance
#' whilst the second one explains the remaining 24%. This is because in PCA
#' the first component will always explain most of the variance.

#' Ok, but what do we do with this?
#' We could visualise our PCA, to start:
biplot(iris.pca)

#' This plots shows many things:
#' - At a first glance this is just a scatterplot of the two principal components
#'   that we extracted from our data. 
#' - we also see that our original variables are now represented as vectors (red
#'   lines). The length of the vectors represent how much variance is explained
#'   in the variable by the two components; the direction (how parallel it is) 
#'   relative to the PC axes tells us how much the variable contributes to the
#'   component; angles between vectors represent correlations between variables
#'   (opposite angles are negative correlations) 
#'   
#'   We also notice on the plot that there is some clustering! Could it be that
#'   there is some grouping in our dataset? Maybe, could it relate to the different
#'   iris species?
#'   Let's have a look.

#' First we combine the original data with the scores
comb.ined = cbind(iris, iris.pca$scores)

#' Now we make a ggplot similar to the biplot we used just now.
require(ggplot2)
ggplot(data = comb.ined, aes(x = PC1, y = PC2, color = Species)) +
  geom_point() +
  stat_ellipse() +
  theme_bw()

#' Yes! It looks like the two components we extracted are enough to show some
#' clustering of our data based on the iris species. 
#' From the 4 starting highly correlated variables we ended up with two non
#' correlated components that retain enough variance (information) to show 
#' differences between the species. Win win.
#' Remember also the problem of multicollinearity in regression: uncorrelated
#' components can easily be used as alternative to the starting variables in our
#' linear models.

### Exercise ###################################################################
#' Let's run PCA on another dataset, the ever so familiar mtcars.
#' As we saw in the previous workshops, this dataset has many variables on 
#' different models of cars. 
#' Would it be possible to visualise different clusters of cars depending on 
#' principal components computed with the variables?

#' First let's compute a simple grouping variable based on the power of these
#' cars (high power car if above the median:
data = mtcars
data$group = ifelse(data$hp >= median(data$hp), "High-power", 
                    "Low-power")

#' Now, pick the continuous variables from the dataset you believe might 
#' contribute to define the characteristics of a high/lower powered car and run
#' a PCA following the passages we went through together so far. Although in this
#' case more than 2 principal components might be more appropriate, let's stick 
#' to 2, so that you can plot your scores and hopefully see some clustering 
#' action!

### Exploratory Factor Analysis ################################################
#' As mentioned before, EFA might look very similar to PCA, however it is used
#' for different purposes. Let's take for example the dataset we will use for 
#' this part. 
#' In this dataset, we have 8 variables collected from 152 participants:
#' - 4 variables are thought to measure verbal ability
#' - 4 variables are thought to measure non-verbal ability.
#' Each variable was computed from a different test, however since these tests
#' are believed to refer to two psychological constructs, we would expect them
#' to be heavily correlated. It would then make sense to reduce the dimensions.
#' 
#' Would PCA work in this case? Certainly, we could linearly combine the variables
#' and use principal components. However, wouldn't it make more sense to think 
#' that the variables are in fact representative of two underlying construct?
#' In this particular case, we also have the theory and design of the study to 
#' help us. The tests, if you remember, were selected to measure verbal and non-
#' verbal abilities. Since we know this, and we also have an indication of the
#' number of factors (construct) to retain, EFA is definitely the way to go!
#' 
#' This dataset can be found in your material. It was taken by the handy handbook
#' by Marley W. Watkins on EFA in R (check it out if you can!)

#' Let's read the data (remember to change the working directory) and inspect it
data = read.csv("iq.csv")
summary(data)

#' Ok everything seems to be perfect for our analysis. Let's run some tests as 
#' shown in PCA
data.cor = cor(data)
corPlot(data.cor)
cortest.bartlett(data.cor, n = nrow(data))
KMO(data.cor)

#' Wow our tests show the data is perfect for EFA. 
#' Although we already expect two factors underlying our data, shall we run a 
#' parallel analysis to see if it supports our prediction?
fa.parallel(data)

#' We see two things here:
#' - Two factors seems to be the way to go
#' - The eigenvalues for the PCA are consistently higher than for the EFA. 
#' Why is this the case?
#' It is important to consider that one of the most relevant differences between
#' PCA and EFA is that PCA works on the total amount of variance found in the
#' dataset. EFA, on the other hand, makes a distinction between common and unique
#' variance. The former constitutes the amount of variance shared across variables
#' (and likely explained by a factor), whilst the latter is the amount of variance
#' that is not common and can be due to unknown reasons or measurement error. 
#' EFA only operates on the common partition of variance (always intrinsically 
#' lower than the total) and therefore has less explanatory capability than PCA.

#' Having said this we can extract the factors:
fit = fa(data.cor, nfactors = 2, rotate = "none", fm = "minres")

#' Extracting factors, as mentioned before, can be seen as solving a model. We can
#' then use multiple algorithms to solve it but we won't go into that. "minres" 
#' is a valuable option in our case. 
#' For now ignore the rotation option.

#' Let's inspect our model:
fit

#' We can see a lot of stuff compared to PCA. We could spend a long time to 
#' discuss everything but we will just look at the basics.
#' First we see the familiar factor loadings. They represent the regression 
#' coefficients of the factors explaining the variables (or correlations). We 
#' can explain them as the degree to which the factor explains the variable.
#' In EFA I would also look at "h2" and "u2": the former is the communality, that
#' is the amount of variance explained by the factor; the latter is uniqueness,
#' that is the residual variance. Higher "h2" are desirable in our models!
#' Down below we still see the variance-explained data, and finally some indexes
#' of model fit. These indexes can be used to compare different factor models 
#' when, for instance, the solution is not straightforward. Many of these indexes
#' are constructed on the residuals (the difference between the original correlation
#' matrix and the one constructed by the model). Model comparisons procedures are
#' more common in a similar technique called Confirmatory Factor Analysis which 
#' differs from EFA as it is entirely driven by the theory - the factor is pre-
#' defined. We won't go into that!

#' Let's try to look at the loadings and interpret them:
print(fit$loadings)

#' Even though we expected a two-factor solution, we see that most of the variables
#' are mostly explained by the fist factor. Does that mean we should re-fit the
#' model with only one factor? 
#' Before going down that road, we need to introduce an additional operation that
#' can be done in factor analysis: factor rotations.
#' 
#' Factor analysis can have a geometrical interpretation: if you think about the
#' matrix of loadings, each row can be seen as coordinates along n (n-factors)
#' axes. Factor rotation corresponds to a shifting of these axes to maximise
#' the separation of the factor loadings. If we want to keep the uncorrelated
#' nature of the factors, we can use orthogonal rotations. If we want to allow
#' the factors to be correlated we can use oblique rotations. Changing the axes
#' of the factors will not change the inter-variables relationships.

#' Let's try to use a varimax orthogonal rotation to improve our solution.
fit2 = fa(data.cor, nfactors = 2, rotate = "varimax", fm = "minres")

#' And inspect the solution:
print(fit2$loadings, cutoff = 0.5)

#' Yes! It looks like we were able to find a solution that perfectly follows the 
#' original plan when the study was run. What a relief.

#' One important bit: most times we will have solutions where each variable is 
#' at least partially correlated to every factor. How do we decide which one is 
#' the more relevant factor for that variable? The literature is full of rules 
#' of thumbs so be careful! Usually it depends on the sample size - larger size
#' corresponds to a lower threshold (highly recommend doing some research on this).
#' In general there is some room for interpretation so if you see only small 
#' differences between loadings, it might mean that multiple factors are relevant
#' for that variable. If one loading is significantly larger than another, you 
#' can draw a different conclusion.

#' So, going back to the dimensionality reduction issue. How do we reduce our 
#' variables to the combined factor scores?
#' Compared to PCA where the components are just linear combinations of the original
#' variables, in EFA we have to make an estimation: factor scores are in fact 
#' an estimation of what the underlying latent variables would be given the model
#' we fitted to our data. Alternatively we can think of them as the measurement
#' we would get if it was possible to actually measure the factors directly.
#' We won't go into the details here but remember that there are methods of
#' estimations specific to the extraction method and rotations we used. In our
#' case, we want to keep the factors non-correlated so we could use the Anderson
#' method:
scores = factor.scores(data, fit2, method = "Anderson")
head(scores$scores) #to check the scores only

#' We can now consider these scores as an estimation of the verbal and non-verbal
#' capabilities of our participants, and use them in place of our original variables.

### Exercise ###################################################################
#' Now that you saw how to do both Principal Component Analysis and Exploratory
#' Factor Analysis you should be able to do it all by yourself!
#' Let's open a new dataset, which was taken from the great book on statistics 
#' with R by Andy Field (google it, a very nice read). This dataset is from a 
#' questionnaire designed to measure the anxiety for learning R.
data = read.csv("raq.csv")

#' Now, using data from a questionnaire it is natural to think about factor 
#' analysis so start from there. Follow the steps we did together to find an 
#' appropriate solution and see what you find!
#' 
#' Once you are done, why don't you compare it with a PCA solution and determine 
#' which method is more appropriate in this case?





