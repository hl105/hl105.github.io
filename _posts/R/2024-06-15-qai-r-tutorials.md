---

title: "[QAI] R tutorials"
excerpt: "useful R commands"
date: 2024-06-15
lastmod: 2024-07-30 22:00:11 -0400
last_modified_at: 2024-07-30 22:00:11 -0400
categories: R
tags: QAI R
classes:
toc: true
toc_label:
toc_sticky: true
header:
    image:
    teaser:
    overlay_image: ./assets/images/banners/default.png
sitemap:
    changefreq: daily
    priority: 1.0
author:
---

<!--postNo: 2024-07-30-->


 **Notebook and lecture from the Quantitative Analysis Institute Summer Program.** 


### week 0  - Basic R commands

1. **Vectors:**
	1. similar to numpy array
	2. ex) c(1,2,3,4,5) →  1  2  3  4  5,  c(1:3,5:12) →  1  2  3  5 10 11 12 (right inclusive)
	3. 5:10 is valid; but (5:7, 8:10) is invalid bc you need c to combine two expressions
	4. length() to find len
	5. NA for None
	6. merge two vectors by c(vec1, vec2)
	7. exp(vec1), log(vec1) ← applies to all elements in vec
2. **Matrices:**
	1. ex) mat1 = matrix(3,nrow=2, ncol=2) #matrix with all 3s
	2. dim(mat1), nrow(mat1), ncol(mat1)
	3. rows and columns

		```r
		?matrix #help page
		
		# first row, first column
		mat1[1,1]
		
		# all rows, column 1
		mat1[,1]
		
		# first row, all columns
		mat1[1,]
		
		# assign names to rows and columns
		rownames(mat1) <- c("Row1", "Row2")
		colnames(mat1) <- c("Col1", "Col2")
		
		# see names of rows and columns
		rownames(mat1) # "Row1" "Row2"
		colnames(mat1) # "Col1" "Col2"
		
		# view column 1
		mat1[,"Col1"]
		
		matrix(1:100, ncol=50)# nrow not assigned, R does it for you; 100/50 = 2 rows
		# if both nrow, ncol not assigned, R makes 1 col
		```

	4. matrix operations

		```r
		# Element-by-Element Multiplication
		mat1*mat2
		
		is.matrix(mat3)
		is.vector(vec1)
		as.matrix(vec1) # vertical matrix
		```

3. **Datasets**
	1. Dataset Examination

	```r
	
	?swiss
	
	# EXAMINE THE DATASET
	head(swiss) # see first few rows
	tail(swiss) # see last few rows 
	swiss # see entire data set
	dim(swiss)# number of rows and columns
	ncol(swiss) 
	nrow(swiss)
	colnames(swiss)
	summary(swiss) #min/1st Quartile/mean/3rd Q/max
	
	
	# R differentiates between "matrix" objects and "data frame" objects.
	# When you do read.csv/read.table it'll be a dataframe
	is.matrix(swiss)
	is.data.frame(swiss)
	swiss <- as.data.frame(swiss)
	
	swiss$Fertility #refer to a column (Fertility is col name)
	#OR you can do this (not recommended)
	attach(swiss)
	Fertility
	#OR you can also do:
	swiss[,"Fertility"]
	swiss[,1]
	```


	b. Dataset Summary


	```r
	mean(swiss$Fertility)
	var(swiss$Fertility)
	summary(swiss$Agriculture) #for continuous variables
	table(swiss$Education) #stem and leaf plot (for discrete variables)
	table(swiss$Education, swiss$Examination) # how many times each combination appeared
	```


	c. Subsetting Dataset


	```r
	FertilitySubset<-swiss$Fertility[swiss$Agriculture>50]
	summary(swiss$Fertility[swiss$Agriculture>50]) #fertitilty where agr > 50
	summary(swiss$Fertility[swiss$Agriculture>50 & swiss$Catholic>50]) #AND
	```


	d. Plotting Dataset


	```r
	hist(swiss$Fertility)
	boxplot(swiss$Fertility)
	plot(swiss$Agriculture, swiss$Fertility)
	
	plot(swiss$Agriculture, swiss$Fertility,
		main="Title Goes Here",
		xlab="X-axis label goes here",
		ylab="Y-axis label goes here",
		xlim=c(0,100),
		ylim=c(0,100),
		pch=21,
		cex=5,
		col="red")
	```

4. Logic

	```r
	# What if we compare a vector of numbers to another number?
	vec1<-c(2,4,5,6)
	vec1>3 # R distributes the 3 for you
	
	vec2<-2:5
	vec1==vec2 #TRUE
	```

5. Conditioning

	```r
	vec1[1] #1st el in vec1 (just like python list indexing)
	#same as
	vec1[c(TRUE, FALSE, FALSE, FALSE)]
	vec1[vec1==vec2] #same logic as above
	```

6. Graphics

	```r
	
	par(mfrow=c(1,2)) #mfrow = how to split window
	hist(rnorm(100))
	boxplot(rnorm(100))
	par(las=1) # turns horizontal labels to make it easier to read
	
	abline(v=10) # add a vertical line
	abline(h=0, lwd=3) # add a horizontal line, and make it thick using lwd:
	# add a line with intercept -3 and slope .1, change the line type via lty and the color via col
	abline(-3,.1, lty=2,col="orange")
	
	# For plots, here's an excerpt from the RPrimer:
	plot(swiss$Agriculture, swiss$Fertility,
		main="Title Goes Here",
		xlab="X-axis label goes here",
		ylab="Y-axis label goes here",
		xlim=c(0,100),
		ylim=c(0,100),
		pch=1, #point character (circle dot, triangle dot, x dot, etc.)
		cex=5, # default point size will be multiplied by this number
		col="red")
	
	colors() # names of available colors
	
	```

