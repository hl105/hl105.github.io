---

title: "[QAI] Power, Data Cleaning and Management (Dplyr, tidyR) (week 3)"
excerpt: "notes from week 3"
date: 2024-06-20
lastmod: 2024-07-30 22:34:55 -0400
last_modified_at: 2024-07-30 22:34:55 -0400
categories: stats
tags: qai statistics R Dplyr, tidyR, robustness, power
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


all notes and code from the QAI Program


### Robustness and Power

1. Robustness & Distribution of p-values if null is true
	- def: method works out even if the assumptions aren’t true
	- If the null hypothesis of a test is true, what's the probability that the p-value will be less than 0.05? → 0.05 duh
2. p-values have a **uniform distribution** when the null hypothesis is true
	- better explanation: for a uniform distribution where the values fall between 0 and 1 - which is the case for the distribution of p-values when the null hypothesis is true - the probability of obtaining a number less than (or equal to) x is equal to x.
3. Error types and independence
	- **Type 1 error**: rejecting the null hypothesis when the null hypothesis is true
	- **Type 2 erro**r: Failing to reject the null hypothesis when the null hypothesis is false
	- P**ower**: probability of rejecting the null hypothesis when a particular alternative hypothesis is true
	1. What happens to t-tests when assumptions are false?
		- independece
			1. subgroups of units similar to each other (cluster effect)
			2. units vary over time (serial effect)
			3. units vary across space (spatial effect)
			4. standard error calculations incorrect; more advance calculation needed → need diff method
			5. check: think carefully about hw data was collected; sometimes graphics can help
			6. so t-tests are not robust to the independence assumption
		- normality
			1. similarity of shapes
			2. sample sizes (relative and absolute)
			3. outliers
		- equality of variance
			1. sample sizes (relative and absolute)
	2. a procedure is **robust** to an assumption if it is valid when the assumption is not met
	3. a procedure is **resistant** if it does not change when a small part of the data changes (e.g. outliers)
4. Normality
- 

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393303/telrmin5whpgxsrec3hs.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>

- validity: robustness to normality assumption
- t-tests fairly robust to departures from normality, especially in large samples
- when the sample size are not equally, t-test more sensitive to skewedness and long-tailedness
- for small samples, t-tests somewhat sensitive to markedly different skewedness in two groups
- check: graphics (don’t need tests for normality!) → Q-Q plot straight?
- when assumption violated: t-test usually still valid; or, use non-parametric test; or transform
1. Equal population variances

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393304/j8yenfw0je8kavzsoxp5.png" alt="">
                      <figcaption></figcaption>
                  </figure>

- when sample sizes are equal, the pooled t-test is fairly robust to unequal variances
- when sample sizes are unequal, the pooled t-test is typically not valid for unequal variances, the unpooled “welch” t-test  is a robust alternative
- check: graphics (or, test such as Levene, but then have to make decision based on p-value cutoff) → boxplots
- when assumption violated: pooled t-test, usually valid if sample sizes equal; or, unpooled t-test; or, transform
	- t-tests sensitive to  outliers
	- rank-sum test resistant alternative
	- source of outliers:
		- measurement error
		- wrong population
		- heavy tail
2. Outliers

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393308/bl1ckmqx2yqpd0nzy5ce.png" alt="">
                      <figcaption></figcaption>
                  </figure>


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393310/zkcmjihpzzt4jxmqiur5.png" alt="">
                      <figcaption></figcaption>
                  </figure>

3. small sample size

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393311/vhkal5owbcrv84b3rv6h.png" alt="">
                      <figcaption></figcaption>
                  </figure>


small sample size → use permulation test


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393313/eenly3hunsmr1bmdnfi1.png" alt="">
                      <figcaption></figcaption>
                  </figure>

1. permutation test just cares if the distributions look the same
1. Non-parametric tests
	- Why does the rank sum test lead to p-values less than 5% more than 5% of the time when the populations have equal means but different variances? → null hypothesis is false. The null hypothesis of a t-test is that the means are equal, but the null hypothesis of a non-parametric test like the rank sum is that the distributions are the same, not just the means.
