-- ============================================================
-- HR EMPLOYEE ATTRITION ANALYSIS
-- SQL ANALYSIS SCRIPT
-- ============================================================
-- Purpose:
-- Analyze employee attrition patterns and identify high-risk
-- employee segments using MySQL.
--
-- Dataset:
-- IBM HR Analytics Employee Attrition & Performance
--
-- Main business question:
-- Which employee segments are most likely to leave, and what
-- factors are associated with higher observed attrition?
-- ============================================================


-- ============================================================
-- 01. DATABASE SETUP
-- ============================================================
-- PURPOSE:
-- Create a dedicated database for this project.

CREATE DATABASE hr_attrition;

-- Select the HR attrition database as the active database.

USE hr_attrition;


-- BUSINESS QUESTION:
-- What structure should be used to store the employee data?
--
-- PURPOSE:
-- Create a table containing the 35 variables from the dataset.

CREATE TABLE employees (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(30),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);


-- BUSINESS QUESTION:
-- Does the employee table have the expected structure?
--
-- PURPOSE:
-- Inspect the table definition and verify the columns and
-- data types before beginning the analysis.

DESCRIBE employees;


-- BUSINESS QUESTION:
-- Which database is currently active?
--
-- PURPOSE:
-- Reconfirm the database context before running analysis queries.

USE hr_attrition;


-- ============================================================
-- 02. INITIAL DATA EXPLORATION
-- ============================================================

-- BUSINESS QUESTION:
-- How many rows are present in the employee table?
--
-- PURPOSE:
-- Check the total number of records and confirm that the data
-- was loaded successfully.

SELECT COUNT(*) AS total_rows
FROM employees;


-- BUSINESS QUESTION:
-- What does the employee data look like?
--
-- PURPOSE:
-- Preview a small sample of records to understand the structure
-- and values before performing detailed analysis.

SELECT *
FROM employees
LIMIT 5;


-- BUSINESS QUESTION:
-- How many employees are in the dataset?
--
-- PURPOSE:
-- Establish the total workforce size used throughout the analysis.

SELECT COUNT(*) AS total_employees
FROM employees;


-- BUSINESS QUESTION:
-- How many employees stayed and how many left?
--
-- PURPOSE:
-- Examine the distribution of the Attrition target variable.

SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;


-- ============================================================
-- 03. OVERALL ATTRITION
-- ============================================================

-- BUSINESS QUESTION:
-- What is the overall employee attrition rate?
--
-- PURPOSE:
-- Calculate the baseline attrition rate by comparing employees
-- who left with the total workforce.

SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;


-- ============================================================
-- 04. ATTRITION BY DEPARTMENT
-- ============================================================

-- BUSINESS QUESTION:
-- Which departments have the highest attrition?
--
-- PURPOSE:
-- Compare employee counts, employees who left, and attrition
-- rates across departments to identify higher-risk departments.

SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;


-- ============================================================
-- 05. ATTRITION BY JOB ROLE
-- ============================================================

-- BUSINESS QUESTION:
-- Which job roles have the highest attrition?
--
-- PURPOSE:
-- Identify job roles where employee turnover is relatively high
-- and may require closer HR attention.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- ============================================================
-- 06. ATTRITION BY OVERTIME
-- ============================================================

-- BUSINESS QUESTION:
-- How many employees work overtime?
--
-- PURPOSE:
-- Understand the size of each overtime group before comparing
-- their attrition rates.

SELECT
    OverTime,
    COUNT(*) AS total_employees
FROM employees
GROUP BY OverTime;


-- BUSINESS QUESTION:
-- Is attrition higher among employees who work overtime?
--
-- PURPOSE:
-- Compare attrition rates between overtime and non-overtime
-- employees.

SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY OverTime
ORDER BY attrition_rate DESC;


-- ============================================================
-- 07. JOB ROLE + OVERTIME
-- ============================================================

-- BUSINESS QUESTION:
-- Which job roles have higher attrition within overtime groups?
--
-- PURPOSE:
-- Combine job role and overtime to identify segments where
-- overtime is associated with particularly high observed attrition.

SELECT
    JobRole,
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole, OverTime
ORDER BY attrition_rate DESC;


-- ============================================================
-- 08. TENURE ANALYSIS
-- ============================================================

-- BUSINESS QUESTION:
-- What is the minimum, maximum, and average employee tenure?
--
-- PURPOSE:
-- Understand the overall distribution of YearsAtCompany before
-- creating tenure groups.

SELECT
    MIN(YearsAtCompany) AS minimum_tenure,
    MAX(YearsAtCompany) AS maximum_tenure,
    ROUND(AVG(YearsAtCompany), 2) AS average_tenure
FROM employees;


-- BUSINESS QUESTION:
-- Which tenure groups have the highest attrition?
--
-- PURPOSE:
-- Convert YearsAtCompany into business-friendly tenure bands
-- and compare attrition across employee lifecycle stages.

SELECT
    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany <= 5 THEN '3-5 Years'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years'
        ELSE '11+ Years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY tenure_group
ORDER BY attrition_rate DESC;


-- ============================================================
-- 09. INCOME ANALYSIS
-- ============================================================

-- BUSINESS QUESTION:
-- What is the minimum, maximum, and average monthly income?
--
-- PURPOSE:
-- Understand the overall compensation range before creating
-- income bands.

