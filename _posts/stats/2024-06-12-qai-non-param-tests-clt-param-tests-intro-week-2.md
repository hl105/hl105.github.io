---

title: "[QAI] Non-param tests, CLT, param tests intro (week 2)"
excerpt: "notes from week 2"
date: 2024-06-12
lastmod: 2024-07-30 22:18:18 -0400
last_modified_at: 2024-07-30 22:18:18 -0400
categories: stats
tags: qai CLT statistics R sign_test
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

<!--postNo: 2024-06-12-->


again, all notes from QAI


### Non-parametric tests for pairs

1. sign test
	1. example: number of students who got an A

	| student | fall | spring | diff  |
	| ------- | ---- | ------ | ----- |
	| 1       | 0    | 1      | 1     |
	| 2       | 3    | 4      | 1     |
	| 3       | 2    | 1      | -1    |
	| 4       | 2    | 4      | 2     |


	avg: 3/4


	| student | fall | spring | diff |
	| ------- | ---- | ------ | ---- |
	| 1       | 0    | 1      | 1    |
	| 2       | 4    | 3      | -1   |
	| 3       | 2    | 1      | -1   |
	| 4       | 4    | 2      | -2   |


	avg: -3/4


	These two datasets would be equally likely if we assume that fall and spring As are equally likely


	Get all the avgs and create histogram - find the statistic actually observed - find how extreme it is (same with what we did for p-value)