2. Power
	- probability of rejecting the null hypothesis when a specific alternative hypothesis is true
	- in general: power is tied to a specific alternative hypothesis and thus  you need to specify an alternative hypothesis in order to calculate power → The power is the probability that your test will correctly notice when the null is not true. You are much more likely to notice if the truth is very far from the null than if the truth is close to the null. For example, in a two-sample t-test, the null hypothesis is that the difference in population means is zero. Assume for a moment that the two populations both have variance 1, and consider two samples of size 100. If the true difference is not zero but 400 billion, you will certainly get a tiny p-value and correctly reject the null, right? But if the true difference is .0000001, you will definitely not end up with a data set that allows you to rule out the possibility that the true difference is zero.
	- tests are more powerful when sample sizes are larger
	- non-parametric test are somewhat less powerful than t-tests, when normality assumptions met bc knowing normality of distribution gives you more information

### Log transformations for t-tests

1. Why use log transformations & Interpreting a diff in mean logs on the original scale
	- we want to use our data to look more normal to better support the methods we use
	- Any time data consists of times / distance/ money / positive values, it’s likely that the histogram of the values is skewed to the right.
	- Take log! Will look approximately normal now

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722393321/c6jaarhig5tkdiweki4d.png" alt="">
                      <figcaption></figcaption>
                  </figure>

