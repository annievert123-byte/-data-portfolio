# Seasonal Exploratory Analysis of NHS Appointment Data

**LSE Data Analytics Career Accelerator · DA201 · Individual Assignment · 2026**

## Overview

The NHS posed two questions about its appointment data: *"Has there been adequate staff and capacity in the networks?"* and *"What was the actual utilisation of resources?"* This project used Python to clean, merge, and analyze NHS appointment datasets to answer both — with a particular focus on seasonal trends in appointment volume, wait times, and staff utilisation.

## Approach

- **Data cleaning**: identified that missing values weren't flagged as nulls but instead recorded as strings like `'Unknown'` or `'Unmapped'` — created a custom mapping to properly convert these to null values across all datasets before analysis
- **Data merging**: partially merged the National Categories (NC) and Appointments Regional (AR) datasets via ICB location codes to strengthen locational context, avoiding a full merge that risked duplicating records
- **Custom metrics**: calculated a "Did Not Attend" (DNA) rate per location, and built a weighted average wait-time metric by mapping appointment wait-time bands (e.g. "22 to 28 Days") to numeric values and weighting by appointment volume
- **Seasonal analysis**: aggregated appointment volume, wait times, and resource utilisation by season and by healthcare provider type (GP vs. Other Practice staff), benchmarked against the 2019 baseline of 24.2 million appointments/month
- **Social listening (Twitter/X data)**: extracted and analyzed hashtag frequency from NHS-provided social data — and identified a data quality issue: the dataset was overwhelmingly US/Canada-centric (terms like "medicare" dominated) rather than UK-representative, making it unsuitable for informing real UK staffing decisions. Flagging this limitation was itself a key finding.

## Key Findings

- **Autumn (Sept–Nov)** consistently exceeds benchmark appointment volume, wait times, *and* utilisation for both GPs and Other Practice staff — reaching up to **125% of standard operating capacity**
- The NHS operates **above its 2019 utilisation baseline in 10 of 12 months**, suggesting a sustained, high level of demand rather than occasional spikes
- Other Practice staff consistently have notably longer wait times than GPs across every season
- The provided social media dataset was not fit for purpose — geographic mismatch meant it couldn't reliably inform UK-specific staffing or sentiment conclusions

## Recommendations
- Implement seasonal staffing increases specifically in Autumn to address the ~25% rise in operational utilisation during that period
- Improve future data collection by using geographically filtered social listening data, to enable genuinely UK-relevant sentiment analysis
- Introduce targeted communication (e.g. text reminders) for patients with 22+ day wait times, to reduce Did-Not-Attend rates and recover wasted appointment slots

## Files
- [`reports/NHS_Appointment_Analysis_Report.pdf`](./reports/NHS_Appointment_Analysis_Report.pdf) — full written report with all visualizations and appendix
- [`notebooks/Vert_Annie_DA201_Assignment_Notebook_Submission.ipynb`](./notebooks/Vert_Annie_DA201_Assignment_Notebook_Submission.ipynb) — full Python analysis: data cleaning, merging, custom metrics, seasonal aggregation, social data analysis
- **Presentation video**: too large to host on GitHub (220MB+) — available on request

## Tools
`Python` (pandas, NumPy, matplotlib) · Data cleaning & merging · Custom weighted metrics · Seasonal trend analysis · Social media/text data analysis

---
*Individual assignment completed as part of LSE's Data Analytics Career Accelerator.*
