---

title: "[project] bank-statement-insight"
excerpt: "first project using databases"
date: 2024-08-20
lastmod: 2024-08-20 16:31:45 -0400
last_modified_at: 2024-08-20 16:31:45 -0400
categories: project
tags: database bank-statement-analysis
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

<!--postNo: 2024-08-20-->


Project readme: 


[https://github.com/hl105/bank-statement-insight?tab=readme-ov-file](https://github.com/hl105/bank-statement-insight?tab=readme-ov-file)


The final version is explained in detail in the readme, so I’ll talk about how this project just kept evolving in this post. 


# Chain of Thought 


TLDR: We needed **database normalization** and **persistence**


(Not familiar with these terms? Head to my `DATABASES!!` blog post!)


**Initial goal:** parse a pdf and get a simple data analysis result page using streamlit


**Added features:**

- instead of console messages, use streamlit as frontend to get info
- use GPT to classify descriptions, and let the user edit it if not satisfied.
- _**use databases**_ this was a big jump. Had to start using this because I didn’t want the user to edit misclassifed descriptions every time they start a new session. I also didn’t want GPT to be called for the same queries over and over.
- I also wanted to save past statements

# Improvements


### Database Connection

- I wrote everything in two days _without any databases._
- Then I wanted to store the `Finance` objects  and `gpt responses` so that I don’t have to start them from scratch for each session. I looked into databases → **`SQLite`**.
- Ok great! I made a `finance_db` table inside a database and pickled `Finance` objects and put them in the table.
- But now I wanted to use relative databases by creating tables for my `Statement` object and `transaction` dataframe so I was about to do that when a question popped up in my head: what’s the relationship between a `python class` and a `database table` ?
- Then I found out the code I’ve written, the code I wrote trying to  somehow integrate `SQLite` into `python classes` is essentially a primitive version of **`SQLAlchemy`** **!** So I added that.
- This is my final database drawing:

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1724185911/aasjt3jxravpzuanqunf.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>

- Pseudocode

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1724185913/iwkk2bxu1qbyqoqdabao.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>


### Improving User Interaction

- Initially I had a simple console user interace.
- Then I wanted to get rid of it (because I wanted my very non-cs sister to be able to use it and I was pretty sure she won’t know how to open a terminal) and so used `streamlit`  to create a file upload form.
- Then I wanted to add an extra step where users can look at the GPT labeled categories and change it if they don’t like it. So I added a new page `edit_data` where user edits the dataframe and clicks `submit` . Then backend code finds the differences and updates the database so that users don’t have to recategorize every time.

	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1724185914/rpl7de2q6vzirsaw1z8n.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>


	<figure>
	                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1724185916/whz5mwsgg8rcopvuivg2.png" alt="">
	                      <figcaption></figcaption>
	                  </figure>


