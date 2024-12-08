-- MENTAL HEALTH IN TECHSURVEY --

-- treatement by gender across countries --
SELECT gender, country, 
       COUNT(*) AS total_responses, 
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM tech_survey
GROUP BY gender, country;


-- impact of benefits on mental health --
SELECT benefits, 
       COUNT(*) AS total_responses, 
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM tech_survey
GROUP BY benefits;


-- Treatment Rates by Company Size --
SELECT no_employees, 
       COUNT(*) AS total_responses, 
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM tech_survey
GROUP BY no_employees
ORDER BY seeking_treatment DESC;


-- Consequences of Mental Health Issues --
SELECT mental_health_consequence, 
       COUNT(*) AS total_responses,
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM tech_survey
GROUP BY mental_health_consequence;


-- Year-Wise Trends in Mental Health --
SELECT YEAR(Date_entry) AS year, 
       COUNT(*) AS total_responses, 
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM tech_survey
GROUP BY year;


-- GLOBAL MENTAL HEALTH SURVEY --

--  Global Trends of a Specific Disorder --
SELECT Year, 
       AVG(`Depression (%)`) AS avg_depression_rate,
       AVG(`Anxiety disorders (%)`) AS avg_anxiety_disorder_rate
FROM depression
GROUP BY Year;


--  Top 5 Countries with the Highest Depression and Anxiety Disorder Rates --
SELECT Entity, AVG(`Anxiety disorders (%)`) AS avg_anxiety_disorder_rate,
AVG(`Depression (%)`) AS avg_depression_rate
FROM depression
GROUP BY Entity
ORDER BY avg_anxiety_disorder_rate,avg_depression_rate desc
LIMIT 5;


-- Compare Rates of Anxiety and Depression in a Specific Year --
SELECT distinct(Entity), AVG(`Anxiety disorders (%)`) AS avg_anxiety_disorder_rate,
AVG(`Depression (%)`) AS avg_depression_rate
FROM depression
WHERE Year in (2014,2015,2016)
group by entity
ORDER BY avg_anxiety_disorder_rate,avg_depression_rate DESC;


-- Countries with Increasing Rates of Disorder --
SELECT Entity, 
       MIN(Year) AS first_year, 
       MAX(Year) AS last_year,
       MIN(`Depression (%)`) AS min_depression_rate,
       MAX(`Depression (%)`) AS max_depression_rate,
       MIN(`Anxiety disorders (%)`) AS min_anxiety_rate,
       MAX(`Anxiety disorders (%)`) AS max_anxiety_rate
       FROM depression
GROUP BY Entity
HAVING max_depression_rate > min_depression_rate
and max_anxiety_rate > min_anxiety_rate;


-- COMBINED ANALYSIS --

-- prevalence of disorders in each country correlates with the proportion of tech employees seeking treatment --
SELECT country, 
       AVG(treatment = 'Yes') * 100 AS treatment_rate,
       AVG(depression_rate),
       AVG(anxiety_rate)
FROM combined_data
GROUP BY country;


--  gender-based differences in treatment-seeking behavior --
SELECT gender, 
       AVG(treatment = 'Yes') * 100 AS treatment_rate,
       AVG(anxiety_rate) AS avg_anxiety_rate,
       AVG(depression_rate) AS avg_depression_rate
FROM combined_data
GROUP BY gender;


--  Impact of Work Settings on Mental Health --
SELECT cd.remote_work, AVG(cd.depression_rate) AS avg_depression_rate, AVG(cd.anxiety_rate) AS avg_anxiety_rate
FROM combined_data cd
GROUP BY cd.remote_work;



-- Yearly Trends in Mental Health Disorders --
SELECT cd.year, AVG(cd.depression_rate) AS avg_depression_rate, AVG(cd.treatment = 'Yes') * 100 AS treatment_rate
FROM combined_data cd
GROUP BY cd.year;



-- Influence of Benefits and Care Options --
SELECT cd.benefits, AVG(cd.depression_rate) AS avg_depression_rate, AVG(cd.treatment = 'Yes') * 100 AS treatment_rate
FROM combined_data cd
GROUP BY cd.benefits;


