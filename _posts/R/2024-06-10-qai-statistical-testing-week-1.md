---

title: "[QAI] Statistical Testing (week 1)"
excerpt: "notes from week 1"
date: 2024-06-10
lastmod: 2024-06-10 21:58:49 -0400
last_modified_at: 2024-06-10 21:58:49 -0400
categories: R
tags: qai R statistics
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

<!--postNo: 2024-06-10-->


### sampling and bias

1. unit:
	1. thing we are studying
	2. often row in dataset
	3. ex) people, households, mic, bags of dirt
2. target population:
	1. set of units you’d like to learn about
	2. ex) all Wellesley students, all US households, …
3. estimand:
	1. a number that we wish we knew in order to answer the research question
	2. the estimand could be calculated in a straightforward way if we had data of every unit in the target population
4. Sampling:
	1. the link between target population and the data you have
5. Census:
	1. an attempt to collect info from **all** units in the target population
	2. ex) US Census
	3. problems: resource heavy, misses certain subgroups systematically — ex) homeless ppl
	4. **big data / data science**: sometimes we **can** calculate the estimand because we do have all the units in target population
6. Sample population / sampling frame
	1. def: set of units with some chance of being included in your dataset
	2. ex) households with phone numbers listed
	3. it is very possible for parts of sample population to not be in target population
	4. goal: choose a data collection method such that sample pop is as similar as possible to target population
	5. **sample**:
		1. set of units for which you attempt to collect data
		2. can be also used to describe units in your data set
		3. we have most control over choosing a sample from sample population
	6. **respondents**: set of units actually in your data set
	7. ex) interested in surveying Wellesley students. Puts all Wellesley students’ names in a hat and draws 50. But only 30 ppl responded when contacted
		1. people in sample: 50.
		2. target population: all Wellesley students.
		3. sample population: all Wellesley students.
		4. respondents: 30 who responded
7. Sampling methods
	1. **haphazard; convenience** → likely not representable
	2. **simple random sample** (SRS)
		1. all units in sample pop are in a hat, a predetermined number of units is selected
		2. all subsets of size n have the same probability of being the sample
		3. SRS is default assumption for most common statistical methods
	3. **stratified sampling**: group units based on characteristics, take SRS from each group
	4. **cluster sampling:** divide units into clusters, do a SRS on clusters (pick all of one cluster) → for convenience
	5. **systematic sampling:** include every kth unit → sequential. ex) exit poll
	6. **Bernoulli Sampling**: flip a coin for each unit to decide whether they are in your sample → sequential
8. Bias
	1. non-response bias: respondents are not representative of sample
	2. selection bias: when the sample is not representative of the target population, because either -
		1. sample population is not representative of target
		2. sample not rep of sample population
9. Comparing two groups, and summary table
	1. Assigning units in sample to groups:
		1. parallels sampling from a group
		2. goal is to create groups that are representative of each other
		3. haphazard or any of the random strategies we listed
	2. assigning groups, sample from population:
		1. if assigning group is random - infer causation.
		2. if sample from group is random - easy to generalize
		3. both random → very rare, but ideal
		4. not random, random → survey
		5. random, not random → lab experiments
		6. not random, not random → most studies

### Intro to Hypothesis Testing

1. R.A. Fisher’s Lady tasting tea
	1. 8 cups of tea. 4 milk first, 4 tea first. Lady’s job is to pick out the 4 that was poured milk first
	2. possibilities: 4 correct, …, 0 correct
2. Counting:
	1. 4 correct → 1 way
	2. 3 correct → 4x4 = 16 ways
	3. 2 correct → 6x6=36 ways
	4. 1 correct → 4x4 = 16 ways
	5. 0 correct → 1 way
3. Comparing truth to distribution:
	1. p-value: assuming the lady is guessing at random, the prob she should have gotten all 4 correct is 1/70.
	2. she did get all 4 correct! Evidence contradicts that she was guessing at random.
4. Hypothesis Tests:
	1. data @ 2: reference distribution — we can check how extreme (surprising) is the value we actually saw?
	2. null hypothesis: assumption about target population
	3. test statistic: something you can calculate from the sample that you actually have

