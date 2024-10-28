Global Layoffs Data Cleaning and Exploratory Analysis (2020 – 2023)

1.	Description of Project
	Overview: The dataset provides an in-depth look at global layoffs across various companies and countries from 2020-2023, a period marked by significant economic shifts. It includes fields such as company name, location, country, industry, total employees laid off, percentage of workforce affected, funding stage, and funds raised. The data reveals patterns in layoffs by company and industry, providing a snapshot of workforce adjustments across diverse sectors.
Purpose and Objectives: The primary purpose of this project is to analyze patterns in layoffs, identifying factors like location, industry, and funding stage that correlate with workforce reductions. Specific objectives include:
•	Examining which industries and regions experienced the highest layoffs, noting the potential influence of COVID-19 and other economic challenges during this period.
•	Analyzing layoff trends related to a company’s funding stage to understand whether early-stage companies were more affected.
•	Investigating recovery patterns and workforce stabilization trends post-2021 as economic conditions evolved.
Significance: This analysis is valuable for understanding broader economic and industry-specific trends in job stability during a time of global change. Insights gained from this project can support workforce planning, risk assessment for industries, and inform decision-makers on how various sectors responded to both pandemic and post-pandemic market conditions.
2.	Software Application used: MySQL

3.	Data Cleaning Process: When cleaning data, a few steps are usually followed:
•	First thing is to create a staging table. This is the table i will work in and clean the data.
•	 I want to keep the raw data in case something happens.
•	Check for duplicates and remove any.
•	Standardize the Data and fix errors.
•	Look at Null values or blank values and see what to do with them.
•	Remove unnecessary rows and columns.
•	I followed these processes to transform the data and got it ready for exploratory data analysis.

4.	 Exploratory Data Analysis
•	Here we are just going to explore the data and find trends or patterns or anything interesting like outliers.
•	Normally when you start the EDA process you have some idea of what you're looking for.
•	With this info we are just going to look around and see what we find!

Insights Gotten from Exploratory Analysis Based on Output from SQL Codes
•	A 100% layoff means there are companies that laid off all its employees.
•	A construction company (Katerra) in the United States had 2434 layoffs which means they went under.
•	That's awful because they had about 1.6 million dollars in funding.
•	Let's take a look at companies that went under and the funds raised.
•	Britishvolt raised 2.4 million dollars and still went under.
•	We have big companies like AMAZON, GOOGLE, META with the highest layoffs.
•	The consumer industry had the most layoffs, followed by retail, transportation, Finance and Healthcare.
•	The lowest are: Manufacturing, FinTech, Aerospace, Energy, and the Legal industry.
•	They might have been affected by COVID which is just an assumption.
•	The media industry had the most funding.
•	Let's see the number of layoffs in the media industry.
•	A sum of 5234 layoffs in the media industry.
•	That's reasonable compared to the total sum of all layoffs (383659).
•	The top five countries with the most layoffs are: United States, India, Netherlands, Sweden, and Brazil.
•	The lowest are: Poland, Chile, New Zealand, Luxemburg, and Thailand.
•	This might be because of their population, or because of a bias in the data collection.
•	The countries with the most funding are: United States (121900), India, Netherlands, Lithuania, and the United Kingdom.
•	Funds raised in the United states is significantly more than the other companes which could be because of the population.
•	Of companies in the US or Bias in data collection or their GDP. The US is rich but these are all assumptions.
•	It looks like it started in 2020-03-11 which was around the COVID period. And ended 2023-03-06 according to this dataset.
•	In 2020, 80k people got laid off, 2022, over 160k got laid off.  However, we only have 3 months of data for 2023 and they over 125k layoffs was recorded.
•	Which means it was lot higher by the end of 2023.
•	This shows that companies in the Post-IPO STAGE, which are the big companies of the world had the highest layoffs.
•	From the output given, by the end of 2020, there was about 81k layoffs, 2021 was a good year comparatively, in 2022 things got worse with thousands and thousands of layoffs.
•	Even right before the holidays in December, there was 247k layoffs.
•	The first 3 months of 2023 were devastating.
•	Uber had the biggest layoffs in 2020, which makes sense because of Covid 19 lockdown. People weren't moving as much.
•	Bytedance had the most layoffs in 2021, Meta in 2022 and Google in 2023.
•	Distribution of layoffs by funding stage.
•	Companies in Post-IPO stage had the highest number of layoffs (companies-382, layoff-204132), followed by acquired companies.
•	There seems to be a correlation between company stage, financial strength, and workforce reductions.
•	Post-IPO stage companies raised the most funds. This could mean investors focus more on the big companies.
•	Stages and Layoffs Overtime.
•	This helps analyze if certain stages were more affected in certain years, possibly aligning with broader economic changes.
Conclusion
Based on our analysis of the global layoffs dataset, several significant trends emerged regarding workforce reductions and company funding across industries and countries. Companies that experienced a 100% layoff demonstrated the extreme impact of financial instability, with examples like Katerra in the U.S. and Britishvolt in the UK, both of which faced insolvency despite substantial funding. Additionally, large-scale layoffs were prevalent among tech giants, including Amazon, Google, and Meta, underscoring the technology sector's vulnerability in recent years.
The consumer industry faced the highest layoffs, with other affected sectors like retail, transportation, finance, and healthcare, likely exacerbated by the COVID-19 pandemic. In contrast, sectors like manufacturing, fintech, and aerospace saw comparatively fewer layoffs. Regionally, the U.S. led in layoffs and funding raised, with the top countries for layoffs including India, Netherlands, Sweden, and Brazil, possibly due to factors like population size and economic policies. 
The data reveals that layoffs escalated sharply starting in 2020, corresponding with COVID-19’s economic impact, peaking again in 2022 and the beginning of 2023. High layoffs among Post-IPO companies suggest that larger, publicly traded firms were particularly susceptible to workforce reductions, reflecting financial volatility at this stage. This trend emphasizes a potential correlation between a company’s stage, funding levels, and workforce stability, with post-IPO companies raising the most funds but also experiencing significant layoffs.

