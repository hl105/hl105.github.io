---

title: "[QAI] ANOVA & Regression (week 7)"
excerpt: "notes from week 7"
date: 2024-07-14
lastmod: 2024-07-30 23:40:19 -0400
last_modified_at: 2024-07-30 23:40:19 -0400
categories: R
tags: QAI statistics R ANOVA regression
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


all notes from QAI


Regression and ANOVA are different ways of formatting output from the same model


### One predictor, categorical or continuous


```r
#data cleaning

attach(msleep)

plot(bodywt, sleep_total)
plot(bodywt, log(sleep_total))
plot(log(bodywt), log(sleep_total))
plot(log(bodywt), log(sleep_total),
	col=as.factor(vore))
	
logwt<-log(bodywt)	
logsleep<-log(sleep_total)
vore<-as.factor(vore)
	
boxplot(logsleep~vore)

summary(vore)

levels(vore)
levels(vore)<-c(levels(vore),"missing")
vore[is.na(vore)]<-"missing"

summary(vore)

boxplot(logsleep~vore)
```


Q: How did we handle the missingness on the variable called "vore"?


A: Creating a factor level called "missing." Especially when the variable is already a categorical variable, creating a category for missing values is a straightforward, assumption-free way to move forward with the analysis without dropping any rows that are missing on that variable. This method ignores any information in the rest of the data about best guesses at those missing values, though, as well as what you know from the context about how the pattern of missingness relates to the missing values.


```r
### Model 1: logsleep by vore

# Calculate means of logwt by vore
by(logsleep,vore,mean)

#### Run ANOVA of logsleep by vore
boxplot(logsleep~vore,ylim=c(0,3))
m1.aov<-aov(logsleep~vore)
summary(m1.aov)
plot(m1.aov$fitted.values, m1.aov$resid)
abline(h=0)
m1.aov$fitted.values
temp<-data.frame(vore,round(cbind(logsleep, m1.aov$fitted.values, m1.aov$resid),3))
colnames(temp)<-c("vore","logsleep","fitted","resid")
temp

SSR.1<-sum(m1.aov$resid^2)
SSR.1
SST.1<-sum((logsleep-mean(logsleep))^2)
SSM.1<-SST.1-SSR.1
SSM.1

#### Run regression of logsleep by vore
plot(vore, logsleep, ylim=c(0,3))
m1.lm<-lm(logsleep~vore)
summary(m1.lm)

summary(m1.lm$resid)

plot(m1.lm$fitted.values, m1.lm$resid)
abline(h=0)
cbind(m1.aov$fitted.values, m1.lm$fitted.values)
identical(m1.aov$resid,m1.lm$resid)

m1.lm$coef
m1.aov$coef

by(logsleep,vore,mean)

summary(m1.aov$resid)

summary(m1.aov)
anova(m1.lm)

# confirm residual standard error
MSE<-SSR.1/78
sqrt(MSE)
# confirm R^2
SSM.1/SST.1
1-SSR.1/SST.1
# confirm adjusted R^2
1-(SSR.1/78)/(SST.1/82)

```


```r
### Model 2: logsleep by logwt

plot(logwt,logsleep)
boxplot(logsleep~logwt)
table(round(logwt))
boxplot(logsleep~round(logwt))

plot(logwt,logsleep)


#### Run regression of logsleep by logwt
m2.lm<-lm(logsleep~logwt)
summary(m2.lm)
plot(m2.lm$fitted.values, m2.lm$resid)
abline(h=0)

plot(logwt,logsleep)
abline(m2.lm)

#### Run ANOVA of logsleep by logwt
m2.aov<-aov(logsleep~logwt)
summary(m2.aov)
plot(m2.aov$fitted.values, m2.aov$resid)
abline(h=0)


SSR.2<-sum(m2.lm$resid^2)
SSR.2
SST.2<-sum((logsleep-mean(logsleep))^2)
SSM.2<-SST.2-SSR.2
SSM.2

(-7.388)^2

m2.lm$coef
m2.aov$coef
```


**Q: If you run an ANOVA, what is the fitted value of logsleep for the group herbivore?**


A: The mean value of logsleep observed for the herbivore group.


**Q: How do you get the SSR from an ANOVA output if the ANOVA model is named m1?**


A: sum(m1$resid^2)


**Q: Which of the following is the Mean Square Error in ANOVA?**


A: Sum of Squared Residuals / Residual degrees of freedom


**Q:  For a linear model with more than one coefficient specified, what does the p-value for each coefficient show?**


A: The p-value for a particular coefficient is the result of a test comparing (i) the actual model that you ran with (ii) the same model with that particular term omitted.