### Intro to Non-Parametric Tests

1. **Defining terms:**
	1. **hypothesis tests**: proof by contradiction
	2. **null Hypothesis** (H_0): based on the assumption, typically that there is no effect or no pattern
	3. **statistic**: number that can be calculated from data
	4. **test statistic**: statistic used to calculate H_0
	5. **distribution**: a list of possible values of a random numeric quantity, along with their probabilities
	6. **reference distribution**: distribution of the test statistic, assuming H_0 is true.
2. Randomization test assuming simple random sample
	1. HCAS harvard case example: of those offered help. 76% won. Of those not offered help, 72% won.
	2. pretend: only 3 ppl in study.
	3. 

| 0        | 0           | 1 (won)     |
| -------- | ----------- | ----------- |
| help (T) | no help (C) | no help (C) |
| C        | T           | C           |
| C        | C           | T           |
|          |             |             |
|          |             |             |


difference

1. diff: 0 (mean win rate for T)-0.5 (for C)=-0.5
2. 0-0.5 = -0.5
3. 1-0 = 1

2/3 prob that get a diff of -0.5


1/3 prob that I get a diff of 1


	d. H_0: no impact of offer of help from HCAS on outcomes


	e. Assume: SRS with one T and two C 

3. Bernoulli randomization and p-values
	1. Bernoulli randomization means that you flip a coin for each unit, rather than drawing a prespecified number of units out of a hat.
	2. useful when units arrive one by one so you can’t randomize all at once.
	3. Assuming: Bernoulli randomization (not SRS)
	4. 

| 0       | 0       | 1       |   |   |
| ------- | ------- | ------- | - | - |
| T       | C       | C       |   |   |
| C       | T       | C       |   |   |
| C       | C       | T       |   |   |
| T       | T       | C       |   |   |
| T       | C       | T       |   |   |
| C       | T       | T       |   |   |
| ~~_T_~~ | ~~_T_~~ | ~~_T_~~ |   |   |
| ~~C~~   | ~~C~~   | ~~C~~   |   |   |


none of the p-vals are small — I won’t be surprised if something happens 1/2 of the time? no. This is because it’s a tiny dataset. 


differences


0-0.5=-0.5


0-0.5=-0.5


1-0=1


0-1=-1


0.5-0=0.5


0.5-0=0.5


~~0.33-?? = ??~~


~~??-0.33 = ??~~


left side p-val: 3/6 = 1/2


right-side p-val: 5/6


one-sided: 1/2


two-sided: 1


	c. p-value:

	- probability of observing a value of the statistic that is at least as extreme as actually observed, if H_0 is true.
	- left-sided p-vaue: prob that test statistic is at least as small as actually observed, if H_0 true.
	- right-side p-value: prob … at least as large …
	- one-sided p-value: min(left, right)
	- two-sided p-value: 2xone-sided value
	- most common to report 2-sided p-value, but I should specify what p-value I’m reporting
	- If p-value is small, perhaps H_0 is not true. “reject H_0”
	- If p-value is big, no reason to doubt the null “failed to reject H_0”
	- A common cutoff is 0.05, but not for any reason
	- A p-value less then 0.01 or 0.001 is equivalent to 0 “p<0.001”
4. Non-parametric test: next steps:
	1. lots of assumptions
	2. randomization test: take advantage of the fact that we randomized the test
	3. permutation test is equivalent: apply the algo for randomization test for a situation where we did not randomize
	4. benefits: useful for any sample scheme, any sample size. you can also use any test statistic. No distributional assumptions such as normality.

Q: Can we carry out the steps of a randomization test if the study was not actually randomized?


A: Yes. The steps in the test work perfectly will if the two groups were not created randomly. However, in that case we can't justify the test by saying that each of these other randomizations could have occurred if the groups did not cause the outcome. Instead, we justify the test by saying that the group labels could have been allocated in any of these ways if the outcomes are not related to the groups.


### **Rank Sum Tests**