2. Conducting a **sign test**
	1. instead of avg, we look at if the diff is positive or not
	2. cross out any ties
	3. 

	| student | fall | spring | pos? |
	| ------- | ---- | ------ | ---- |
	| 1       | 0    | 1      | 1    |
	| 2       | 3    | 4      | 1    |
	| 3       | 2    | 1      | 0    |
	| 4       | 2    | 4      | 1    |


	sign test: test stat is number of differences that are positive


	d. so just k=3


	f. Under null hypothesis, each row we have is just coin flip, 0.5 prob → so if we just know how many pairs there are in dataset, I know what the reference distribution will look like. So I expect to see a sum of coin flips of 2 (0.5+0.5+0.5+0.5). We know all the cases where we have 0 heads, 1 heads, … 4 heads. (head = pos diff). So we can calculate the p-value of k=3. The number of coin flips distribution is called the **binomial distribution.** 


	g. Binomial distribution

		- symmetric,
		- looks more like a normal distribution bigger the sample size and the prob closer to 0.5. But sign test the null hypothesis assumes 0.5, so as number of pairs increases, it’s essentially a normal distribution.
		- back to e.g.: N(4/2,4*1/2*1/2) = N(2,1) = N(#pairs/2, #pairs/4)
		- (k-mean)/var ~ N(0,1)
		- known as  “back of an envelope” bc it should only appear on the back of an envelope not in a published paper. (should not typically be used in a paper because there are other tests that use more of the information that is available to you.)
3. Conducting a signed rank test:
	1. randomization/permutation test for paired data, using “signed rank statistic”
	2. To calculate statistic:
		1. take absolute value of difference between outcomes within each pair
		2. rank abs diffs
		3. S = sum of ranks for pairs where original diff was positive
		4. in R: willcoxtest(..paired = true)
		5. e.g.

		| student | fall  | spring | pos? | diff | |diff| | rank(|diff|) |
		| ------- | ----- | ------ | ---- | ---- | ------ | ------------ |
		| 1       | 0     | 1      | 1    | 1    | 1      | 1            |
		| 2       | 3     | 5      | 1    | 2    | 2      | 2            |
		| 3       | 4     | 0      | 0    | -4   | 4      | 3            |
		| ~~4~~   | ~~2~~ | ~~2~~  |      |      |        |              |


		S = 1+2=3

	3. Why?
		- Same advantages as any other non-parametric rand/perm test
		- same  advantages as rank sum but also same disadvantages/throw away actual data
		- pairs

	d.what makes S big/small?

		- lots of positive differences & the pos diffs are large in magnitude

### Sampling Variability and Measures of Dispersion

1. Polls
	1. Q: poll of 500 ppl in Oklahoma (3.8 million) to predict 2012 presidential election outcome of state. how large a poll would you need in California (38 million) to produce an equally precise prediction?
2. It’s like a bowl of soup
	1. A: precision of estimate x depend on sample size, but not in the number of units in population.
	2. suppose we have a bowl of soup. I’m going to take a spoonful of soup. I’m trying to figure out if the soup is too salty or not. What influences the guess? →
		- is the soup **mixed** well?
		- **size of my spoon** — if too small hard, if really big it might be easier.
		- **variabliilty** of soup: if big carrot on spoon vs tomato
	3. does not matter how big the soup bowl is
3. Centers
	1. **statistics**: want to summarize a data into useful information
	2. what if we have really small dataset?
		1. e.g. 4 students 0 0 2 6 (# of stat courses taken)
		2. how do we convey the pattern in this data without reciting the actual numbers?
	3. **middle**: mean, median, mode
	4. **dispersion** (how spread out): min, max, range(max-min) 25%, 75%, IQR(Q3-Q1)
4. Mean/Median Absolute Deviation:
	1. abs(val-median): (0-1) (0-1) (2-1) (6-1) → get median of these
	2. you can do the same thing with mean → get mean
5. Variance, mean, and notation
	1. **variance**: instead of taking absolute value, you square the differences  & divide by #
	2. **N: population** size **n:** **sample** size
6. Variance
	1. middle is mean (µ). 95% of dataset is between µ-2σ and µ+2σ .

### Central Limit Theorem

1. Distributions of Sample Means
	1. **standard normal distribution**: a normal distribution with mean 0 and variance 1.
	2. population: Y~N(65,4) ← mean = 65, variance = 4
	3. If I randomly generate samples from population and each time I record the **mean**, I would expect those means to be very close to 65.  ȳ~(65,4/100)
2. Central Limit Theorem
	1. as long as variance in population isn’t infinite, when we randomly sample independently from inital population, the distribution of the sample means follows a normal distribution.

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392319/qs6behz02akvqnywrkif.png" alt="">
                      <figcaption></figcaption>
                  </figure>

1. Expected Value
	1. µ: population mean
	2. ȳ: sample mean
	3. ȳ = (y1+y2+…+yn)/n
	4. E(ȳ) = E(1/n*sum(1 to n)_yi)

<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392320/shqtu20s8ihzg1qoohtd.png" alt="">
                      <figcaption></figcaption>
                  </figure>

1. Variance of sample means
	1. 

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392322/ybsiivi39qc92f9sf78a.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>


Q: when do we need a bigger sample size for CLT to be applied?

- **Variability of the Data**: If the data has high variability (large standard deviation), a larger sample size is needed for the sample mean to be approximately normal.
- **Shape of the Population Distribution**: If the population distribution is heavily skewed or has heavy tails, a larger sample size is needed.

### Parametric Hypothesis Tests, Part 1 (Z-tests and t-tests)

1. Using the CLT to generate a reference distribution
	1. suppose $H_0$: µ = 65.
	2. Test statistic: $\bar{Y} = 64.5$
	3. Reference distribution (=under null hypothesis): $\bar{Y} \sim N(65, \frac{4}{100})$ if someone told us the variance and sample size
	4. 64.6 is more than two standard deviations away from mean → p-value less than 2.5%
2. Z-tests
	1. still suppose $H_0$: µ = 65.
	2. instead of $\bar{Y}$ use $\frac{\bar{Y}-65}{\sqrt{\frac{4}{100}}} = \frac{64.5-65}{\sqrt{\frac{4}{100}}} = -2.5$
	3. reference distribution: ($\frac{\bar{Y}-65}{\sqrt{\frac{4}{100}}} $) $\sim N(0,1)$
	4. we don’t have to assume that the population distribution is normal becuase the reference distribution follows the CLT — it’s normal regardless of population distribution.
3. Standard normal distribution
	1. but what do we do when we don’t know the population variance? → t-test
4. Toward the t-test: sample variance
	1. we need to estimate the population variance using the data
	2. $S^2 = \frac{(y_1-\bar{y})^2 +(y_2-\bar{y})^2 +...+ (y_n-\bar{y})^2}{n-1}$ is the estimate of the population variance using sample
	3. why n-1 instead of n??? intution 1 $\mathbb{E}(s^2) = \sigma^2$ unbiased

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392327/xt6j4yoo8i1rzoogpq7q.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>


		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392328/lxhewfcufheyxcbvwlzv.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

	4. intution 2: order to calculate the sample variance, i have to first calculate sample mean → used first piece of information
	5. n-1 is called degrees of freedom
		1. intution 3: if we have two points on plot, we can estimate the slope. If we have three points, we can talk about variance too, since we only need two points to talk about slope and we have one piece of information left to talk about variance.
		2. **intuition 4:** we are dividing by a smaller number than dividign by n, so the overall number is a bit bigger → since we are _estimating_ the variance, we are inflating the uncertainty.
5. One-sample t-test
	1. still suppose $H_0$: µ = 65.
	2. test statistic: $\frac{\bar{Y}-65}{\sqrt{\frac{S^2}{100}}} = \frac{\bar{Y}-\mu}{\sqrt{\frac{S^2}{n}}} $ (variance not known anymore)
	3. reference distribution: $\frac{\bar{Y}-65}{\sqrt{\frac{S^2}{100}}} \sim t_{99}$ ← for smaller sample sizes (smaller degrees of freedom) it’s like a normal distribution with a wider (Fatter) tailer — higher chance of getting extreme value since we don’t know what variance we’ll get
	4. we don’t rely on CLT anymoore bc S^2 depends on shape of population distribution. If pop distribution is normal → follows chi-square distribution. If not, Idk. **So we have to assume population distribution is normal for t-test.**

6. Two-sample test

	1. using CLT. You can just add varainces together bc we’re assuming independence
	2. null hypothesis: population mean in the first group is equal to the population mean of the second gorup

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392335/vvdrsuxz70aox6vupegg.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>


	b. $H_0: \mu_x = \mu_y$ → $H_0: \mu_x - \mu_y = 0$


	c. test statistic: $\frac{\bar{X}-\bar{Y}-0}{\sqrt{\frac{\sigma_x^2}{n_x}+\frac{\sigma_y^2}{n_y}}}$


	d. reference distribution: standard normal N(0,1)

1. Two-sample t-test, unpooled
	1. of course, we don’t usually know the variances of the populations. So we use two-sample t-tests
	2. use $\frac{\bar{X}-\bar{Y}-0}{\sqrt{\frac{S_x^2}{n_x}+\frac{S_y^2}{n_y}}}$← **unpooled or welch t-statistic**
		1. had to assume both populations are normal and independent
	3. reference distribution: $t_{df}$ **approx**. If sample size big enough it’s just standard normal.
2. Two-sample t-test,pooled
	1. if we can assume that the variances are the same in the populations, then things are a bit simplier
	2. $\frac{\bar{X}-\bar{Y}-0}{\sqrt{\frac{S_p^2}{n_x}+\frac{S_p^2}{n_y}}}  = \frac{\bar{X}-\bar{Y}-0}{s_p\sqrt{\frac{1}{n_x}+\frac{1}{n_y}}} $ ← pooled t-statistic
	3. reference distribution: **exactly** follows a t distribution of $t_{n_x+n_y-2}$
		1. why? $s_p $ follows chi-square distribution
	4. 

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392338/l3ks0a0ximu1lezk9o5y.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>


		$S_p^2 = \frac{s_x^2(n_x-1)+s_y^2(n_y-1)}{n_x+n_y-2}$


### Parametric Hypothesis Tests, Part 2 (example, paried tests, confidence intervals)

1. example
	- you check the assumptions for t-tests by looking at the visualizations (boxplot, histogram, etc.). If data is heavily skewed/ has a lot of outliers, try applying log
	- find mean, variance of the two samples from two populations
	- using that, calculate the t-statistic
		- why do we pool? More complex methods such as regression and anova are generalizations of the pooled t-statistic.
		- we know that t-distribution is bascially a normal distribution with big enough sample size. If we know that the sample size is so small that it’s not a normal distirbution, we should not bother with a t-test and just use a randomazation and permutation test.
2. Confidence intervals
	1. we come up with the range of values that if they were the null, would not be contradicted by our data
	2. $H_0: \mu = 65$ ← I’m either going to reject this null hypothesis or not
	3. let’s say we reject it. what if $\mu = 64.3$ and it’s not contradicted by the data?
	4. The set of null hypotheses not contradicted by the data are going to be the values close to the mean I actually observed = confidence interval
	5. the probability that the upper and lower bounds contain true mean $\mu$ is 0.95

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392340/yangxoanngkowj7ivikd.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

3. Paired t-test
	1. we want to maintian the paired structure — who is paried with whom

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392342/rm3h6n5ingaresiznsxf.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

	2. paired t-test is identical to one-sample test of differences
	3. $H_0: \mu_x=\mu_y $ or $\mu_d=0$ (population mean of within pair differences)
	4. $t = \frac{\bar{x}-\bar{y}}{\frac{s_d^2}{d}}$ ← denominator: sample variance of differences divided by number of pairs d

		<figure>
		                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1722392343/ygpckdu1eq5qhxa49nx2.png" alt="">
		                      <figcaption></figcaption>
		                  </figure>

- null hypothesis of randomization tests (rank sum, sign test, signed rank test, etc.) → population distributions are the same
- t-tests: use null hypotheses related to population means

