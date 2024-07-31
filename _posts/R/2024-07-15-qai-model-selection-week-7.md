---

title: "[QAI] Model Selection (week 7)"
excerpt: "notes from week 7"
date: 2024-07-15
lastmod: 2024-07-31 00:14:49 -0400
last_modified_at: 2024-07-31 00:14:49 -0400
categories: R
tags: QAI statistics model
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

<!--postNo: 2024-07-31-->


### Model Selection

1. Intro to model selection (parametric)

→ which terms to include in a linear model


**plan**: choose a model that **fits the data** **without using too manuy parameters**


**tradeoff**: more parameters lead to better fit/smaller residuals but also lead to “over-fitting”


**overfitting**: when the model too closley describes the data, not useful for generalization

1. measure of model fit
	- R^2 = 1 - SSR (residual varaiblity) / SST (overall variability) = SSModel/SST
	- R^2: is the proportion of variability in the outcome variable that is due to the predictors in your model rather than noise
	- i.e. the proportion of varaiblity explained by your model
	- you can calculate R^2 from a linear regression model with any number of predictors or terms
	- if you do have one predictor/term (simple linear regression), then R^2 = r^2
	- R^2 increases (or at least does not decrease) every time a term is added to the model, even if the term is not useful
	- so you can’t just chagne the model with the highest R^2
2. R-squared is equal to 1 when # of parameters equals number of data points ( you are overfitting)
	- prefer: many more data points than parameters to estimate
3. when you consider a subset of predictors, either fewer predictors or a smaller range of any particular predictor, R^2 decreases.

	![Screenshot_2024-07-21_at_6.52.51_PM.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/46a454de-d143-4526-a01f-0f13adda7dcc/b2c03c28-ef36-4b57-83c1-816b75a5188e/Screenshot_2024-07-21_at_6.52.51_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240731%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240731T041454Z&X-Amz-Expires=3600&X-Amz-Signature=02e9fef069f89d32c739a120e3e11423a1ff784a1469fd7539ab4d474a152e66&X-Amz-SignedHeaders=host&x-id=GetObject)

4. R^2 is not a measure of linearity

	![Screenshot_2024-07-21_at_6.54.40_PM.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/46a454de-d143-4526-a01f-0f13adda7dcc/26468104-a2fb-40a1-aac0-a98bf25795e3/Screenshot_2024-07-21_at_6.54.40_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240731%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240731T041507Z&X-Amz-Expires=3600&X-Amz-Signature=9ed18fb112d7f4a5aadb8540df2d19a0fe18ead24b431f639b46fcfacd8f8b75&X-Amz-SignedHeaders=host&x-id=GetObject)


