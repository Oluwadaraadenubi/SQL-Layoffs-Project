-- Exploratory Data Analysis

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers

-- Normally when you start the EDA process you have some idea of what you're looking for

-- With this info we are just going to look around and see what we find!

-- Let's check the table 

SELECT *
FROM layoffs_staging2;

-- I will mostly be working with the total_laid_off column as it contains the most important information

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- 12000 is the MAX(total laid off)

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- A 100% layoff means there are companies that laid off all its employees
-- Let's check companies with a 100% layoffs

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- A construction company(Katerra) in the United States had 2434 layoffs which means they went under
-- That's awful because they had about 1.6 million dollars in funding
-- Let's take a look at compaines that went under and the funds raised

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Britishvolt raised 2.4 million dollars and still went under


-- Let's explore layoffs in companies
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- We have big companies like AMAZON, GOOGLE, META with the highest layoffs

select *
from layoffs_staging2;

-- Let's take a look at the industry that had the most layoffs

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 ASC;

-- The consumer industry had the most layoffs, followed by retail, transportation, Finance and Healthcare
-- The lowest are: Manufacturing, FinTech, Aerospace, Energy, and the Legal industry.
-- They might have been affected by COVID wgich is just an assumption

-- Which industry had the most funding?

SELECT industry, MAX(funds_raised_millions)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 desc;

-- The media industry had the most funding
-- Let's see the amount of layoffs in the media industry

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
WHERE industry = 'Media';

--  A sum of 5234 layoffs in the media industry
-- That's reasonable comapred to the total sum of all layoffs(383659)

select industry, SUM(total_laid_off)
FROM layoffs_staging2
where industry != 'media'
group by industry
order by 1 DESC;

-- Let's explore countries

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 asc;

-- The top five countries with the most layoffs are: United States, India, Netherlands, Sweden, and Brazil
-- The lowest are: Poland, Chile, New Zealand, Luxemburg, and Thailand
-- This might be because of their population, or because of a bias in the data collection

-- lets'd check the countries with the most funding
SELECT country, MAX(funds_raised_millions)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- The countries with the most funding are: United States(121900), India, Netherlands, Lithuania, and the United Kingdom.
-- Funds raised in the United states is significantly more than the other companes which could be because of the population
-- of companies in the US or Bias in data collection or their GDP. The US is rich. These are all asumptions

SELECT *
FROM layoffs_staging2;

-- Let's check out the date colmun
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- It looks like it started in 2020-03-11 which was around the COVID period. And ended 2023-03-06 according to this dataset

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- In 2020, 80k people got laid off, 2022, over 160k got laid off. 
-- However, we only have 3 months of data for 2023 and they over 125k laoffs was recorded
-- which means it was lot higher by the end of 2023.

-- Let's check the stage column
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- This shows that companies in the POST-IPO STAGE, which are the big companies of the world had the highest layoffs



SELECT SUBSTRING(`date`,1,7) AS month, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Let's do a rolling sum of the result using a CTE

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS month, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- from the output given, by the end of 2020, there was about 81k layoffs, 2021 was a good year comparatively, 
-- in 2022 things got worse with thousands and thousands of layoffs.
--  Even rightbefore the holidays in DEC, there was 247k layoffs
-- the first 3 months of 2023 were devastating


-- We can break the rolling total into countries/companies

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

-- Let's find out which year they laid people off the most by doing a CTE

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

-- Uber had the biggest layoffs in 2020, which makes sense because of covid 19 lockdown. People weren't moving as much
-- Bytedance had the most layoffs in 2021
-- Meta in 2022 and Google in 2023

-- let's do another cte to see the amount laid off by each year by company. Basicallly adding another cte to the former cte

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *,
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5
;

-- from the output, the top 5 companies with the most layoffs in 2020 are: Uber, Booking.com, Groupon, Swiggy, and Airbnb
-- top 5 in 2021 are: Bytendance, Katerra, Zillow, Instacart, and WhiteHat Jr, 
-- 2022 had big companies like Meta, Amazon, Cisco
-- in 2023, companies like Gogle, Microsoft, Amazon, Ericsson had the most layoffs

-- Distribution of layoffs by funding stage
SELECT stage, COUNT(*) AS num_companies, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY 3 DESC;

-- companies in Post-IPO stage had the highest number of layoffs( companies-382, layoff-204132), followed by acquired companies

-- Average layoffs and funds raised by stage
SELECT stage,
	AVG(total_laid_off) AS AVG_LAYOFFS,
    AVG(funds_raised_millions) AS avg_funds_raised_mil
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- There seems to be a correlation between company stage, financial strength, and workforce reductions


-- Total funds raised by stage
SELECT stage, SUM(funds_raised_millions) AS total_funds_raised
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_funds_raised DESC;

-- POST-IPO stage companies raised the most funds. This could mean investors focus more on the big companies 


-- Stages and Layoffs Overtime
-- This helps analyze if certain stages were more affected in certain years, possibly aligning with broader economic changes

SELECT  stage, YEAR(`date`) AS date_year, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage, date_year
ORDER BY date_year, stage;








































































