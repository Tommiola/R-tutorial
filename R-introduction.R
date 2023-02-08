################################################################################
### Tommaso Viola - Cristian Domarchi 10/2022 
### Transport Research Methods
### Basics of R programming


#' Welcome to Rstudio, the most commonly used interface for R.
#' 
#' This is where you get your data, manipulate it, analyse it, 
#' plot is and export it. 
#' 
#' This script will be used during the practical, however we 
#' recommend you to keep it for future reference.
#' 
#' There will be several parts:
#' 
#' -Basics of R
#' -Data interfacing and manipulation
#' -Basics of plotting

#' If you want to install Rstudio on your personal machine, remember
#' to install R first, then Rstudio (Google recommended!)

#' Always refer to official documentation!

################################################################################
### Basics of R ################################################################

#' Firstly, what you are looking at is the script page. This is 
#' where you will list all of the commands you want R to perform.
#' 
#' Everything you write here will be run by Rstudio when you click
#' "Source" on the top right corner of this panel.
#' 
#' You can also run single lines/commands by highlighting them and
#' clicking "Run" (or with the shortcut control + enter)
#' 
#' The output of your commands will be displayed on the console panel.
#' You can also type commands in the console directly, and press "Enter"
#' for a direct output. 
#' 
#' It is always good practice to explain what you are doing with a 
#' command by leaving a comment nearby.  
#' You do this by preceding your text by "#", exactly like what we are 
#' doing here (ignore "'" now)
#' 
#' The first thing to consider about R is that it will do everything
#' you asked it to do by text commands, but it is very picky! 
#' Often you will get errors, but the community behind this project
#' is very wide and usually you will get a solution by googling it.
#' Also, since it is case sensitive, mind how you type your command!
#' 
#' Let's have a look at what R can do!

#' At the simplest case, R is a fancy calculator and you can do any
#' operation you can think of simply typing it and running it.
#' For instance, try to run the following line and see what it does
#' in the console.
#' It should output what you expect, hopefully!
#' 
#' Remember, highlight the command (separately) and press "Run" or 
#' "Control + Enter".
5 + 8
#' or 
3 * 2

#' Brackets also work
(2 + 2) * 5

#' Exponentiation
4^2

#' You can also do logical operations, which will output a TRUE or FALSE 
#' For instance, try:
4<9
#' or
4==9

#' Did you notice we used "==" to express "equal to"?
#' This is very important since the operator "=" is used to assign variables.
#' Run the following:
x = 10

#' Note that "<-" is the more appropriate way of assigning a variable value,
#' however for our purposes "=" act the same way.

#' By running this command we are telling R to assign the value 10 to the 
#' variable x. You should've also noticed that running this did not output
#' anything on the console. This is because assigning a variable does not
#' produce any output. If you want to check what a variable is, you can
#' simply run the name of the variable.
#' Try to type x in the console and you should see 10 appearing.
#' 
#' A list of your variables can be seen in your Environment panel.

#' Any script, or list of operations, is built using variables. This is very
#' important! 
#' When assigning a variable, you can either manually type a value:
x = 3

#' Or it can be an operation between values:
y = 4 * 4

#' Or it can also be an operation between variables
z = x + y

#' Pretty much anything can become a variable: numbers, functions, plots,
#' datasets, scripts, characters, etc.
#' We will see more soon.

#' The reason why you use R though is most likely to work with data!
#' We all have a fancy calculator on the phone for these simple operations.
#' Let's create a vector of numbers:
x = c(1,5,3,2,6)

#' x is now the vector of the numbers included in the brackets.
#' This is a first example of function.
#' Functions are essentially small scripts that you can use for your
#' convenience in your script.
#' They all take the form of function(), that is the name of the function
#' followed by brackets (both, open and close, remember!)
#' In the brackets you add arguments as needed.
#' In this case, you add numbers that you want in the vector, using the function
#' c() which stands for "combine".

#' Functions are also what you use to obtain all the descriptive statistics
#' you might need.
mean(x)     # mean
sd(x)       # standard deviation
median(x)   # median
max(x)      # maximum
range(x)    # max and min
length(x)   # the number of entries in your vector
#' and so on. 
#' If you need a specific function, google it and you are going to most 
#' likely find it!

#' If you are not sure about what a function does, there is a function
#' for that as well.
help(mean)

#' Remember that you can always combine multiple functions and operations.
(mean(x) + sd(x)) / length(x)

