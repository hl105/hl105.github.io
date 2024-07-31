---

title: "[QAI] splines, trees, linear regression, significance (week 4)"
excerpt: "notes from week 4"
date: 2024-07-12
lastmod: 2024-07-30 22:53:17 -0400
last_modified_at: 2024-07-30 22:53:17 -0400
categories: R
tags: QAI splines trees linear_regression significance
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

<!--postNo: 2024-07-12-->


all notes from week 4


### Non-Parametic Models: Splines

- def: piecewise polynomials going through given data points and satisfying certain continuity conditions
- need to be careful about overfitting
- user provides x and y vectors
- spline-fitting interpolates, using straight lines, polynomials, or other curves
- model for the mean:
	- Units with the same value of X will have various values of Y
	- We predict the mean of the values of Y for units who share a value of X
	- Regression/ANOVA is a parametric model for the mean
- if there is really is a linear relationship between X and Y, the tree will try to approximate it with a bunch of horizontal line segments

### Regression Trees

- def: specific type of decision tree used for regression tasks, where the target variable is continuous
- residual: diff between true y and predicted

### Connecting splines, tree, and linear regression

one overall equation for multiple predictors

- mean(y\| x, w) = $\beta_0+\beta_1x+\beta_2w+\beta_3xw$. Last term is **interaction**
- interaction:
	- relationship between x and mean might depend on w.
	- when the effector fo one predictor on outcome depends on another predictor
	- when w=0: mean = $\beta_0 + \beta_1x$
	- when w=1: mean = $(\beta_0 + \beta_2)+ (\beta_1+\beta_3)x$
	- so a no interaction model is a special case of th model that includes an interaction where $\beta_3=0$
- no interaction: when the effect of one predictor on outcome is independent of the other predictor
	- mean(y\|x,w) = $\beta_0 + \beta_1x+\beta_2w$
	- when w=0: mean = $\beta_0+\beta_1x$
	- when w=1: mean = $(\beta_0+\beta_2)+\beta_1x$

### Intro to linear regression

1. models to compare — parametric models
	- equal means model:
		- mean(y\|x) = some number.
		- For any value of x, predict that mean(y) is equal to the observed overall mean

			<figure>
			                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722394448/fqxxfve3mo3n3kfqldp3.png" alt="">
			                      <figcaption></figcaption>
			                  </figure>

	- separate means model
		- predicts the mean of y that was observed in each group based on x

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722394449/vwdpix39diklafesa0uf.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

	- linear regression model:
		- combination of these two
		- mean(y\|x) = ax+b

			<figure>
			                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722394451/g21588iuf7xwjc7d0a6t.png" alt="">
			                      <figcaption></figcaption>
			                  </figure>

2. linear regression assumptions
	- linearity:
		- equation relating mean(y) to predictors is correct.
		- This is cruciual, and is usually not true.
		- This doesn’t mean the plot has to be a line! e.g. mean(y|x) = a+bx+cx^2 → linearity assumption holds since the equation  to relate the predictor, the mean of the outcome, is true.
	- independence
		- within and between subgroups based on x
		- one datapoint doesn’t tell us anything about other points
	- normality
		- of y-values for each subgroup based on X

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722394455/rjccy74085dyr641vbxj.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

		- residuals = actual y - predicted y
		- thus residual assumed to be normal
		- p-values, confidence interval, predictions are robust to normality assumption (exception coming)
	- equal variance
		- of y-values within each subgroup based on x

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722394457/iquxdflei56bnqwbugnr.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

		- also known as homoskedasticy
		- required for p-values, CI to be correct
3. Putting it all together
	- $mean(Y\|X) = \beta_0+\beta_1X$
	- $[Y_i\|X_i] \sim N(\beta_0+\beta_1X_1, \sigma^2)$

### Practical vs. Statistical Significance 

- look at the t statisic equation. depends on n, the sample size. If it’s big, we’ll get a bigger t statistic.
- You can’t make decisions only on p-values, if there’s a big difference between groups, you should try collecting more data and see if it holds. If there’s a tiny difference, maybe you’re getting statistical difference only because you collected a lot of data.
- For a particular study, we expect that larger sample size will lead to bigger t-statistic and smaller p-value

