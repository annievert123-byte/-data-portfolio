# QSR Location Health Index — US Market

**LSE Data Analytics Career Accelerator · Team Project · 2026**

## Overview

The US quick-service restaurant (QSR) market is worth over $343B annually. This project built a **Location Health Index** — a 0–100 score for individual QSR outlets — to help a simulated company proactively identify restaurant locations at risk of high customer dissatisfaction, enabling earlier, more targeted intervention than relying on lagging sales data alone.

## Approach

- **Data**: Yelp open dataset (200,000+ reviews) across 18,000+ US QSR outlets, loaded and processed in Snowflake
- **NLP & sentiment**: Applied VADER sentiment analysis across the full review set, with NLP-based root cause classification across six complaint categories to identify drivers of negative sentiment
- **Modelling**: Used recency-weighted average ratings, rolling z-score spike detection, and multi-linear regression to flag 1,716 high-risk locations — including a notable finding that 24/7 operating hours correlated with lower ratings (r = -0.54)
- **Delivery**: Built three interactive Tableau dashboards (executive overview, outlet explorer, competitor benchmarking) designed for non-analytical QSR managers, with geographic maps, KPI tiles, and filtering

## My Contributions
- Built the recency-weighting and star distribution logic underpinning the Health Index score
- Contributed to the structural design of the Health Index scoring methodology
- Acted as report lead, writing the bulk of the final written report
- Presented the final findings to the class as project spokesperson

## Files
- [`notebooks/Team15_Outliers_LSE_EP_Assignment3_EDA.ipynb`](./notebooks/Team15_Outliers_LSE_EP_Assignment3_EDA.ipynb) — full exploratory data analysis, NLP/sentiment pipeline, and modelling notebook
- **Tableau dashboard**: the `.twbx` workbook file is too large to host directly on GitHub (224MB). See screenshot below, or contact me for the live file.

## Dashboard Preview
*Screenshot to be added — see `/assets`*

## Tools
`Python` (pandas, NumPy, scikit-learn, VADER, NLTK) · `Snowflake` · `Tableau` · `SQL`

---
*Note: this was a team project completed as part of LSE's Data Analytics Career Accelerator. The notebook reflects the team's combined work; the "My Contributions" section above details my specific role.*
