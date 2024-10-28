-- Data Cleaning --SQL Project

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022



SELECT *
FROM layoffs;


-- WHEN CLEANING DATA, A FEW STEPS ARE USUALLY FOLLOWED:

-- 1. First thing is to create a staging table. This is the table i will work in and clean the data. 
--    I want to keep the raw data incase  something happens.
-- 2. Check for duplicates and remove any
-- 3. Standardize the Data and fix errors
-- 4. Look at Null values or blank values and see what to do with them
-- 5. Remove unnecessary rows and columns



-- Copying all data from layoffs to a new table in order to keep the raw data
CREATE TABLE layoffs_staging
LIKE layoffs;



SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


-- 1.  Removing Duplicates
-- # First, lets check for duplicates

SELECT *
FROM layoffs_staging;

-- This table does not have a row for unique IDs so it will be hard to find duplcates
-- Another way is to use the following steps


SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


-- Using 'Casper' to confirm the results

SELECT *
FROM layoffs_staging
WHERE company = "casper";


-- It is impossible to use the Delete function with the CTE here because of MySql 
-- A good idea is to create a new column  and add those row numbers in.
-- Then delete where row numbers are greater than 1, then delete that column
-- So i have to create a new table 'Layoffs_staging2", then add a new column called Row_num INT
-- Let's goo


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;


-- Inserting data into Layoffs_staging2

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
 `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Checking for duplicates and deleting them

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

DELETE
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2;


-- Standardizing the Data

SELECT *
FROM layoffs_staging2;

-- I have to check all the columns one by one to check for irregularities and fixing them
-- After fixing irregularities, i then have to update the table and set it to the correction

SELECT DISTINCT Company
FROM layoffs_staging2;

SELECT distinct (TRIM(Company))
from layoffs_staging2;

SELECT Company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT distinct industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging
WHERE industry IS NULL
OR industry = ' '
ORDER BY industry;

-- Changing Crypotocurrency to Crypto because they are in the same industry

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';



SELECT DISTINCT Location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- Let's also fix the date column
SELECT *
FROM layoffs_staging2;

-- We canuse STR to Date to update this field

SELECT `DATE`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

-- Now we can convert the data type properly

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;




-- Handling Null/Blank values

SELECT *
FROM layoffs_staging2;

-- It seems there are nulls in the total_laid_off & percentage_laif_off columns

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- There seems to be blank cells in the industry column so Iwill fill then wit "null" so it is easy to work with

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ' ';

select industry
from layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ' ';

SELECT *
FROM layoffs_staging
WHERE company LIKE 'Bally%';


SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE industry IS NULL OR indusry = ' '
AND industry IS NOT NULL;


SELECT industry
from layoffs_staging;


SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = ' ')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2;



-- Removing rows
-- Delete useless data we can't use

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

select *
from layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;



