7. Packages

	```r
	install.packages("perm") #just once
	library(perm) #import
	```

8. importing a dataset

	```r
	getwd()
	setwd()
	d=read.csv(file="path",header=TRUE)
	```


### week 3


boxplots


```r
boxplot(vec1, main = "title", ylim= c(0,11))
boxplot(vec1, vec2, vec3) # how to put multiple plots with same scale

groups = c('sophomore', 'junior', 'first-year', 'junior')
boxplot(vec1~groups) #vec1: set of values, groups: what group each val is in. ~ means by

boxplot(iris$Sepal.length~iris$Species) # this col grouped by diff col
```


objects


```r
output = t.test(vec1, vec2)  #output is object
output$p.value # you can check attributes using names(output) command
```


by, apply, which 


```r
by(iris$Sepla.Length, iris$Species, mean) # applies a func to a vector after grouping based on another vector
apply(iris[,1:4], 2, mean) # applies a function to all the rows(1) or columns(2) of matrix/dataframe
which(iris$Species=='virginica') # provides the indices of a vector where a particular condition is true
```


if, ifelse


```r
if (6>7) {
	object = 3
}

output = ifelse(iris$Species=='virginica', "red", "blue")
```


saving, writing, reading


```r
save(iris, file="...R") # save an R object
load(file="...R") # load a saved R object
write.csv(iris, file="...") # save a matrix/dataframe to a csv

pdf(file="....pdf") # write graphics to pdf. or you can also do jpeg(file="....jpeg")
plot(1:10);
plot(2:30)
dev.off()

```


replace na values R


```r
d[is.na(d)] <- 0

```


drop na


```r
library(tidyr)
student %>% drop_na(maths)
```


### week 4


Splines


```r

### Splines

# There are lots of functions and packages available that relate to splines.
# One basic one is "spline", which takes in a set of (x,y) pairs and returns a larger set of (x,y) pairs that fills in all the gaps. For example:
spline(x=c(1,2,3),y=c(3,16,6),n=9)
# the default is to return three times as many points as you provide, but you can change "n" to alter this
# useful to save the output:
splineout<-spline(x=c(1,2,3),y=c(3,16,6),n=9)
# because then you can access
splineout$x
splineout$y
plot(c(1,2,3),c(3,16,6))
points(splineout$x,splineout$y,type='l',col="red")


```


Regression Trees


```r

### Trees
# use the package "party"
# install the package just once
install.packages("party")
# run the library command every time (will get warning messages, but that's okay)
library(party)

# save the output as an object
# specify the outcome vector, then "~", then the predictor vectors with "+" in between
treeoutput1<-ctree(iris$Sepal.Length~iris$Sepal.Width+iris$Petal.Length)
# equivalently, if these are all columns in the same data set:
treeoutput1<-ctree(Sepal.Length~Sepal.Width+Petal.Length, data=iris)
# default graph has way too much information:
plot(treeoutput1)
# can simplify the output for yourself if the final nodes are a continuous variable:
plot(treeoutput1, inner_panel=node_inner(treeoutput1, pval=FALSE, id=FALSE), terminal_panel=node_boxplot(treeoutput1, id=FALSE))
# if you don't want the plots at the bottom, you can do this:
plot(treeoutput1, inner_panel=node_inner(treeoutput1, pval=FALSE, id=FALSE), terminal_panel=node_terminal(treeoutput1, id=FALSE))


# if you are trying to predict a categorical variable
treeoutput2<-ctree(Species~Petal.Width+Petal.Length, data=iris)
# can simplify the output for yourself:
plot(treeoutput2, inner_panel=node_inner(treeoutput2, pval=FALSE, id=FALSE), terminal_panel=node_barplot(treeoutput2, id=FALSE))
# if you don't want the plots at the bottom, you can do this:
plot(treeoutput2, inner_panel=node_inner(treeoutput2, pval=FALSE, id=FALSE), terminal_panel=node_terminal(treeoutput2, id=FALSE))

### Random forests are a way to take into account the fact
### that there is uncertainty in your choice of tree.
### A slightly different data set might have led
### to a different tree.

# You can also run a random forest, but you need another package
# install the package just once
install.packages("randomForest")
# run the library command every time
library(randomForest)

# see help file for randomForest to understand some of the options
# the first argument looks like the first argument to ctree
# the default number of trees to "grow" is 500, but you can change it with the argument ntree
# there are also defaults for things like nodesize, maxnodes, etc.
# The "importance" argument tells the function to save information about how important each variable is
rFout<-randomForest(Sepal.Length~Sepal.Width+Petal.Length, data=iris,
		ntree=600, importance=TRUE)
# It can be hard to know how to interpret the output of a random Forest. You don't end up with just one tree to view. One useful piece of output is the list of "importance" values, which indicate how crucial each predictor is for predicting the outcome.
rFout$importance
# both of these measures indicate how much better the predictions are when you include the variable. So, higher numbers are better.
```


More plots


