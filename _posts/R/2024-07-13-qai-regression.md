---

title: "[QAI] Regression"
excerpt: "notes from week 5"
date: 2024-07-13
lastmod: 2024-07-30 23:21:10 -0400
last_modified_at: 2024-07-30 23:21:10 -0400
categories: R
tags: QAI regression
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


### Estimating regression coefficients 


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396076/azqfjamvnt3c6iu2qrob.png" alt="">
                      <figcaption></figcaption>
                  </figure>


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396077/sck6qts6xnehf93mimgg.png" alt="">
                      <figcaption></figcaption>
                  </figure>


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396078/p2psjxg25zse3qowedy2.png" alt="">
                      <figcaption></figcaption>
                  </figure>

1. Measuring the relationship between two variables: estimating $\beta_1$

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396080/bvt8yomoowa7y6fixakk.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>

2. Using correlation to estimate slope
	- r = sample corrleation
	- $\hat\beta_1 = r\frac{s_y}{s_x}$ : the estimated slope of a linear regression line is just a version of counting the number of points in each quadrant

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396082/crcjtcim2dwfrcrmgwvr.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

3. Justifying slope estimate as standardized correlation
4. 

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396084/uftg75kea10ffi2gxl5u.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>

	- If $x_i = \frac{x_i-\bar{x}}{s_x}$ and $y_i= \frac{y_i-\bar{y}}{s_y}$, the slope of the regression line connected these standardized versions will be equal to the sample correlation r.  (bc we are creating versions of orginal variaables with s.d. 1)
	- ex)  If you calculate that sample correlation between income (in dollars) and age (in years) is 0.5 (making this up), and then you decide to report income in terms of thousands of dollars and recalculate, what will the sample correlation be equal to? → 0.5. The sample correlation does not change if you multiple on of the variables by a constant.
5. Residuals
	- equal means model: subtract the same mean
	- sepaerate mean model:subtract the means of each group
6. Justifying slope estimate by minimizing sums of squared residuals
	- $\beta_1 = \frac{\sum_{i=1}^{n} (Y_i - \bar{Y})(X_i - \bar{X})}{\sum_{i=1}^{n} (X_i - \bar{X})^2}$
	- $\text{SSR} = \sum_{i=1}^{n} \left( y_i - (\beta_0 + \beta_1 x_i) \right)^2$, we want to minimze this
	- $\hat{Y} = \hat{\beta}_0 + \hat{\beta}_1 \bar{X}$, plugging everything in, we can estimate the slope
7. Justifying slope estimate by noticing that it is unbiased
	- so far, we’ve been talking about one dataset. But if our model ( the line) is true, the dataset is one of many that could have been generated.
	- you can repeatedly drawm samples of y for each x, and get estimates of  beta_0 and beta_1 → create a distribution of those estimates →  the average would be ur true beta_0 and beta_1
	- ex)  Consider the following simulation. We choose the following model for the mean: Mean(Y|X) = 2+3*X. We set the sample size to n=3, with X values 1, 2, and 3. Then, repeatedly, we simulate the values of Y for these three data points by calculating Mean(Y|X) and adding (standard normal, independent) noise. For each simulated set of Y's, we estimate the slope of the regression of Y on X. We do this 1000 times, generating 1000 estimated slopes. What do we expect to see as the mean of these 1000 estimated slopes? →  3, which is the true slope of the line. This is the definition of unbiasedness: the average of our estimates over all possible data sets drawn from a certain model is equal to the true slope in the model.
	1. Maximum Likelihood Estimate
		- says: use the estimates that make the data minimally suprising,
	2. Weighted average of slopes
		- 

		$$ \beta_1 = \frac{\sum_{i=1}^{n} (Y_i - \bar{Y})(X_i - \bar{X})}{\sum_{i=1}^{n} (X_i - \bar{X})^2}= \frac{1}{\sum_{i=1}^{n} (X_i - \bar{X})^2} \sum_{i=1}^{n} (Y_i - \bar{Y})(X_i - \bar{X})= \sum_{i=1}^{n} \frac{1}{\sum_{i=1}^{n} (X_i - \bar{X})^2} (Y_i - \bar{Y})(X_i - \bar{X})= \sum_{i=1}^{n} \frac{(Y_i - \bar{Y})(X_i - \bar{X})}{\sum_{i=1}^{n} (X_i - \bar{X})^2}= \sum_{i=1}^{n} \frac{(Y_i - \bar{Y})(X_i - \bar{X})(X_i - \bar{X})}{(X_i - \bar{X}) \sum_{i=1}^{n} (X_i - \bar{X})^2}= \sum_{i=1}^{n} \frac{(Y_i - \bar{Y})(X_i - \bar{X})^2}{(X_i - \bar{X}) \sum_{i=1}^{n} (X_i - \bar{X})^2}= \sum_{i=1}^{n} \left( \frac{(Y_i - \bar{Y})(X_i - \bar{X})^2}{(X_i - \bar{X}) \sum_{i=1}^{n} (X_i - \bar{X})^2} \right) $$

		- you can see something “slope-like” at the end. think of the other part as a “weight” of the slope. The further x_i is from the x_bar, the bigger the value would be → the points that have x’s that are far away from x_bar would have a big influence on what the slope would be

			<figure>
			                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396087/ffblakbdog5hfffql1ty.png" alt="">
			                      <figcaption></figcaption>
			                  </figure>


			diff point of view: we want to minimize SSR → more weight on 


			points that are far from middle 