#' Another important aspect to consider in R is the argument of the function,
#' which are called classes and can take multiple forms.
#' In this case we used x, which is a vector of numbers.
#' If we want to check what type of object x is we run:
class(x)

#' As expected it outputs numberic.
#' What if we have an object such as:
y = c("1", "5", "3", "2", "6")
#' and we check the class:
class(y)

#' We obtain a different output, since we used "" to list the entries of the 
#' vector. 
#' "" are used to specify strings which are usually text or symbols, but
#' as you can see can also be numbers.

#' You can easily convert object to different classes with R commands like:
as.character(x)
as.numeric(y)

#' On your own, try to check whether you can compute a logical operation
#' to test whether x and y are equal.
#' If they are not, convert them appropriately and test again.

#' An incredibly important class in R is the factor. You use this to do any
#' grouped operation.
as.factor(y)

#' Another really essential class to know about is the dataframe, which is
#' what you will be working on in your data analyses.
#' A dataframe is usually what you import from excel, but you can compute it
#' manually in R too with a function as follows:
d = data.frame(x = c(1,2,3),
               y = c("a", "b", "c"))

#' If you inspect the object d in the console you will see that we created
#' two columns (x,y) with a few values.
#' Remember, a dataframe must have columns with the same length in R, otherwise
#' it will return an error.

#' Since there is no graphical user interface in R, how can you select values
#' (cells in excel)?

#' Accessing variables (columns) and indexing are other very important parts
#' of R programming and can take multiple forms.

#' You can access a specific column by name:
d$x
#' In this case you use the operator "$" to access variables within an object.
#' You can also check the variables' names in a dataframe with names(data.frame)

#' Or you can index manually using square brackets:
d[1,1]
#' When indexing a dataframe, within the brackets you add two values, 
#' the first one indicates the row number while the second the column number.
#' It can be a single value each, or multiple.
d[c(1,2),1]
#' Another way of indicating a series of values is the colon ":"
d[1:2, 1]
#' The colon can be used to create sequences - try typing 1:10 in the console 
#' to see what happens.

#' You can also index by variable name.
d[1, "y"]

#' When you have a dataframe, it can be useful to know more about the variables
#' in it. You can check its structure by:
str(d)

#' If you need to change class within a dataframe you can use the functions
#' mentioned before.
d$x = as.character(d$x)

#' You can easily do any operation you need on variables within the dataframe
#' selecting the right variable
mean(d$x)
#' Did you run into an issue?
#' Can you solve it?

### Exercise #########################
#' Referring to what we have seen so far:
#' - Search the appropriate function to create random numbers
# Code here

#' - Create three vectors of 10 random numbers (x,y,z) within a range of 0 and 100
# Code here

#' - Change class of two vectors from numeric to integers
# Code here

#' - Combine the vectors to a dataframe
# Code here

#' - Change the names of the columns to (first, second, third)
# Code here

#' - Compute the mean of the variable second.

### Scripting #########################
#' What we have done so far has been mostly running commands individually,
#' however most of the times your analyses will be a list of commands that will
#' run sequentially. As mentioned before, this is what a script is.
#' 
#' There are a few differences between running a command in the console, and
#' running a script.
#' For instance, inspecting a variable (e.g. by typing x in the console) in
#' a script might not output anything.
#' In these cases it's preferred to explicitly ask R to do it for you:
print(x)

#' Let's talk about the actual scripting. There are a few things you usually
#' have to do before playing with your data. You can follow along the next few
#' steps:

#' First you open a new script by: 
#' file > new file > R script

#' Then you save it (required to run source): 
#' file > save as

#' Then you have to set the working directory. This is where everything will 
#' take place and where R will attempt to find files to read, save and output
#' stuff. It is useful to have everything in one directory. You can also have
#' subfolders if needed.
#' You set a working directory by: 
#' session > set working directory > choose directory
#' or with the function setwd("here you add your path manually")

#' As you probably remember, earlier we mentioned that functions are little tiny
#' scripts: just a series of operations that allow the user to obtain a specific
#' output, after providing an input. 
#' Although not necessary for the present workshop, you can see below a very 
#' simple example of function that takes a vector of numbers and outputs mean
#' and standard deviation.
#' Highlight the whole body, run it and then try to run the function in the 
#' console (providing the correct argument) to see what happens.
fun.fun = function(num.vec) {
  print(paste("The mean is", as.character(mean(num.vec))))
  print(paste("The standard deviation is", as.character(sd(num.vec))))
}