SELECT
    MIN(MonthlyIncome) AS minimum_income,
    MAX(MonthlyIncome) AS maximum_income,
    ROUND(AVG(MonthlyIncome), 2) AS average_income
FROM employees;


-- BUSINESS QUESTION:
-- Which income bands have the highest attrition?
--
-- PURPOSE:
-- Group employees into practical income ranges and compare
-- attrition rates across compensation levels.

SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN '<3000'
        WHEN MonthlyIncome < 5000 THEN '3000-4999'
        WHEN MonthlyIncome < 8000 THEN '5000-7999'
        WHEN MonthlyIncome < 12000 THEN '8000-11999'
        ELSE '12000+'
    END AS income_band,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY income_band
ORDER BY attrition_rate DESC;


-- ============================================================
-- 10. HIGH-RISK JOB ROLES
-- ============================================================

-- BUSINESS QUESTION:
-- Which job roles have an attrition rate above 20%?
--
-- PURPOSE:
-- Narrow the role analysis to job roles with relatively high
-- observed attrition.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole
HAVING attrition_rate > 20
ORDER BY attrition_rate DESC;


-- ============================================================
-- 11. EARLY-TENURE ANALYSIS
-- ============================================================

-- BUSINESS QUESTION:
-- Which job roles have the highest attrition among employees
-- with 0–2 years at the company?
--
-- PURPOSE:
-- Investigate whether early-tenure employees represent a
-- higher-risk population within specific job roles.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
WHERE YearsAtCompany <= 2
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- ============================================================
-- 12. EARLY TENURE + OVERTIME
-- ============================================================

-- BUSINESS QUESTION:
-- Which job roles show high attrition among employees with
-- 0–2 years of tenure who also work overtime?
--
-- PURPOSE:
-- Combine two potential risk signals—early tenure and overtime—
-- to identify more specific high-risk employee segments.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
WHERE YearsAtCompany <= 2
  AND OverTime = 'Yes'
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- BUSINESS QUESTION:
-- Which early-tenure + overtime job roles have at least
-- 20 employees in the segment?
--
-- PURPOSE:
-- Reduce the risk of over-interpreting very small groups by
-- applying a minimum segment-size threshold.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
WHERE YearsAtCompany <= 2
  AND OverTime = 'Yes'
GROUP BY JobRole
HAVING COUNT(*) >= 20
ORDER BY attrition_rate DESC;


-- ============================================================
-- 13. EARLY TENURE + LOW INCOME + OVERTIME
-- ============================================================

-- BUSINESS QUESTION:
-- Among employees with 0–2 years of tenure and monthly income
-- below 3000, how does attrition differ by overtime status?
--
-- PURPOSE:
-- Examine the combined relationship between early tenure,
-- lower income, overtime, and attrition.

SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
WHERE YearsAtCompany <= 2
  AND MonthlyIncome < 3000
GROUP BY OverTime
ORDER BY attrition_rate DESC;


-- BUSINESS QUESTION:
-- Which job roles are most at risk among employees who have
-- 0–2 years of tenure, income below 3000, and work overtime?
--
-- PURPOSE:
-- Identify highly specific high-risk segments while requiring
-- at least 10 employees in each segment for more reliable rates.

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
WHERE YearsAtCompany <= 2
  AND MonthlyIncome < 3000
  AND OverTime = 'Yes'
GROUP BY JobRole
HAVING COUNT(*) >= 10
ORDER BY attrition_rate DESC;


-- ============================================================
-- 14. SATISFACTION ANALYSIS
-- ============================================================

-- BUSINESS QUESTION:
-- How does job satisfaction relate to employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across the four JobSatisfaction
-- rating levels.

SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;


-- BUSINESS QUESTION:
-- How does work environment satisfaction relate to attrition?
--
-- PURPOSE:
-- Compare attrition rates across EnvironmentSatisfaction levels
-- to identify whether satisfaction with the work environment
-- differs between employees who stay and leave.

SELECT
    EnvironmentSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;


-- ============================================================
-- 15. DATA QUALITY CHECKS
-- ============================================================

-- BUSINESS QUESTION:
-- Are important fields missing values?
--
-- PURPOSE:
-- Check for NULL values in key columns used in the attrition
-- analysis before relying on the results.

SELECT
    COUNT(*) AS total_rows,
    SUM(Age IS NULL) AS Age_nulls,
    SUM(Attrition IS NULL) AS Attrition_nulls,
    SUM(Department IS NULL) AS Department_nulls,
    SUM(MonthlyIncome IS NULL) AS Income_nulls,
    SUM(YearsAtCompany IS NULL) AS Tenure_nulls
FROM employees;


-- BUSINESS QUESTION:
-- Are there duplicate EmployeeNumber values?
--
-- PURPOSE:
-- Check whether the employee identifier appears more than once,
-- which could indicate duplicate employee records.

SELECT
    EmployeeNumber,
    COUNT(*) AS record_count
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


-- ============================================================
-- END OF HR EMPLOYEE ATTRITION ANALYSIS
-- ============================================================
-- Key analytical themes:
--   • Overall attrition
--   • Department and job-role differences
--   • Overtime
--   • Tenure
--   • Income bands
--   • Satisfaction
--   • Multi-factor high-risk segments
--   • Data quality
--
-- Note:
-- These queries identify associations and patterns in the
-- observed dataset. They do not establish causation.
-- ============================================================