```r

#### Graphics:

# Suppose you want to add a legend to a plot.
# Look up the help page for the legend command.
# Start with a plot:
plot(1:10,1:10, pch=c(rep(1,5),rep(2,5)),
		col=rep(c(1,2),5))
# then add the legend:
legend("bottomright", # specify the location, either with a phrase like this or with coordinates
	legend=c("type1","type2","type3","type4"), # labels here
	pch=c(1,2,1,2), # symbol types for four points to be plotted
	col=c(1,1,2,2) # colors for four points to be plotted
	)
	# you don't have to use both pch and col. If it's only color, try the "fill" argument to obtain rectangles filled in with the different colors. For lines, use lty and lwd to specify different types of lines.
	
# Sometimes it's helpful to add elements to a plot after you've created it.
# legend is one example
# You've already seen abline, which adds a line
# You can also plot additional points.
# Start with a plot:
plot(1:10,1:10, type='o')
# Then add more points with "points"
points(2:5,3:6, col="red", type="l")

# The "type" argument works for both plot and points.
# The default is "p", which makes points.
# "l" connects the points to form a line
# "o" plots the points and also connects them

# The function "lines" is the same as "points" with type="l"
# If there's a difference between them, I don't know what it is

# You can also add text anywhere on a plot using the command "text".
# first, specify where you want the text by providing x and y coordinates 
# then, the "labels" argument contains the text
# You have to have a plot window open, such as the plot you just made
text(x=5,y=6,labels="Example Text", cex=.5, col="red")

# Any of the first three arguments can be a vector
text(x=c(4,8), y=c(4,4), labels=c("First","Second"), cex=1.5, col="blue")

# If you try to add text and don't see it, make sure the x and y values are within the range shown in your plot!



## Creating your own functions
## Ever find yourself repeating the same steps many times? You can write your own R functions, with input and output.
# Here is a simple example:

# Run this code
myfirstfunction<-function(x) {
	
	y<-x^2
	return(y)
}

# And then use your function:
myfirstfunction(3)

# For example, perhaps you want to run a clustering algorithm and make a plot like the one created above for the first two variables, and you'll want to do this for multiple data sets.
myclusterfunction<-function(data, numclusters) {
	
	koutput<-kmeans(data,numclusters)

	plot(data[,1],data[,2],
	col=koutput$cluster,
		xlab=colnames(data)[1],
		ylab=colnames(data)[2])
	legend("topleft",
	legend=c(1:numclusters),
	fill=c(1:numclusters))
	
	return(koutput)
	
}

# now you can use this to generate the same output as above:
swissoutput<-myclusterfunction(data=swiss,numclusters=3)
# but you can also use it for other data sets, such as the subset of iris containing numeric variables
irisoutput<-myclusterfunction(data=iris[,1:4],numclusters=5)




# Graphical functions to check out:
# polygon (also helpful: seq, rev)
plot(1:10,1:10, col="white",ylim=c(-100,100))
sequence<-seq(1,10,.01)
polygon(x=c(sequence, rev(sequence)),
		y=c(-sequence^2, rev(sequence^2)),
		col="blue")

# grid, segments
grid()
segments(x0=c(1,2),y0=c(1,1),
		x1=c(20,20),y1=c(30,60),
		lwd=5)

# plot(..., axes=FALSE) then: axis, box
plot(1:10,axes=FALSE)
box()
axis(3)
axis(4)
# can change labels and spacing of axes, too

# gray, rainbow, heat.colors, colors()
plot(1:10,pch=16,cex=5,col=gray(seq(.1,1,.1)))
plot(1:10,pch=16,cex=5,col=rainbow(10))
plot(1:10,pch=16,cex=5,col=heat.colors(10))
colors()

# layout: fancier than par(mfrow=c(...))
layout(matrix(c(1,2,1,3),nrow=2))
hist(1:10)
plot(1:10)
boxplot(1:10)
# restore to default
par(mfrow=c(1,1))

# image
image(matrix(1:10,nrow=2))
# related: heatmap, contour, stripchart, colorRampPalette

# check out popular graphics packages: lattice, ggplot2



```


### ggplot2 


basics


```r
# 2 ways to build a graph, 1) qplot(), 2) ggplot()
# This tutorial is going to cover ggplot() since we have more control and can produce more complicated graphs

#brief summary of qplot()
#qplot() is for making a 'quick' plot. It allows you to create a complete plot given data, geom, and aes mappings
qplot(x=carat, y=price, data=diamonds, geom='point')

#ggplot begins a plot that you can add layers to. 
#this creates the exact same plot as the qplot() above
ggplot(data=diamonds, aes(x=carat, y=price))+geom_point()

#Basic idea of the structure of ggplot, specify parts of the plot and then add a plus sign between them. 
#we add 'layers' with the plus sign

#watch how we can build up this graph by running each of the 3 lines of code one by one
ggplot()
ggplot(data=diamonds, aes(x=carat, y=price))
ggplot(data=diamonds, aes(x=carat, y=price))+geom_point()

```


aes


