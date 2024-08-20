---

title: "[finally!] Structured output"
excerpt: "Byebye finetuning and json mode and excessing prompting to get a constant output"
date: 2024-08-17
lastmod: 2024-08-17 16:07:36 -0400
last_modified_at: 2024-08-17 16:07:36 -0400
categories: project
tags: gpt python bank-statement-insight new-tech
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

<!--postNo: 2024-08-17-->


With the release of `gpt-4o-2024-08-06`, a new OpenAI model, users now have access to **structured outputs:**

- a feature that ensures the model will always generate constant responses, so you don't need to worry about the model omitting a required key, or hallucinating an invalid enum value (definition from source below)
- This is amazing because I had to go through all sorts of steps to make the model constantly output an integer, for example, or not return `sorry I'm not sure I understood your response` through finetuning.
- compatible with > `gpt-4o-mini` (as of Aug 17th, 2024)

# Usage


I used this immediately in my new project - `bank-statement-insight` . Other examples can be found on the link in the sources section, so I recommend looking through it! 


(On a side note I can’t believe gpt 3.5 turbo is deprecated now… i remembering using it for the first time this time last year)


```python
from enum import Enum
from pydantic import BaseModel
from typing import Optional

completion = client.beta.chat.completions.parse(
                model='gpt-4o-2024-08-06',
                messages=[
                            {"role": "system", "content": 
                            "You are a highly accurate assistant tasked with categorizing bank transaction descriptions. "
                            "Your main goals are: "
                            "1. Identify and return the main category of the transaction. "
                            "2. If a place of transaction is mentioned, return the place. "
                            "When identifying the category, always prioritize the first relevant term in the description. "
                            "If multiple categories apply, select the one that best matches the first relevant term. "
                            "If a description involves a recurring payment or known entities like 'Zelle' or 'Venmo', consider them as 'cash_transfer'. "
                            "If the category is unclear, try to infer based on common transaction patterns but avoid guessing if unsure."},
                            {"role": "user", "content": desc},
                        ],
                response_format = Parsed_description
            )
            try:
                parsed = completion.choices[0].message.parsed
                return parsed.category.value, parsed.place
            except Exception as e:
                raise Exception(f"Failed to parse description {desc}: {e} ")
                
                
# Prepare structured ouput for GPT response
class Category(str, Enum):
    income = "income"
    investment = "investment"
    cash_transfer = "cash_transfer"
    credit_card_payment = "credit_card_payment"
    interest = "interest"
    tax = "tax"
    grocery = "grocery"
    delivery = "delivery"
    dine_out = "dine_out"
    transportation = "transportation"
    subscription = "subscription"
    housing = "housing"
    healthcare = "healthcare"
    insurance = "insurance"
    shopping = "shopping"
    leisure = "leisure"
    other = "other"

class Parsed_description(BaseModel):
    category: Category
    place: Optional[str] # this allows None  
```


# Sources


[https://platform.openai.com/docs/guides/structured-outputs](https://platform.openai.com/docs/guides/structured-outputs)