**Q: What does the bottom row output of the summary for the linear model “lm” show?**


A: The bottom row summarizes an F-test comparing the entire model you specified to the equal means model.


**Q:  What is the residual standard error?**


A: SquareRoot(SSR/degrees of freedom)


**Q: Check all that equal to SSM/SST:**


A: R-Squared , 1-SSR/SST


**Q: Suppose that the rows in your data set are US counties, and your outcome variable is the total number of people in each county who vote in an election. If your predictor variable is the state in which each county is located, and your research question is whether voting varies across states, which type of output would you rather see?**


A: ANOVA. The ANOVA table will provide **one p-value for the entire categorical state variable**, reporting the results of an F-test that compares the equal means model to the model that predicts a separate mean for each state. The default regression output might report the results of the same F-test as an afterthought at the bottom of the output, but the regression output focuses on the separate coefficients for each state.


**Q:  In the same context as the previous problem, if you are interested in which states have the highest and lowest numbers of voters, which type of output would you rather see?**


A: Regression output. The ANOVA output will evaluate whether the state variable as a whole is useful for predicting vote counts, but the ANOVA table will not report which states have higher or lower vote counts. The regression output, though, includes the estimated coefficients for each state (except for one baseline state), so that you can assess which states have higher or lower predicted values. **Each p-value in the regression output** compares the model where every state has a different mean vote count to the model where every state has a different mean vote count, except that the state associated with that p-value has the same mean vote count as the baseline state. This may not be a particularly interesting test!


```r
### Model 3: logsleep by logwt and vore

plot(logwt, logsleep,
	col=as.factor(vore))
boxplot(logsleep~round(logwt)+vore)

#### Run ANOVA of logsleep by vore and logwt
m3.aov<-aov(logsleep~vore+logwt)
summary(m3.aov)
plot(m3.aov$fitted.values, m3.aov$resid)
abline(h=0)

SSR.3<-sum(m3.aov$resid^2)
SSR.3
SST.3<-sum((logsleep-mean(logsleep))^2)
SSM.3<-SST.3-SSR.3
SSM.3

#### Run regression of logsleep by vore and logwt
m3.lm<-lm(logsleep~vore+logwt)
summary(m3.lm)
plot(m3.lm$fitted.values, m3.lm$resid)
abline(h=0)

# confirm residual standard error
sqrt(SSR.3/77)
# confirm R^2
SSM.3/SST.3
1-SSR.3/SST.3
# confirm adjusted R^2
1-(SSR.3/77)/(SST.3/82)

# F-test shown in regression output no longer equivalent to F-tests in ANOVA output
# but:
(-7.633)^2

cbind(m3.lm$fitted.values, m3.aov$fitted.values)
```


**Q: When there are multiple predictors in the model, can you use the residuals to directly calculate the sum of squared residuals?**


A: Yes. The sum of squared residuals is always literally the sum of the squared residuals. Note that the residuals themselves change when we add terms to the model, because the fitted values change.


**Q: You are trying to predict a student's GPA using the sports that a student plays as a categorical variable. You think that some sports have a greater impact than others on a student's GPA. For example, you think that playing basketball has a larger impact on a student's GPA than playing field hockey. If you want to test this assumption, and if your research question is about trying to come up with a model that might include some of the possible sports but not all of them in one categorical variable, which model output should you look at?**


A: Linear regression. ANOVA will not show the coefficients or significance of individual sports, only a test for the overall correlation of the categorical sport variable with GPA.


**Q: If you are trying to decide whether you should include the categorical variable of a Wellesley student's major in a model determining the student's future median income, which output’s default would be most useful to the test whether the student's major is an important predictor?**


A: ANOVA. In this case, we are interested in whether the variable as a whole matters, not in comparing specific majors to each other.


**Q: When you have multiple predictors, is the F-test shown at the bottom of the Linear Regression output also in the output of the ANOVA?**


A: . The F-test in the Linear Regression output compares the entire model to equal means model, while the tests shown in ANOVA table examine each variable individually.


### Categorical vs. continous


```r
### Categorical v. continuous variables

# Continuous variable - mistake to handle as categorical

summary(sleep_rem) # some missingness, for this section allow rows to drop
boxplot(sleep_rem)
plot(sleep_rem, logsleep)

summary(lm(logsleep~sleep_rem))
summary(aov(logsleep~sleep_rem))

boxplot(logsleep~as.factor(sleep_rem))

summary(lm(logsleep~as.factor(sleep_rem)))
summary(aov(logsleep~as.factor(sleep_rem)))

# Categorical variable - mistake to handle as continuous

voreAsNum<-as.numeric(vore)
table(voreAsNum)
summary(voreAsNum)
summary(vore)
table(vore,voreAsNum)

summary(lm(logsleep~voreAsNum))
summary(aov(logsleep~voreAsNum))

plot(voreAsNum,logsleep)
abline(lm(logsleep~voreAsNum))

```
### Q&A Section 