#' If you ever find yourself repeating an operation multiple times, create a 
#' function! It saves time and gives you consistency. 

#' You are now set for some fancy coding!
#' You will now be able to write your list of commands, save (Keep saving!),
#' and source your code. 

#' Remember that it is good practice to write scripts that can be run without
#' errors. Therefore it is recommended to test your code beforehand on the console
#' and leave only what is required in the script.
#' 
#' Finally: remember to comment your code. 
#' You WILL forget what you tried to do a few months back so help yourself!

### Data interfacing and manipulation ##########################################
#' 
#'  We will now begin exploring some features that will help us to analyse data.
#'  R has several "built-in" data sets that can be useful for this.
#'  Let's open one of them:

data(mtcars)

#'  The "mtcars" data set contains measurements in 11 different attributes 
#'  for 32 different cars. The data was extracted from the 1974 Motor Trend
#'  US magazine, and comprises fuel consumption and 10 aspects of automobile
#'  design and performance for 32 automobiles (1973-74 models)

#'  You can have a look at the first rows of the data set using the head function

head(mtcars)

#'  This can be very useful when handling big data sets!
#'  You can use the summary function to quickly summarise each variable 
#'  in the dataset

summary(mtcars)

#'  The summary includes: minimum, mean, maximum, and 3 quartiles 
#'  (25%, median, and 75%)
#' 
#'  More details of each variable can be found with this command:

str(mtcars)

#'  Sometimes we need to retrieve  the variable names only, especially in case 
#'  we need to use them in a function, model, or other procedure. 
#'  This is done with:

names(mtcars)

#'  We can also quickly retrieve the dimensions of the data set:

dim(mtcars)

#'  The output of this function is the number of rows (32) and the number of 
#'  columns (11)
#'  
#'  As mentioned before, if you want to refer to a specific value in the 
#'  data set, you can use the $ symbol
#'  Say you need to calculate the mean of fuel consumption (mpg) for 
#'  the data set. The syntax for this is:
mean(mtcars$mpg)

#'  A similar notation is used to create a new variable in the data set. 
#'  For example, let's create a variable called "quot" and 
#'  defined as the quotient between weight (wt) and gross horsepower (hp)
#'  We do this as follows:
mtcars$quot <- mtcars$wt / mtcars$hp

#'  "<-" is the "assignment" operator, which assigns the value wt/hp to the
#'  newly created quot variable. [Don't do as Tommaso who uses the "=" ah!]

#'  Variables can also be created using conditions. For example, let's create 
#'  the variable "mpg_group_1" which is equal to 1 if vehicle consumption is 
#'  less than 20 mpg, and 2 otherwise
#'  
#'  Let's try it with an "if" function:
mtcars$mpg_group <- ifelse(mtcars$mpg < 15, 1, 2)

#'  Let's explore this newly created variable
summary(mtcars$mpg_group)

#'  R understands that this variable is continuous!
#'  If we want to treat it as a factor, we can use:
summary(as.factor(mtcars$mpg_group))

#'  With this condition, R builds a frequency table, counting how many 1's and 
#'  2's are there in the data set. This might be the required effect

#'  Variables can be created with other logical conditions such as:
#'  equality: ==
#'  nonequality: !=
#'  and other operators like AND (&&) and OR (||)
#'  
#'  Since logical expressions can also be added or multiplied, this can be 
#'  used to make the creation of variables easier
#'  
#'  Can you guess what will this command do?

mtcars$super_cars <- (mtcars$mpg > 30) + (mtcars$cyl > 6) * (mtcars$gear > 1)

#'  The variable is a sum of two terms:
#'  The first term equals ONE when mpg > 30
#'  The second term is a product of two terms that can either be ONE (TRUE) 
#'  or ZERO (FALSE).
#'  Then, the second term will only equal ONE when BOTH terms are ONE
#'  That is, it will equal ONE when BOTH conditions are TRUE, i.e.,
#'  when cyl > 6 AND gear > 1
#'  
#'  This can be very useful when recoding variables (for example, building a 
#'  factor from a continuous scale)
#'  
#'  
#'  
#'  Data exploration can be made easier with packages from the Tidyverse suite
#'  We will use the "dplyr" package to explore and analyse the data set
#'  First, let's clean the environment and reload the original mtcars data set
rm(list = ls())
data(mtcars)