```r

#-------------------------------aes function -------------------------------
#aes stands for aesthetics 
#The aes function is for generating aesthetic mappings that describe how variables in the data set are mapped to aesthetics of geoms
#basically it is a function that is used to detail what is displayed and how it is displayed. you don't need to use the $ to specifiy the variables anymore

#you should see a blank graph if you run the code below. This is because you only specified how the variables are going to be mapped on the x and y axis. 
ggplot(diamonds, aes(x= carat, y=price))

#-------------------------------- Geoms-------------------------------------------------------------------------------------
#geoms are the names for the types of shapes that represent the data on the chart 
#Two types of geoms
#1) geom_point < works on individual data points 
#2) collective geom that requires a collection of data, like a box plot or a histogram 
#can think of geom_histogram as adding a layer
ggplot()+geom_point()

#scatter plot
ggplot(diamonds, aes(x= carat, y=price))+geom_point()
#line
ggplot(diamonds, aes(x= carat, y=price))+geom_abline()
#histogram
ggplot(diamonds, aes(x= carat))+geom_histogram(binwidth = 0.1, bins =15)
#box plot
ggplot(diamonds, aes(x= carat, y=price, group=cut))+geom_boxplot(outlier.color="red")

#please go on to this wonderful site and look at all the geoms, 
# there are around 30 geoms so it would talk to long to talk about each
# http://docs.ggplot2.org/current/ (this link doesn't work anymore, use the one below)
https://ggplot2.tidyverse.org/reference/

#----------------------------------- more on the aes function----------------------------------------------------------------
# so far we have only used the aes to specify the variables that we want to map onto the x and y axes
# we can use the aes for more than that!
 
#aes shape
#this means we want to map the diamond's cut onto the shape of the points
ggplot(diamonds, aes(x= carat, y=price, shape=cut))+geom_point()

#aes size
ggplot(diamonds, aes(x= carat, y=price, size=color))+geom_point(color="black")

#aes color
ggplot(diamonds, aes(x= carat, y=price, color=color))+geom_point()

#editing aes with the iris data set 
ggplot(iris, aes(x= Sepal.Length, y=Petal.Length, color=Species))+geom_point(cex=2)
ggplot(iris, aes(x= Sepal.Length, y=Petal.Length, size=Species))+geom_point(color="dark blue")
ggplot(iris, aes(x= Sepal.Length, y=Petal.Length, shape=Species))+geom_point(color="dark blue", cex=4)
ggplot(iris, aes(x= Sepal.Length, y=Petal.Length, alpha=Species))+geom_point(color="dark blue", cex=4)

#aes with continuous variable
#the color gives us a gradient color bar
ggplot(diamonds, aes(x= carat, y=price, color=depth))+geom_point()

#we can also map a variable onto the type of line. This is a kinda terrible example below but you get the point that we can use different types of lines to represent another variable. 
ggplot(diamonds, aes(x= carat, y=price, linetype=cut))+geom_line()

#aes and histograms
#even though there is only one variable here we can visually include another  by coloring the bars by the cut
#notice the difference between the fill and the color
ggplot(diamonds, aes(x = carat, fill = cut))+geom_histogram(binwidth=.1, bins=15)
ggplot(diamonds, aes(x = carat,color=cut))+geom_histogram(binwidth=.1, bins=15)

#remember the aes is for specifying how we want to  map variables onto the plot. 
#See what happens when we try to assign color in the aes function to a color
ggplot(diamonds, aes(x=carat, y=price, color="light blue"))+geom_point()
#Assigning the color in the aes function to an actual color creates a factor by color called light blue which doesn't exist in the diamonds dataset. We assign color, shape, or size in the aes fuction to a variable to specify how we want to map that variable onto the plot. 

#if you want the points to be blue you need to specify the color in the geom as a argument in the geom
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(color="light blue")

#can make things more see through adding alpha
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(color="light blue", alpha=0.5)

```


layers


```r


#--------------------------------Idea of layers----------------------------------------------------------------
#each layer (thing we add on with +) can use its own data frame, variables and aesthetics
#instead of specifying the aes mapping in the ggplot() function we can specify the aes mapping within the geom, 
ggplot(diamonds, aes(x=carat, y=price, color=depth))+geom_point()
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=depth))

#All of these 3 lines of code make the same plot
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))
ggplot(diamonds, aes(x=carat, y=price, color=cut ))+geom_point()
ggplot()+geom_point(data=diamonds, aes( x=carat, y=price, color=cut))

#the '+' operator just allows the code to be broken up into spearate lines 
p<-ggplot(diamonds, aes(x=carat, y=price ))
p+geom_point(aes(color=cut))

#the latest layer's specifications override the ones below
#for example if I specify that I want to map cut onto the color of the points on the graph but then I say I want the points to be blue in the geom function, the points will be blue
ggplot(diamonds, aes(x=carat, y=price, color=cut ))+geom_point(color="light blue")


```


scales


```r
#basic plot
#start with this plot
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))

#changing the colors
#then we can change the colors of the points using scale_color_manual. Give it a list of colors 
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+ scale_color_manual(values=c("light pink", "light yellow", "light blue", "thistle1", "orange"))

#changing the shape
#If we specified the shape instead of the color to represent the cut of a diamond we can manually change the shapes
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(shape=cut))+scale_shape_manual(values=c(16,17,18,17,15))

#editing the x axis
#we can specify the limits, labels, and ticks of the x axis 
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+scale_x_continuous("Diamond Carat", limits=c(0,6))

#for the y axis
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+scale_y_continuous("Diamond Price", limits=c(0,20000))

#labels
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+labs(x="Carat", y="Price", title="Diamonds")

#quickly add title with ggtitle()
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+ggtitle("Diamonds")

#we can more conveniently change x  and y axis limits using xlim and y lim. 
ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=cut))+ xlim(c(0,10))+ylim(c(0,20000))


#all of these functions have a help page! please look
?scale_color_manual
?scale_x_continuous
#also look at the ggplot2 cheatsheet 
```


faceting