**Q: What is one way to tell that we incorrectly handled a continuous variable as a factor or categorical in an ANOVA?**


A: The degrees of freedom is not 1. A continuous variable will have a degrees of freedom of 1. On the other hand, if your categorical variable has more than one category and the degrees of freedom is shown to be 1, then you will know that the variable was incorrectly treated as continuous.


**Q: Suppose you are trying to predict height and your model includes a variable for the length of an individual's left foot and a variable for the length of an individual's right foot. When you run a linear regression on this model, which of the following tests will likely be significant? Check all that apply.**


A: The F-test at the bottom of the linear output will be significant because the model you are testing is more appropriate than the equal means model. However, the t-test associated with the left foot coefficient compares a model with only the right foot to the model with both feet - the feet are very correlated, so the right foot is good enough, and the p-value is large. The t-test associated with the right foot coefficient compares a model with only the left foot to the model with both feet - the left foot is good enough, and so the p-value is large. **When you put two correlated variables in a model as predictors, the individual p-values for the coefficients will not be significant, because a model that only includes the other predictor is fine.** However, these large p-values do not imply that the information in these variables is not important. Either left foot or right foot would be significant if only one of them is included in the model.


**Q: Would it be sufficient to run a linear regression with several predictors and then omit the variables that are not significant?**


A: No, the variables that are not significant could be important, but perhaps they are correlated with other predictors that you included in the model.


**Q: Consider two predictor variables that, individually, would be significant for predicting an outcome variable. These predictor variables are highly correlated with one another. What will we see from an ANOVA output when we run, in one model, these two variables as predictors for the outcome variable?**


A: The variable specified first would be significant and the variable specified second would not be significant. The default in R is that order matters in an ANOVA output. Therefore, the variable specified first will be statistically significant.


**Q: Given the msleep data, suppose that you run a linear model to predict logsleep. You specify the predictors logwt and vore, in that order, with no interaction. Which of the following tests will be reported as part of the default regression output, in R?**


A: 

- Comparison between equal means model and model that includes logwt and vore
- Comparison between model that includes both logwt and vore, and model that includes only vore
- Comparison between model that includes both logwt and vore, and model that includes both logwt and vore but assumes that herbivores have the same mean log sleep as the baseline vore (say, carnivores)

**Q: which of the following tests will be reported as part of the default ANOVA output, in R?**


A: Comparison between model that includes both logwt and vore, and model that includes only logwt:  is the test in the row labeled "vore" in the ANOVA output. There is no such row in the regression output, because separate tests for the coefficients of each level of the categorical variable (except for one baseline level) are shown on different rows.


<wrong answers>

- Comparison between equal means model and model that includes logwt and vore: the F-test shown at the bottom row of the regression output. If there is only one predictor, the bottom row of the regression output shows the same F-test that is shown in the corresponding ANOVA table. If there are multiple predictors, the bottom row of the regression output shows an F-test that is not equivalent to anything shown in the default ANOVA table.
- Comparison between model that includes both logwt and vore, and model that includes only vore:  is the test in the row labeled "logwt" in the regression output. This test actually does not appear in the ANOVA if the predictors are specified in the order given here, but it would have if the predictors had been specified in the opposite order
- Comparison between model that includes both logwt and vore, and model that includes both logwt and vore but assumes that herbivores have the same mean log sleep as the baseline vore (say, carnivores):  is the test in the row labeled "herbi" in the regression output. There is no such row in the ANOVA table, because the ANOVA reports tests of the entire categorical variable rather than coefficients for specific levels of the categorical variable.

Q: For which of the types of R output does the order of the predictors determine the tests that are reported?


A: ANOVA. The regression output will always show the results of tests comparing the entire model, to the entire model without each predictor. R's default ANOVA output will built up the predictors one by one, testing whether the first predictor alone is better than the equal means model; whether the first two predictors together are better than the first predictor alone; whether the first three predictors together are better than the first two predictors together; etc. Though it seems strange that the output would depend on the variable order, the tests shown in this ANOVA output are more likely to show us whether we have important predictors in the data set. If two predictors are highly correlated with each other and with the outcome, the tests shown in the linear model for each of the predictors may not be significant, because including just one of the two predictors is sufficient (aka "multicollinearity").