#'  Then we need to install the dplyr package. This is an external package so
#'  you will need to download it. You can download each package once per
#'  machine. This can be done as follows:
install.packages("dplyr")

#' When the package has been installed, we can then load it as follows:
library(dplyr)

#' Every R package can be installed and used with the same procedure.
#' There are over 20,000 R packages, so it is very likely that someone has
#' already done something like what you want to do!

#' dplyr is a "grammar of data manipulation" and offers a simplified
#' syntax to solve the most common data manipulation challenges
#' It uses the "pipe" operator %>% which forwards a value, or the result
#' of an expression, into the next function call or expression.
#' For example, you can use the "select" function together with the %>%
#' operator to select only some columns of your dataframe
mtcars %>% select(mpg, disp, gear)

#' Here, mtcars is passed as an argument to the "select" command.
#' Note that it is no longer required to specify mtcars$mtg, etc.
#' Similarly, we can select only some rows of the dataframe, according
#' to some criteria. For example, this command selects only the records
#' with mpg > 20
mtcars %>% filter(mpg > 20)

#' Creating a new variable is also easy, using the "mutate" function.
#' For example, let's transform the fuel consumption in mpg (miles per gallon)
#' into km/lt (kilometres per litre). We do this by:
mtcars %>% mutate(kmlt = mpg * 0.354006)

#' The "am" column contains information about transmission 
#' (0 = Automatic, 1 = Manual). We can write this information into
#' the table by combining mutate and recode:
mtcars %>% mutate(am=recode(am, 
                            '0' = "Automatic", 
                            '1' = "Manual"))

#' You can save the results of your analysis at any point:
mtcars_2 <- mtcars %>% mutate(am=recode(am, 
                                        '0' = "Automatic", 
                                        '1' = "Manual"))

#' This saves the previously build dataframe into a new one, which we can
#' then use for further analysis

#' Several "pipes" can be used together. This is useful, for example, when
#' "grouping" data to generate summaries. For instance, let's say you want
#' to quickly create a table that calculates the average fuel consumption
#' in mpg, distinguishing between automatic and manual transmission. You
#' would also like the standard deviation and sample size (in case we want to
#' do inference). 
mtcars_2 %>% group_by(am) %>% summarise(mean_mpg = mean(mpg),
                                        sd_mpg = sd(mpg),
                                        sample_size = n())

#' This is a very important and useful command. The "group_by" creates
#' segments from the dataframe, over which the statistics in "summarise"
#' will be created. Here we were interested in created two groups, based on the
#' am variable, and calculate the mean, standard deviation and sample size on
#' each group

#' You can save these results in another dataframe, if required:
summary_table <- mtcars_2 %>% group_by(am) %>% summarise(mean_mpg = mean(mpg),
                                                         sd_mpg = sd(mpg),
                                                         sample_size = n())

#' And make further calculations on this summary...
summary_table %>% mutate(coef_var_mp = sd_mpg / mean_mpg)

#' Clearly, we can group by more than one just variable. If we use VS 
#' variable (engine cylinder configuration: 0 = V-shape, 1 = straight line),
#' we obtain the following:
mtcars_2 %>% group_by(am, vs) %>% summarise(mean_mpg = mean(mpg),
                                            sd_mpg = sd(mpg),
                                            sample_size = n())

#' So far we have used a clean dataset from R. Most of the time, datasets will
#' not be as clean and will require some processing before we are able to use
#' it in a model. We will use the tidyr package for this. Let's install it and
#' load it

install.packages("tidyr")
library(tidyr)

#' Let's open another built-in dataset, this time a more complex one:

data(relig_income)

summary(relig_income)

#' These data come from a survey, where people were asked what their religion and
#' income was. The table contains three variables: religion (a factor),
#' income, spread across the columns, and count, stored in the cell values.
#' We would like "income" to be stored in just one column (remember a well
#' structured dataset has every variable stored in exactly one column). This
#' will mean we will have more than just row for each religion - our
#' dataset will become "longer". We can do this with the following function:

relig_long <- relig_income %>% 
  pivot_longer(!religion, names_to = "income", values_to = "count")