```r

#-------------------------------------------------Faceting---------------------------------------------
#grouping data into different plots, i'm going to use the iris data set for this because it makes more sense in this case
#Faceting displays subsets of data in different panels
#When there are 2 discrete variables a grid can be laid out by specificying the variable on either side of the ~

#facets, vertical strips, showing carat vs price for each type of diamond cut
ggplot(diamonds, aes(carat, price))+geom_point() + facet_grid(.~cut)
#facets, horizontal strips, showing carat vs price for each type of diamond cut
ggplot(diamonds, aes(carat, price))+geom_point() + facet_grid(cut~.)

#facets of the type of cut and color of the diamond
ggplot(diamonds, aes(carat, price))+geom_point() + facet_grid(cut~color)

```


stats


```r

#--------------------------------------------------Stats----------------------------------------------
#stats apply statistical transformations that summarize the data. It is an alternate way to build a layer like a geom
#stat functions and geom functions both combine a stat with a geom to make a layer
#these two are the same 
ggplot(diamonds, aes(carat))+stat_bin(geom="bar")
ggplot(diamonds, aes(carat))+geom_bar(stat="bin")


#---------Stat Smooth (important subsection of stats)-------------
# stat smooth is for creating a fitted line. 
#look at help page see that "geom_smooth and stat_smooth are effectively aliases: they both use the same arguments"
#Use geom_smooth unless you want to display the results with a non-standard geom.
?geom_smooth
?stat_smooth
#notice stat smooth is the same as geom_smooth
ggplot(diamonds, aes(carat, price))+stat_smooth()
ggplot(diamonds, aes(carat, price))+geom_smooth()

#What they mean by "unless you want to display the results with a non-standard geom" is the line of code below
#if for some reason we wanted our fitted line to be dots or bars instead of a line we can specify the geom in the stat smooth function. We cannot do this in the geom_smooth function, this would just make points ontop of the smoothed line
ggplot(diamonds, aes(carat, price))+geom_smooth()+geom_point()

#"non standard geom with stat smooth"
ggplot(diamonds, aes(carat, price))+stat_smooth(geom="point")
ggplot(diamonds, aes(carat, price))+stat_smooth(geom="bar")

#The default method is the loess regression (locally weighted scatterplot smoothing) but we can change that to lm. glm, gam, rlm. You should be familiar with the lm regression which is the least square regression
ggplot(diamonds, aes(carat, price))+geom_point() + stat_smooth(method="lm", level=0.95)+scale_y_continuous(name="price", limits=c(0,20000) )

#-----------------

#stat_unique remove duplicates
ggplot(diamonds, aes(carat, price))+geom_point(color="grey") +stat_unique()

#if we have split it up factors by mapping the diamond cut to color then adding a stat_smooth line will add one for each factor
ggplot(diamonds, aes(carat, price, color=cut))+geom_point() + stat_smooth(method="lm")

#another cool stat function is stat_summary
?stat_summary
#the blue dots are all the data point's for each diamond and the black dots are the mean at each x value. 
ggplot(diamonds, aes(carat, price))+geom_point(color="blue") +stat_summary(fun.y=mean, geom="point")

#we can specify the geom to be bars and change the function as well 
#this graph is a terrible idea but a good example of what you can do
ggplot(diamonds, aes(carat, price))+geom_point(color="blue") +stat_summary(fun.y=max, geom="bar")

#I can also write your own function and set the fun.y to be my function
# You can see that my function equal 5000 for any x.
myFunction<-function(x){
(x/x)+5000
}
#if we set the function for the y axis to be myFunction we should get a straight red line at y=5000 made up of points
ggplot(diamonds, aes(carat, price))+geom_point(color="blue") +stat_summary(fun.y=myFunction, geom="point", color="red" )

#--------------------------------------------------Annotation------------------------------------
#can add text to the plot using the annotate function
ggplot(diamonds, aes(carat, price))+geom_point()+annotate("text", x=3, y=5000, label = "words on the graph")

#can add math notation to the plot using plot math notation, make sure you say parse=TRUE
?plotmath
ggplot(diamonds, aes(carat, price))+geom_point(color="grey")+annotate("text", x=3, y=5000, label = "sum(hat(x),i==1, n)", parse=TRUE, cex=10)

#add rectangle
ggplot(diamonds, aes(carat, price))+geom_point()+annotate("rect", xmin=0, xmax=1.5, ymin=100, ymax=7000, fill = "pink", alpha = 0.5)

#here is the code from the intro video where I showed you how the order of the layers matters using the pink rectangle. 
 ggplot(diamonds, aes(carat, price))+geom_point()+annotate("rect", xmin=0, xmax=1.5, ymin=100, ymax=7000, fill = "pink", alpha = 0.5)
ggplot(diamonds, aes(carat, price))+annotate("rect", xmin=0, xmax=1.5, ymin=100, ymax=7000, fill = "pink", alpha = 0.5)+geom_point()

#add line
ggplot(diamonds, aes(carat, price))+geom_point()+annotate("segment", x=2, xend=2, y=0, yend=20000, color="blue")


```


themes


