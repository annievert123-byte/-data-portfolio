# Customer Loyalty Analysis — Turtle Games

**LSE Data Analytics Career Accelerator · DA301 · Individual Assignment · 2026**

## Overview

Turtle Games, a game development and retail company, needed to understand what drives customers to accumulate loyalty points and how spending habits differ across demographics. Using the 5 Whys framework to define the business problem, this project analyzed customer shopping and review data to answer three objectives:

1. Determine the key drivers of loyalty point accumulation (regression + Random Forest)
2. Segment the customer base into distinct groups (K-means clustering)
3. Gauge customer sentiment from reviews to flag specific product issues (NLP/sentiment analysis)

## Approach

- **Python**: data cleaning, initial linear regression and decision tree modelling (scikit-learn), K-means clustering, NLP and sentiment analysis on customer reviews (NLTK, VADER, WordCloud)
- **R**: skew/kurtosis and Shapiro-Wilk normality testing (`moments`), a relationship/correlation pairplot, Multiple Linear Regression (MLR) and Random Forest modelling (`tidyverse`), with an 80/20 train/test split to avoid overfitting

## Key Findings

- **Spending score (R² = 0.67)** and **remuneration (R² = 0.62)** are the strongest predictors of loyalty points — age was not a significant predictor (p > 0.05)
- The **Random Forest model** (R² = 0.995) substantially outperformed MLR, with predictions tightly centered on the actual values
- **K-means clustering (k=5)** identified five distinct customer segments by remuneration and spending score, with the median-remuneration/median-spending group the largest (774 customers)
- Customers aged **25–35** have the highest average spending scores, positioning them as the most valuable demographic for marketing
- Review sentiment was overwhelmingly positive, but isolating the negative tail flagged two specific underperforming products (IDs 9080 and 263) for quality review

## Recommendations
- Target marketing toward high-earning 25–35 year-olds, the demographic with the highest loyalty point potential
- Focus conversion efforts on high-earning, low-spending customers by introducing premium product categories
- Implement quality control review for products 9080 and 263, which scored well below average on customer sentiment

## Files
- [`reports/Turtle_Games_Customer_Loyalty_Report.pdf`](./reports/Turtle_Games_Customer_Loyalty_Report.pdf) — full written report with all visualizations and appendix
- [`notebooks/LSE_DA301_Assignment_Notebook.ipynb`](./notebooks/LSE_DA301_Assignment_Notebook.ipynb) — Python analysis: data cleaning, regression, clustering, NLP/sentiment analysis
- [`r-scripts/Vert_Annie_301_Assignment_Rscript.R`](./r-scripts/Vert_Annie_301_Assignment_Rscript.R) — R analysis: normality testing, MLR, Random Forest modelling
- [`assets/walkthrough.mp4`](./assets/walkthrough.mp4) — video walkthrough of the analysis (large file — download to view, GitHub won't preview it inline)

## Tools
`Python` (pandas, scikit-learn, NLTK, VADER, WordCloud) · `R` (tidyverse, moments, randomForest) · `Linear Regression` · `Random Forest` · `K-means Clustering` · `Sentiment Analysis`

---
*Individual assignment completed as part of LSE's Data Analytics Career Accelerator.*