1. Rank sum test
	1. ex setup: suppose we compare the effectiveness of the old drug and the new drug. Suppose we measure how many months they lived after we assign the drugs. 4 ppl.
	2. 2 ppl for old drug A lived 3, 7 months each
	3. new drug B lived 0, 12 months
		1. 3 7 0 12
		2. A A B B
		3. A B A B
		4. .. continue random allocation → make histogram of  difference of means → get p value
	4. what if instead of 12 months, it’s >12? (person’s still alive)…what do we do?
2. Rank sum test details
	1. we can’t take mean of 0 and > 12. so instead, w.t. transform our data so that we can represent >12 in a useful way — convert to numbers rank in dataset.
	2. back to example
		1. 3 7 0 >12 (assigned)
		2. 2 3 1 4 (ranks) → T (add ranks of ppl in group A)
		3. A A B B → 5
		4. A B A B  → 3
		5. A B B A  → 6
		6. B B A A →  5
		7. B A B A  → 7
		8. B A A B → 4
	3. T = sum of the ranks in the smaller group. We now have reference distribution!
	4. The randomization we actually saw (data) is the first row. → Q: are we surprised to see a rank sum of 5 if null is true? No! bc the 5 is the middle value i expect to see
3. Why sum of ranks?
	1. the test statistics we used was sum of ranks instead of diff of means.
	2. suppose the values was 3 3 0 > 12. Then you average the ranks: 2.5 2.5 1 4
	3. If I know there’s 4 nums, we know there are 4 ranks. If I know sum is 10 (1+2+3+4), and the sum of ranks in group A is 5, I know that the sum of ranks in group B is 5. So I just have to keep track of 1 group.
4. When to use the rank sum
	1. when you have censored data (very common in medical data like >12)
	2. when you have outliers: when you have 120000 instead of 12: if you take average with this, this outlier will completely drive the output. This rank sum test is resistant to outliers.
	3. when you have small dataset bc no assumptions (e.g. normal distribution). Other methods, like t-tests, estimate the reference distribution by making assumptions.

### More Non-parametric Tests

1. Ways to approximate the reference distribution, rather than calculating it exactly
	1. exact method
		1. (what we’ve been doing) listing all ways to allocate units into 2 groups. AAABB, AABAB, …
		2. problem: too many ways to allocate units
	2. approximate exact:
		1. take a SRS of the ways to allocate the units into 2 groups. Use those allocations only to produce an approximation to the exact reference distribution
		2. most common plan
	3. normal approximation:
		1. works sometimes, only if the mean and variance of the reference distribution is known ahead of time, and we know the reference distribution would be normal.
		2. workers for rank sum bc “expected value” E(T)  = n_1(N+1)/2, var(T) = n_1n_2(N+1)/12
		3. Y: -20, -11, 5,7, …, 2100, 3000
		4. rank: _**1, 2**_, 3, 4, _**5**_, …, 99, _**100**_
		5. treat: A, A, B, A, …, A,B
		6. rank depends on N, not data values
		7. uniform reference distribution: we know the distribution (histogram) of the ranks without seeing the data → just flat bc there’s one of each rank
2. Central Limit Theorem
	1. If you get the **rank sum** distributoin from the uniform **rank** distribution, it looks like a normal distribution.
	2. def: **regardless of** population distribution, sum of random samples will be approximately normally distributed (in most circumstances)
	3. but then why is it helpful that converting to ranks gives us a uniform distribution?
	4. CLT says when we draw a large sample from a data set and record the sum (or mean) of the values in the sample, if we repeatedly draw different samples, the sums (or means) will look approximately normal. However, the meaning of the word "large" depends on the distribution of the original data: the weirder the distribution, the larger sample size we need in order for the CLT to be true. So, the advantage of converting the data to ranks is that we know the uniform distribution is not too weird (no outliers, symmetric), and the CLT will work even for a small sample size.
3. Facts about rank sum
	1. no distributional assumptions
	2. outliers are not a problem
	3. censoring not a problem
	4. randomization/permutation distribution depends on the sample size, not the data itself
	5. big or small sample size is fine
	6. when to avoid rank sum:
		1. lots of ties