1. how do I interpret original value from log?
	- $D = mean(log(x)) - mean(log(y)) \sim median(log(x)) - median(log(y)) = log(median(x)) - log(median(y)) = log(\frac{med(x)}{med(y)})$
	- $e^{log(\frac{med(x)}{med(y)}} = e^D$, so $\frac{med(x)}{med(y)} = e^D$
	- this is how we got from log scale D back to original scale medians
1. Interpreting a confidence interval for the difference in mean logs, on the original scale
	- $P(LB < mean(log(x)) - mean(log(y)) < UB) = 0.95$
	- $P(e^{LB} < \frac{med(x)}{med(y)} < e^{UB}) = 0.95$

### Data Cleaning and Management


```r
getwd()
setwd("Documents/")

install.packages("foreign")
library(foreign)


summary(brfss$BLDSUGAR)
table(is.na(brfss$BLDSUGAR)) 

# how to add new empty column
brfss$timesperyr=rep(NA, nrow(brfss))

# Set don't know and refused to NA
brfss$timesperyr[brfss$BLDSUGAR==777]=NA
brfss$timesperyr[brfss$BLDSUGAR==999]=NA

brfss$DKorRefused<-ifelse(brfss$BLDSUGAR==777 | brfss$BLDSUGAR==999, 1, 0)

# If responded "never", set new variable to zero
brfss$timesperyr[!is.na(brfss$BLDSUGAR) & brfss$BLDSUGAR==888]=0


# If number between 401 and 499, already in terms of times per year, but have to subtract 400
brfss$timesperyr[!is.na(brfss$BLDSUGAR) &
		 brfss$BLDSUGAR>400 & brfss$BLDSUGAR<500]= brfss$BLDSUGAR[!is.na(brfss$BLDSUGAR) & 
						brfss$BLDSUGAR>400 & brfss$BLDSUGAR<500]-400
table(brfss$timesperyr)		


# Types of variables: numeric, character, factor, date,...
class(brfss$timesperyr)
is.numeric(brfss$timesperyr)
is.numeric(brfss$EmployClean)
class(brfss$EmployClean)
is.character(brfss$EmployClean)

brfss$EmployCleanFactor=as.factor(brfss$EmployClean)
is.factor(brfss$EmployCleanFactor)

#date object
brfss$newdate<-as.Date(brfss$IDATE, "%m%d%Y")

# Multiple ways to create small data set containing only the variables you care about
# If the desired variables are part of the data set:
subset<-brfss[,c("newdate","timesperyr","DKorRefused","EmployCleanFactor")]

# If the desired variables are not necessarily part of the data set, combine vectors as below
# For example, suppose I create a variable but don't include it in the data set
TimesPerYrHigh<-ifelse(brfss$timesperyr>2000,1,0)
subset<-data.frame(TimesPerYrHigh, brfss$timesperyr)
# to create a matrix, rather than a data set:
subset<-cbind(TimesPerYrHigh, brfss$timesperyr)

#To write multiple variables to a spreadsheet, the variables need to be part of the same data frame or matrix object
write.csv(subset, file=paste(filepath,"SubsetData.csv",sep=""))


# Other R Commands

# the "by" command does something to a variable, in groups based on another variable
by(brfss$timesperyr, brfss$EmployCleanFactor, mean)
 

# the "merge" command combines multiple data sets with a variable in common.

```


_**Factor variables**_ are _**categorical variables**_ that can be either numeric or string _**variables**_.


Missing Data


```r
tiny = read.csv(file="MissingData.csv", header=TRUE)
summary(tiny)
is.na(tiny)
#when there are values that R doesn't recognizes as missing
editedtiny=read.csv(file="MissingData.csv", header=TRUE, na.strings=c("NaN", "NA", "N/A", "-999", ""))

```


Dates


```r
# Creates a combined birthday in Month Day Year format (combine multiple columns)
combined = with(small, paste(Month.of.Birth, Day.of.Birth, Year.of.Birth))
small["Full.Birthday"] = combined

# Creates a numerical birthday
BirthdayNum <- as.Date(small$"Full.Birthday", format='%B %d %Y')

# If you had the dates in a different format
# %d - day of the month (number)
# %m - month (number)
# %b - month (3 letter abbreviation)
# %B - month (full name)
# %y - year (2 digit)
# %Y - year (4 digit)

# Examples with different formats of the same date
as.Date("Oct 15 14", format='%b %d %y')
as.Date("October 15th, 2014", format='%B %dth, %Y')
as.Date("10/15/14", format='%m/%d/%y')
as.Date("15/10/2014", format='%d/%m/%Y')
as.Date("10.15.14", format='%m.%d.%y')

# Special note for months (and days) that are single digits
as.Date("02012011", format='%m%d%Y')
as.Date("212011", format='%m%d%Y')
as.Date("2.1.2011", format='%m.%d.%Y')

# R internally keeps track of dates as "days since 01/01/1970" with negative numbers for dates that occurred prior to 01/01/1970
# Can convert the output to this internal form
as.numeric(as.Date("2.1.1970", format='%m.%d.%Y'))

# Gets today's date in the same YYYY-MM-DD format as BirthdayNum
today <- Sys.Date()

# Package called lubridate is helpful when manipulating dates
install.packages("lubridate")
library("lubridate")


# Can see what day of the week it is today
wday(today, label = TRUE)

# Can see what day of the week people were born on
weekdayOfBirth <- wday(BirthdayNum, label = TRUE)

# Create an interval between 2 dates
int <- interval(BirthdayNum, today)

# Converts the interval into a period (age in years, months, days, hours, minutes, and seconds)
wholeAge <- as.period(int)

# Obtain the years of age from the whole age
ageYears <- wholeAge$year

# Adds the whole age birthday to the data frame
small["Age"] <- ageYears

# Can see the difference in the way that birthdays and ages are stored when they are plotted
par(las=1)
plot(BirthdayNum, ageYears,
	xlab="Calendar Birthday",
	ylab="Age in Years")
```


### Reshaping and Manipulating Data (Tidyverse)

1. Introduction to Dplyr

```r
#Tibbles are data frames in R with unique printing and subsetting defaults, which are useful when working with large datasets. 
health <- as_tibble(ad_health)
names(health)
names(health) <- c("ISO", "Location", "Year", "Source", "Indicator", "Age", "Value", "Description", "Reference Period", "Notes")
summary(health) 

#Dplyr is a helpful data manipulation package with five main functions: filter, select, arrange, mutate, and summarise 

# 1.) Filter  
# Filter is used to view a particular subset of the data 

# Example: 
# View the percentage of women, between the ages of 18 to 19 years old, in Albania who received antenatal care 

# Original R 
health[health$Age=="18-19 yrs" & health$Location=="Albania" & health$Indicator =="ANC_1T"  |health$Age=="18-19 yrs" & health$Location=="Albania" & health$Indicator == "ANC1" | health$Age=="18-19 yrs" & health$Location=="Albania" & health$Indicator == "ANC4" | health$Age=="18-19 yrs" & health$Location=="Albania" & health$Indicator == "ANC8", ]

# Dplyr   
health %>% #read as "then"
		filter(Age == "18-19 yrs", Location == "Albania", Indicator == "ANC_1T" | Indicator=="ANC1" | 	Indicator == "ANC4" | Indicator == "ANC8")
# does not replace original df, assign to new var



# 2.) Select 
# Select allows you to view only columns of interest in a dataset 

# Example: 
# View only the location, indicator, and year columns of the health dataset 

# Original R 
health[,c("Location", "Year", "Indicator")]

# Dplyr 
health %>% 
		select(Location, Year, Indicator)
 
#More functionality with "select" in Dplyr 
# a.) Select allows you to view columns in a sequence 

# Example: 
# View all of the columns between Location and Value in the health dataset, except the one named Source 
health %>% 
		select(Location:Value) %>% 
		select(-Source)

# b.) Select also allows you to view columns with a specific word in the title 
health %>% 
		select(contains("Indicator"))		
		
# Example: Combining Filter & Select 
# View only locations where the percentage of females who use contraceptives is greater than 20 

# Original R 
health[health$Indicator=="CPMODHS" & health$Value > 20, c("Location", "Year", "Indicator", "Value")]

# Dplyr 
health %>% 
	select(Location, Year, Indicator, Value) %>% 
	filter(Indicator == "CPMODHS", Value > 20)
```

1. Introduction to TidyR

```r
#TidyR is a helpful data reshaping package with four main functions: spread , gather, unite, and separate 

# 1.) Spread 
# Spread is a useful function for widening long data. Spread is used to convert two columns into multiple columns. The spread function is formatted as so: 
# spread(data, key, value) where key is defined as the column whose values will be used as the column headings and value as the values you wish to populate the new cells. 
#h_spread <- health %>% spread(Indicator, Value)
# A very common error while using spread is: "Each row of output must be identified by a unique combination of keys". If this error appears, we must first group the dataset by our key as in the following example. 

#Example: 
# Create new columns based on each indicator variable. Our key column will be "Indicator" and our value column will be "Value". 
# Firstly, create a subset of the data that only includes the columns of Location, Year, Indicator, and Value 

sub_health <- health %>% 
		select(Location, Year, Indicator, Value)

h <- sub_health%>% 
	group_by(Indicator) %>% 
	mutate(grouped_id = row_number()) %>%  # create new variable called grouped_id
	spread(Indicator, Value) %>% 
	select(-grouped_id)

# Next, rename the columns 	
names(h)		
names(h) <- c("Location", "Year","First Ante.Vis.", "Blood", "BP", "Urine", "1 < Ante.Vis.", "4 < Ante.Vis.", "8 < Ante.Vis.", "Disease.Care", "Diarrhoea", "Fever", "Pneumonia", "Contraceptive", "C.Section", "Family.Plan", "Institutional.Delivery", "Malaria.Treat", "Net.Children", "Net.Women", "Malaria.Test", "Salts", "Salts&Zinc", "Post.Care.Baby", "Post.Care.Mom", "Delivery.Attendent.Inst.", "Delivery.Attendent", "Tobacco")
names(h)
dim(h)
print(as_tibble(h), n=30)

# Renaming columns using dplyr
new_data <- data %>%
  rename(id = student_id,
         name = student_name,
         subject = class)


# 2.) Gather 
# Gather is a useful function for elongating wide data. 

#Example: 
# Merge the columns that contain information regarding a woman seeking care for a specific disease. This includes columns Diarrhoea through Pneumonia 
health_Dis <- h %>% 
	group_by(Location) %>% 
	select(Location, Diarrhoea:Pneumonia) %>% 
	gather(Disease, Val, Diarrhoea:Pneumonia) %>% #gather diarrhoe:pneumonia into disease, val col
	print( n=50)
	
	

# 3.) Unite 
# Unite allows you to paste together multiple columns into one 

# Example: 
# Paste together the columns that contain information regarding the study location, which includes columns "ISO" and "Location" in the health dataset 
health_Un <- health %>% 
				unite(Loc., ISO, Location, sep = ",") %>% 
				print( n=30)				
						
# 4.) Separate 
# Separate allows you to turn a single character column into multiple columns 

# Example: 
# Revert the Loc. column from the previous example back to separate columns for ISO, ie. country/area abbreviations, and location name				
health_Sep <- health_Un %>% 
				separate(Loc., c("ISO", "Location"), sep = ",") %>% 
				print( n=30)

```


using Dplyr with our Cleaned Dataset


```r
# Now that we have created new variables for each indicator, we can more easily view important sections of our dataset

# 1.) Filter 

#Example:
# View the locations surveyed in 2015 who reported more than 10% of women being tested for malaria 

h %>% 
		filter(Year == "2015", Malaria.Test > 10)

# 2.) Select 
# View only the location, year, and tobacco use 

h%>% 
	select(Location, Year, Tobacco)

# Example: Combining Filter & Select 
# View only locations where the percentage of females who use contraceptives is greater than 20 
	
h %>% 
	select(Location, Year, Contraceptive) %>%
	filter(Contraceptive > 20)	

# OR 

h %>% 
	filter(Contraceptive > 20) %>% 
	select(Location, Year, Contraceptive )	

# 3.) Arrange 

# Example:
# Sort location by the percentage of women who gave birth in an institution. Sort this from lowest to highest percentage of women.  

h %>% 
	select(Location, Year, Institutional.Delivery) %>% 
	arrange(Institutional.Delivery)	

# OR 

h %>% 
	arrange(Institutional.Delivery) %>% 
	select(Location, Year, Institutional.Delivery)

# Example: 
# Sort location by the percentage of women who had a skilled attendant for her institutional delivery. Sort this from highest to lowest percentage of women.
 
h %>% 
 	select(Location, Year, Delivery.Attendent.Inst.) %>% 
 	arrange(desc(Delivery.Attendent.Inst.))

# 4.) Mutate 
# Mutate allows you to add new variables to a dataset 

# Example: 
# Create a new variable that shows a ratio of the percentage of children who used mosquito nets to the percentage of women who used mosquito nets 

# Original R 
h_rat <- h[,]
h_rat$Ratio <- h$Net.Children / h$Net.Women 
h_rat[,c("Location", "Net.Women", "Net.Children", "Ratio")] 

# Dplyr 
h %>%
	select(Location, Net.Women, Net.Children) %>% 
	mutate(Ratio = Net.Children/Net.Women) 	

# Note, the order of operations matters when using the verb mutate. Notice, the variable "Ratio" would not print in this scenario. 
	
h %>%
	mutate(Ratio = Net.Children/Net.Women) %>%
	select(Location, Net.Women, Net.Children) 
	

# 5.) Summarise  
# Summarise allows you to compute a summary statistic, such as mean, for each group in a dataset 

# Example: 
# Compute the average percent of women surveyed in each location who use tobacco 

# Original R 
h_sum <- h[,]
head(with(h_sum, tapply(Tobacco, Location, mean, na.rm=TRUE)))
head(aggregate(Tobacco ~ Location, h_sum, mean), n=4)

# Dplyr 
h %>% 
	group_by(Location) %>% 
	summarise(avg_tob = mean(Tobacco, na.rm=TRUE)) %>% 
	print(n=4)

# Note, the order of operations matters when using the verb summarise. Notice, the variable "Location" would not exist in the code below. In this case, we would be calculating a single mean value for the percentage of women surveyed who use tobacco. 

h %>% 
	summarise(avg_tob = mean(Tobacco, na.rm=TRUE)) %>% 
 	group_by(Location)  

# 6.) Group By 
# Group by allows you to perform operations on data that are grouped based on a certain variable 

# Example: 
# Compute the average percent of women surveyed in each location who use tobacco 
h %>% 
	group_by(Location) %>% 
	summarise(avg_tob = mean(Tobacco, na.rm=TRUE)) %>% 
	print(n=4)
```


```r
hnew<-h%>%
  mutate(across(everything(), ~replace(., is.na(.),0)))
tail(hnew)


CPS %>%
  summarise(across(c(wage, educ, exper, age), mean))
```


```r
df_2020_county = df_2020 %>%
  group_by(county_name,state_po,party) %>%
  mutate(id=row_number()) %>% # adds a new column id that serves as a unique identifier for each row within each group.
  spread(party,candidatevotes) %>% #  takes key-value pairs and spreads them
  select(-id) 
```

- there are multiple rows for the same `party` within a single group (i.e., multiple vote counts for the same party in the same county and state), `spread()` won't know how to handle multiple values for the same key in a single group. It requires each combination of key columns and groups to be unique.
- **Ensuring Uniqueness**: By adding an `id` column that assigns a unique row number to each entry within the groups, you essentially make each row unique even if the `party` and vote counts are the same.