```r

#------------------------------------------------Themes--------------------------------------------------------------------
#Themes allow you to control the non data elements of a ggplot object
#1)there are theme elements, which refer to individual attributes of a graphic that are independent of the data like font size, axis ticks, grid lines, and background of a legend
#use theme() to modify different elements

#start with basic plot
ggplot(data=diamonds, aes(x=carat, y=price, color=cut))+geom_point()

#we can modify, background, legend, and the grid
ggplot(data=diamonds, aes(x=carat, y=price, color=cut))+geom_point()+ggtitle("diamonds")+theme(
	axis.text= element_text(size=14, family="Helvetica", color="red"), #changing axis text font and size
	legend.text=element_text(color="white", family="Helvetica"),
	legend.key= element_rect(fill="black"),
	legend.background=element_rect(fill="black"), 
	legend.position = c(0.9,0.3),
	panel.grid.major=element_line(color="white"), 
	panel.background=element_rect(fill="black"),
	axis.ticks=element_line(color="red")
)



#theme functions define the settings of a collection of theme elements for creating specific style graphics
#minimal
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_minimal()
#I like to use the minimal theme and make the points blue to look like the plotly scatter plots before I use ggplotly which I will talk about below
ggplot(diamonds, aes(carat, price))+geom_point(color="dodgerblue3")+theme_minimal()

#theme_classic, White background no gridlines
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_classic()

#theme_grey, grey background default
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_grey()

#there is an additional package called ggthemes
install.packages("ggthemes")
library(ggthemes)
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_solarized()
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_gdocs() #meant to look like google docs
ggplot(diamonds, aes(carat, price))+geom_point(color="grey52")+theme_stata() #meant to look like stata

```


saving plots


```r

#----------------------------------------------saving plots and data sets with plots--------------------------------------
#we can save plots and the data sets that created it

#say I just finished creating this messed up plot and I wanted to save it 
p<-ggplot(diamonds, aes(x=carat, y=price ))+geom_point(aes(color=color))+ scale_color_manual(values=c("light pink", "light yellow", "light blue", "thistle1", "orange", "olivedrab1", "salmon1"))+scale_shape_manual(values=c(16,17,18,17,15,1,1,))+scale_x_continuous(name="diamond carat", limits=c(0,3.75) )+scale_y_continuous(name="price in dollars", limits=c(0,20000) )+labs(x="diamond carat", y="price in dollars", title="The relationship between a diamond's carat and price")+facet_grid(.~cut)+stat_smooth(method="lm", color="grey52")+annotate("text", x=3, y=5000, label = "diamonds", cex=2)+annotate("rect", xmin=0, xmax=1.5, ymin=100, ymax=7000, fill = "pink", alpha = 0.5)+theme(panel.background = element_rect(fill = "aliceblue"))+geom_smooth(aes(fill=cut))

#we can save the data for your plot into your working directory. 
save(p, file="Diamonds.RData")

#we can save the image using ggsave
ggsave("Diamonds.png")

#now we can load the data set we used to create the image
load("Diamonds.RData")
```


interactive


```r

#------------------------------------Making the plot interactive with ggplotly------------------------------------------------
#ggplotly works by serializing ggplot2 figures into plotly's universal graph JSON which is built using JavaScript
#Basically we use the ggplotly function to open ggplot2 figures in the web browser as an HTML widget that is created using javascript

#First create your plot using ggplot()
p<-ggplot()+geom_point(data=diamonds, aes( x=carat, y=price, color=cut))

#then put your plot into the ggplotly function and you will get an interactive graph
ggplotly(p)

```


week 5


Regression


```r

### Regression in R

# The command for a linear regression is "lm".
# To run a regression, give a name to the output of lm,
# and write (outcome vector) ~ (predictor vector)
lm1<-lm(iris$Sepal.Length~iris$Sepal.Width)
# To view some of the output:
summary(lm1)
# This gives you the coefficient estimates and the t-statistics and p-values for tests of the null hypotheses that each coefficient is equal to zero.
# At the bottom, there is also an F-statistic and p-value for a test comparing the specified regression model to the equal means model. The null hypothesis is that the equal means model is sufficient.

# To access particular components of the output:
lm1$coef # coefficient estimates
lm1$resid # vector of residuals
lm1$fitted.values # vector of fitted values (predicted means)
# To view confidence intervals for the parameter estimates:
confint(lm1)

# If the vectors come from the same data frame, it's usually simpler to run the regression this way:
lm1<-lm(Sepal.Length~Sepal.Width, data=iris)

# If you plot the data:
plot(iris$Sepal.Width, iris$Sepal.Length)
# then you can use "abline" to add the fitted regression line:
abline(lm1$coef)

# Check regression assumptions by plotting the residuals against the fitted values. We won't have time to go into the details here, but if you see a pattern, the assumptions could be false.
plot(lm1$fitted.values, lm1$resid)

# R also has some default plots for regression. I suggest creating your own, though, as these tend to include information you don't need and/or haven't yet studied.
plot(lm1)

# To add multiple predictors, put plus signs between the predictors:
lm2<-lm(Sepal.Length~Sepal.Width+Petal.Width, data=iris)
summary(lm2)

# To add an interaction, use ":"
lm3<-lm(Sepal.Length~Sepal.Width+Petal.Width + Sepal.Width:Petal.Width,data=iris)
summary(lm3)
#(we didn't talk about interactions between continuous covariates in this pilot course, but, mathematically, it's just a third term added to the model for the means with a coefficient multiplied by the product of two predictors. There intuition is that the relationship between one predictor and the outcome depends on the other predictor, if there is an interaction.)

# To tell R that you want both predictors and an interaction, you can use "*" as a shortcut for the previous line of code:
lm3<-lm(Sepal.Length~Sepal.Width*Petal.Width, data=iris)


```


shiny 