### Inferences about regression

1. Comparison to t-tests
	- take advantage of CLT to say

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396089/q49wzht3jmurmlmy2vit.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

	- randomly pick some x, find the y on the line, and draw from normal dstiribtuion centered at that y with sigma squared variance. i.e, plug random x into $\beta_0+\beta_1x$ and add some normal error
2. Hypothesis tests with linear regression
	- how far our estimate of the slope depends on  1. the residual variance 2. more x away from mean means bigger denominator → better estimate of our slope
	- $$\hat{\beta}_1 \sim N\left(\beta_1, \sigma^2 \left( \frac{1}{\sum_{i=1}^{n} (X_i - \bar{X})^2} \right) \right)$$
	- $$\frac{\hat{\beta}_1 - \beta_1}{\sqrt{\sigma^2 \left( \frac{1}{\sum_{i=1}^{n} (X_i - \bar{X})^2} \right)}} \sim N(0, 1) \frac{\hat{\beta}_1 - \beta_1}{\sqrt{\hat\sigma^2 \left( \frac{1}{\sum_{i=1}^{n} (X_i - \bar{X})^2} \right)}} \sim t_{n-2}$$
	- $$P \left( \hat{\beta}_1 + 2 \sqrt{\frac{\hat{\sigma}^2}{\sum_{i=1}^{n} (X_i - \bar{X})^2}} \text{ includes } \beta_1 \right) = 0.95 $$
	- variance of intercept: 
	- $$\hat\beta_0 \sim  N(\beta_0, \sigma^2 \left( \frac{1}{n} + \frac{\bar{X}^2}{\sum (X_i - \bar{X})^2} \right) )$$
	- $$\hat{\mu}(Y|X=X_0) = \hat{\beta}_0 + \hat{\beta}_1 X_0$$ 
	- (estimate mean of y given some x value)
	- $$\hat{\beta}_0 + \hat{\beta}_1 X_0 \sim N\left( \beta_0 + \beta_1 X_0, \sigma^2 \left( \frac{1}{n} + \frac{(X_0 - \bar{X})^2}{\sum_{i=1}^{n} (X_i - \bar{X})^2} \right) \right) $$
	- (if i repeatedly sample and fit line, it varies, but by CLT, values are centered at true slope/intercept

### Intervals for regression

1. A simpler case
	- CI:
		- A range of values such that we think there’s a 95% chance that this interval covers the true population mean. So the more data I collect, the narrower this interval would be
		- i.e., as sample size increases, the confidence intervals width will shrink towards zero, but the prediction interval will still be wide
		- $\bar{Y} \pm 2 \, \text{SE}(\bar{Y}) \Rightarrow \bar{Y} \pm 2 \sqrt{\frac{S^2}{n}} $
	- this is NOT the same as a prediction interval for a future value of y.
		- $Y: \quad \bar{Y} \pm 2 \sqrt{S^2 + \frac{S^2}{n}}$
		- S^2: estimated variance of y values given $\mu$
		- prediction interval will be **wider** then the confidence interval, because the actual data points vary around the mean
2. Two types of confdience intervals for regression
	- confidence Intervals for coefficients: $\beta_0, \beta_1$
		- $P\left( \hat{\beta}_0 \pm 2 \, \text{SE}(\hat{\beta}_0) \text{ covers } \beta_0 \right) = 0.95 $
		- $P\left( \hat{\beta}_1 \pm 2 \, \text{SE}(\hat{\beta}_1) \text{ covers } \beta_1 \right) = 0.95 $
		- $\text{SE}(\hat{\beta}_0) = \sqrt{\hat{\sigma}^2 \left( \frac{1}{n} + \frac{\bar{X}^2}{\sum (X_i - \bar{X})^2} \right)} $
		- $\text{SE}(\hat{\beta}_1) = \sqrt{\frac{\hat{\sigma}^2}{\sum (X_i - \bar{X})^2}} $
	- confidence intervals for mean( Y | X= X_0)
		- $\text{Mean}(Y|X=X_0) = \hat{\beta}_0 + \hat{\beta}_1 X_0 $
		- $P \left( (\hat{\beta}_0 + \hat{\beta}_1 X_0) \pm 2 \sqrt{\sigma^2 \left( \frac{1}{n} + \frac{(X_0 - \bar{X})^2}{\sum (X_i - \bar{X})^2} \right)} \text{ covers mean}(Y|X=X_0) = (\beta_0 + \beta_1 X_0) \right) = 0.95 $
3. Prediction intervals for linear regression

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722396096/n4sc36egomqtrve6t9mb.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>

