---

title: "R intro (week 0)"
excerpt: "start of QAI"
date: 2024-06-03
lastmod: 2024-06-03 23:08:41 -0400
last_modified_at: 2024-06-03 23:08:41 -0400
categories: R
tags: R introductory statistics
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

<!--postNo: 2024-06-03-->


**QAI Program Week 0. Notebook and lecture from the Quantitative Analysis Institute Summer Program.** 


### Lecture - Basic R commands

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