#' This does the following:
#' First, the dataset is specified before the pipe %>% operator
#' -The first argument of the function is the columns that will need to be
#' reshaped (e.d., transformed). In this case, it is EVERY column EXCEPT
#' religion (!religion)
#' -The second argument of the function (names_to) gives the name of the
#' new variable which will be created from the reshaped variables (income)
#' -The third argument of the function (values_to) gives the name of the
#' new variable which will be created from the cell values (count)
#' We stored this in the "relig_long" dataset.
#' Now income is stored in just one variable.

#' This is a very important function with complex datasets.
#' 
#' Some times the opposite is required. Let's open another dataset.

mode_share <- read.csv("H:/mode_share.csv")

### CHANGE THE DIRECTORY AFTERWARDS

#' This contains the modal shares (percentages of daily trips undertaken
#' by walking, cycling, public transport and private car) in several 
#' metropolitan areas of the world. The data is in the "long" format and it
#' contains a variable called "mode". We would like to transform it to the
#' "wide" format, so that each city only appears in one row, and the four
#' "modes" are variables. We can do this as follows:

mode_share_wide <- mode_share %>% pivot_wider(names_from = mode,
                                              values_from = share)

#' This is the desired effect. You can read the help file for the function
#' if you are not sure about the arguments of this function
#' 
#' Two problems happened with this result. First, we notice a typing error
#' in "South KOrea" in the last row. This can be solved with "mutate" and
#' "recode":
mode_share_wide <- mode_share_wide %>%
  mutate(country=recode(country, "South KOrea" = "South Korea")) 

#' But then, we might not need those "NA" values (they arise because of missing
#' or inconsistent information). If we want to remove them, we simply do
#' the following:
mode_share_wide <- mode_share_wide %>% drop_na()

#' But other treatments might be feasible... This is out of the scope of
#' this module, though! 

#' These are just the basic tools from the dplyr and tidyr packages.
#' You can explore further. The basic advice is to first be clear on what you
#' want to achieve. 

#' Let's practice a bit, using the mode_share_wide dataset that you have just
#' created.
#' 
#' First, create an "active mode" variable that sums up the shares of walking
#' and cycling. Use "mutate" for this.
#' 
#' (Code here)
#' 
#' Second, build a separate dataframe that contains only the information from
#' the US cities.
#' 
#' (Code here)
#' 
#' Finally, build a summary dataframe that contains the modal means per
#' continent. Which continent appears to have the higher public transport share?
#' 
#' (Code here)


### Basics of plotting #########################################################
#' One of the most relevant perks of using R is the fantastic publication-ready
#' plots you can easily create.
#' Base R already has built-in tools to plot your data:
plot(mtcars$hp, mtcars$mpg)

#' However, I would not really call them pretty!
#' They are useful to quickly run some checks over your analyses steps, but not
#' exactly ideal for your finalised plot.

#' Introducing ggplot2!
#' ggplot2 is a visualisation package that allows us to create fantastic plots, 
#' and gives extreme flexibility.
#' It has a special grammar that requires a bit of time to learn but once you 
#' understand the logic behind it, you can create really fancy stuff!
#' Always refer to the fantastic documentation you can find online.

#' The first thing to do is to install (unless you have it already) the library:
install.packages("ggplot2")
#' Then you have to load it in your workspace:
library(ggplot2)

#' Now we will get to see exacly what it can do. We will work on the familiar 
#' mtcars dataset.
data("mtcars")

#' A ggplot is an object that is defined following the grammar of graphics, which
#' I recommend to google when you have the time.
#' It takes a few basic elements such as your data, geometries (the shapes you 
#' will have on the plot), aesthetics (properties of the geometries and stats
#' objects you will add), statistical transformations (e.g. aggregations or 
#' distributions), facets (arrangements of your variables and plots) and themes
#' (visual aspect of the plots). Learning about it takes a long time, and a lot
#' of googling! Don't expect to learn everything in a week. Take your time and 
#' explore.

#' First requirement to work with ggplot is having plots in the long format, with
#' one observation in each row, instead of the wide format.

#' More in practice, a ggplot object is formed by multiple layers, connected by
#' the sign "+".
#' The first layer includes your data and variables. You can think of this as 
#' the baseline layer. Any additional properties you add here will apply to all 
#' the following layers (e.g. colours).
#' Let's recreate the previous base-R plot. Run the following command.
ggplot(data = mtcars, aes(x = hp, y = mpg))

#' To unpack what you see, we specified data, and variables inside the function
#' aes(). 

#' What you should see is an empty plot where only the variable names are shown.
#' Again, this is the baseline layer. Now we need to draw something on it! 
#' Run this:
ggplot(data = mtcars, aes(x = hp, y = mpg)) +
  geom_point()