```r
## ####################### ##
## Intro to Shiny Tutorial ##
## ####################### ##
#Shiny lets you create a manipulable window 
#Shiny app is maintained by computer running R

#install and open shiny
install.packages("shiny")
library(shiny)

#### Example Shiny App ####

## Open birthweight dataset on risk factors associated with low infant birth weight 
install.packages("MASS")
library("MASS")

#explore and clean up variable names
?birthwt
d <- birthwt
head(d)
dim(d)
names(d)
colnames(d) <-c("Birthweight Less Than 2.5kg", "Mother's Age", "Mother's Weight in lbs at Last Menstrual Period", "Mother's Race", "Mother Smokes", "Number of Previous Premature Labours", "History of Hypertension", "Uterine Irritability","Number of Physician Visits During 1st Trimester", "Birthweight in Grams")

#create subsets using median mother's age
table(d$"Mother's Age")
median(d$"Mother's Age") ## Median age is 23

d$"Mother over 23" <- 0
d$"Mother over 23"[d$"Mother's Age" > 23] <- 1 
d$"Mother under 23" <- 1                            #the indicator for mothers>23 yo tells you mothers who are older AND younger than 23 
#                                                   so you don't need an indicator for mothers<23 yo but this was created for ease to create 
#                                                   the label in the dropdown menu in the app below- it's completely possible to create this app
#                                                   without multiple indicators!
d$"Mother under 23"[d$"Mother's Age" > 23] <- 0
d$"No subset" <- 1

#run code for example shiny app (lines 42 - 87) you will not understand this right now- this is just to show you some possibilities! You can return to this after you complete the module to better understand it

## with subgroups 

ui <- fluidPage(
  headerPanel('Birthweight Data Set t-Test'),
  sidebarPanel(
    selectInput('subset', '1. Pick a Subset', choice=names(d[,c(11:13)]), selected = colnames(d)[11]),
    selectInput('valcat', '2. Pick a Categorical Variable (0=No, 1=Yes)', choices=names(d[,c(5,7,8)]),  selected =colnames(d)[5] ),
    selectInput('valcont', '3. Pick a Continuous Variable', choice=names(d[,c(3,10)]), selected =colnames(d)[3]),
	radioButtons("col1", "4. Select Color for Histogram", choices=c("Blue", "Red", "Purple","Green"), selected = "Green"),
	radioButtons("col2", "5. Select Color for Boxplot 1", choices=c("Blue", "Red", "Purple", "Green"), selected = "Blue"),
	radioButtons("col3", "6. Select Color for Boxplot 2", choices=c("Blue", "Red", "Purple","Green"), selected = "Red"),
	tableOutput('table')
  ),
  mainPanel(
  	plotOutput('hist'),
    plotOutput('boxplot'),
    h5(textOutput('txt')),
    htmlOutput('text'),
  )
)

server <- function(input, output) {
	output$hist <- renderPlot({
		data1 <- subset(d, d[,input$subset] > 0 , select=c("Mother's Weight in lbs at Last Menstrual Period", "Mother Smokes", "History of Hypertension", "Uterine Irritability","Birthweight in Grams","Mother over 23", "Mother under 23","No subset"))
		hist(data1[,input$valcont], main= paste("Histogram of", input$valcont), xlab=input$valcont, col=input$col1)
		})
  	output$boxplot <- renderPlot({
  		data1 <- subset(d, d[,input$subset] > 0 , select=c("Mother's Weight in lbs at Last Menstrual Period", "Mother Smokes", "History of Hypertension", "Uterine Irritability","Birthweight in Grams","Mother over 23", "Mother under 23","No subset"))
  		boxplot(data1[,input$valcont]~data1[,input$valcat], main = paste("Boxplots of", input$valcont, "by", input$valcat), ylab = input$valcont, xlab=input$valcat, col=c(input$col2, input$col3))
  		})
  	output$txt <- renderText({
  		paste("Results of t-test of", input$valcont, 'by', input$valcat)
  	})
    output$text <- renderUI({
    	data1 <- subset(d, d[,input$subset] > 0 , select=c("Mother's Weight in lbs at Last Menstrual Period", "Mother Smokes", "History of Hypertension", "Uterine Irritability","Birthweight in Grams","Mother over 23", "Mother under 23","No subset"))
    	t <- t.test(data1[,input$valcont]~data1[,input$valcat])
    	str1 <- paste("t-Statistic:", round(t$"statistic", digits = 3))
    	str2 <- paste("Degrees of Freedom:",round(t$"parameter", digits =0))
    	str3 <- paste("p-value:", round(t$"p.value", digits = 3))
    	str4 <- paste("Lower bound of 95% Confidence Interval:", round(t$"conf.int"[1], digits = 3))   	
    str5 <- paste("Upper bound of 95% Confidence Interval:", round(t$"conf.int"[2], digits = 3))
    str6 <- paste("Mean", input$valcont, " in Group 0:", round(t$"estimate"[1], digits = 3))
    str7 <- paste("Mean", input$valcont, " in Group 1:", round(t$"estimate"[2], digits = 3))
    HTML(paste(str1, str2, str3, str4, str5, str6, str7, sep = '<br/>'))
    })
    output$table <- renderTable({subset(d, d[,input$subset] > 0 , select=c(input$valcat,input$valcont))})
}
shinyApp(ui = ui, server = server)

#hit stop to stop running app (or esc)
  
#_______________________________________________________________________________________________

##### Basic Shiny Template #####
ui<-fluidPage()
server<-function(input, output){}
shinyApp(ui=ui, server=server)
#hit stop to stop running app (or esc)

##### User Interface (UI) #####
#Functions for laying out the user interface for your application

#Add elements to your app as arguments in the UI fluidPage()
ui<-fluidPage("STAT260")
server<-function(input, output){}
shinyApp(ui=ui, server=server)
#hit stop to stop running app (or esc)

#You can move elements of your app to be displayed in different panels 
ui<-fluidPage(
	headerPanel("WELCOME"),
	sidebarPanel("TO"),
	mainPanel("STAT260"))
server<-function(input, output){}
shinyApp(ui=ui, server=server)
#hit stop to stop running app (or esc)

## INPUTS & OUTPUTS ##
#Build your app around INPUTS and OUTPUTS that you add to your UI fluidPage()
#Input: Things that user toggles, used to provide values to app
#outputs: R objects that user sees, things that respond when user changes input 
#add inputs and outputs to your app as arguments to fluid page

#_______________________________________________________________________________________________
#INPUTS

#SYNTAX OF INPUT FUNCTIONS
selectInput(inputId="input", label="Label for input", ...) 
#inputID : input name to be used later in the server function *You can name this anything! 
#label: label that is displayed on the page for the input
#...: input specific arguments

#EXAMPLES OF INPUT TYPES
# sliderInput creats a slider (needs a starting, min and max value for the slider)
ui<-fluidPage(
sliderInput(inputId="num", label="Choose a number", value=25, min=1, max=100) 
)
server<-function(input, output){}
shinyApp(ui=ui, server=server)
#hit stop to stop running app (or esc)

# selectInput creates drop down menu (needs a list of choices and can have a selected default choice)
ui<-fluidPage(
selectInput(inputId="var", label="Choose a variable:", choices=c("Option 1", "Option 2", "Option 3"), selected = "Option 1")) 
server<-function(input, output){}
shinyApp(ui=ui, server=server)
#hit stop to stop running app (or esc)

#radioButton creates a multiple choice list (needs a list of choices and a selected default choice)
ui<-fluidPage(
radioButtons(inputId="var", label="Choose a variable:", choices=c("Option 1", "Option 2", "Option 3"), selected = "Option 1")
)
server<-function(input, output){}
shinyApp(ui=ui, server=server)

#_______________________________________________________________________________________________
#OUTPUTS

#SYNTAX OF OUTPUT FUNCTIONS
selectOutput(outputId="output", label="Label for input", ...)
#outputID : output name to be used later in the server function *You can name this anything! 

#EXAMPLES OF OUTPUT TYPES 
#plotOutput() #adds plot
#tableOutput() #adds interactive table
#htmlOutput() #adds raw HTML
#imageOutput() #adds image
#textOutput() #adds text block
#VerbatimTextOutput() #adds text block of raw R output 

#example of plot output function with selectInput
ui<-fluidPage(
    selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3)]), selected =colnames(d)[2]),
    plotOutput(outputId="hist")
)
server<-function(input, output){}
shinyApp(ui=ui, server=server)

ui <- fluidPage(
  #header
  headerPanel('Birthweight Data Set Visualizations'),
  #drop down choices in sidebar
  sidebarPanel(
    selectInput('valcat', 'Pick a Categorical Variable (0=No, 1=Yes)', choices=names(d[,c(1,5,7)])),
    selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3,6)])),
  ),
  #make room for histogram and boxplot
  mainPanel(
    plotOutput('hist'),
    plotOutput('boxplot')
  )
)

#__________________________________________________________________________
##### Server Function #####
#We write the instructions on how to build the app inside the server function by creating output objects

#basic layout of server function 
server<-function(input, output){
		#output objects 
	}

### 3 STEPS TO BUILIDING OUTPUT OBJECTS ## 

#Step 1: Save output object as output$outputID (which you defined in the ui)
#don't run
#Lets take the ui from the earlier example
ui<-fluidPage(
  selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3)])),
  plotOutput(outputId="hist")
)
server<-function(input, output){
	output$hist  # NEW OUTPUT OBJECT
}
shinyApp(ui=ui, server=server)

#Step 2: Build objects to display with a render function
#don't run
#Example render functions:
#renderPlot() #creates reactive plot
#renderTable() #creates reactive table 
#renderText() #creates reactive text block
#renderUI() #creates reactive HTML
#renderImage() #creates reactive image
#renderPrint() #prints output - often paired w verbatimtextOutput()

#Lets see what this looks like for our histogram example 
ui<-fluidPage(
  selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3)])),
  plotOutput(outputId="hist")
)
server<-function(input, output){
  output$hist <- renderPlot({
	  hist(data)
		})
}
shinyApp(ui=ui, server=server)

#Step 3: Use input values with input$inputID (which you defined in the ui)

ui<-fluidPage(
  selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3)])),
  plotOutput(outputId="hist")
)
server<-function(input, output){
  output$hist <- renderPlot({
	  hist(d[,input$valcont]) #CALLING INPUT DATA
		})
}
shinyApp(ui=ui, server=server)

#within the hist() function, you can include all of the parameters that you would usually use to modify a histogram

ui<-fluidPage(
  selectInput('valcont', 'Pick a Continuous Variable', choice=names(d[,c(2,3)])),
  plotOutput(outputId="hist")
)
server<-function(input, output){
  output$hist <- renderPlot({
		hist(d[,input$valcont], main= paste("Histogram of", input$valcont), xlab=input$valcont, col="Blue") #Note: you can use paste() to combine consistent text with the name of reactive inputs so that the text will change as the user changes the inputs 
		})
}
shinyApp(ui=ui, server=server)

#Challenge q - try writing the server on your own before looking at the answer below








```