#' Here we added a geom object, points in this case, which we want to use to 
#' draw the plot.
#' There are many other geoms which might be more useful for your purposes (always
#' refer to the documentation!)

#' For instance, let's plot something else with a different geom.
#' How about comparing the mpg by transmission (1 = manual, 0 = automatic) with 
#' a boxplot?
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg)) +
  geom_boxplot()

#' In this case we simply changed the geom used. We also changed the variables 
#' in aes() and we also included a conversion to factor because R thought "am" 
#' was a continuous variable. For certain grouped visualisation, you will need 
#' to convert to factor either outside or inside a ggplot function.

#' What if we wanted to include an additional geom to the plot? We literally
#' add ("+") to it:
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg)) +
  geom_boxplot() +
  geom_point()

#' As mentioned before, the layers are stacked on another so the order is key.
#' Try to change the order of the geoms and see what happens!

#' We can also change visual properties for the specific geom inside each geom
#' function:
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg)) +
  geom_boxplot(size = 0.3, alpha = 0.5) +
  geom_point(size = 2)

#' How about we get rid of the dull white colour?
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg)) +
  geom_boxplot(size = 0.3, alpha = 0.5, fill = "bisque") +
  geom_point(size = 2, color = "red4") 

#' Now we could give the axes proper names
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg)) +
  geom_boxplot(size = 0.3, alpha = 0.5, fill = "bisque") +
  geom_point(size = 2, color = "red4") +
  labs(x = "Transmission",
       y = "Miles per gallon")

#' Now we hardcoded the properties separatel for each geom. What if we wanted
#' to have different colors for our groups (by transmission)?
#' The solution is specifying the property by our variable inside the aes().
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg, fill = as.factor(am))) +
  geom_boxplot(size = 0.3, alpha = 0.5) +
  geom_point(size = 2, color = "red4") +
  labs(x = "Transmission",
       y = "Miles per gallon")

#' You can do this for many properties to make them change based on your variable.
#' Remember: if the property is specified inside the aes(), it will be based on 
#' the variable; if outside aes(), then it will be constant.
#' Pro tip: you can also specify aes() inside each geom for more finer grain 
#' control. Try yourself!

#' If we want to have more control over the properties of the plot, we can use 
#' the function theme:
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg, fill = as.factor(am))) +
  geom_boxplot(size = 0.3, alpha = 0.5) +
  geom_point(size = 2, color = "red4") +
  labs(x = "Transmission",
       y = "Miles per gallon") +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

#' The properties are quite intuitive to understand so you should be able to 
#' unpack the code yourself!
#' If you want a shortcut to obtain pretty much the same look you can use a
#' built-in ggplot theme:
ggplot(data = mtcars, aes(x = as.factor(am), y = mpg, fill = as.factor(am))) +
  geom_boxplot(size = 0.3, alpha = 0.5) +
  geom_point(size = 2, color = "red4") +
  labs(x = "Transmission",
       y = "Miles per gallon") +
  theme_classic()

#' Let's try something else with our mtcars dataset.
#' What if we wanted to consider three variables in our visualisation?
#' Say we want to see whether more power results in shorter 1/4 mile time, and
#' we want to check this for different numbers of cylinders.
#' We can do some faceting:
ggplot(data = mtcars, aes(x = hp, y = qsec)) +
  geom_point() +
  facet_grid(~cyl) +
  theme_classic() 

#' To save a ggplot you first need to give it a name:
plot = ggplot(data = mtcars, aes(x = hp, y = qsec)) +
  geom_point() +
  facet_grid(~cyl) +
  theme_classic() 

#' Then you can use the function ggsave() to export it the way you prefer:
ggsave(plot, filename = "beauty.png")

#' Even in saving there's lots of possibilities, in terms of size, dpi, format,
#' options, devices and so on. Start with simple pngs and then you can move on
#' to something more appropriate for your purposes.

#' This is really a glimpse of the potential of ggplot, and I highly recommend
#' trying to learn it if you plan on using R in your research.

### Exercise #########################
#' Using what we have learned so far and referring to the documentation online,
#' create a scatter plot with mtcars where:
#' - you show whether the weight of the car predicts miles per gallon
#' - show whether that changes for the transmission type
#' - change axes labels
#' - give an informative title to the plot
#' - provide a touch of colour!

