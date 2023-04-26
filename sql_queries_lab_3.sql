-- Leonardo Olmos Saucedo / SQL Queries Lab 3
USE sakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(a.last_name)) AS total_last_name
FROM actor a;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(DISTINCT(f.language_id)) AS total_languages 
FROM film f;

-- 3. How many movies were released with "PG-13" rating?
SELECT COUNT(*) AS total_movies
FROM film f
WHERE f.rating = 'PG-13';

-- 4. Get 10 the longest movies from 2006.
SELECT *
FROM film f
WHERE f.release_year = 2006
ORDER BY f.`length` DESC
LIMIT 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(r.rental_date), MIN(r.rental_date)) AS total_days
FROM rental r;

-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT r.*, MONTH(CONVERT(rental_date, date)) AS `month`, WEEKDAY(CONVERT(rental_date, date)) AS `weekday`
FROM rental r
LIMIT 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT r.*,
	CASE 
     WHEN WEEKDAY(CONVERT(rental_date, date)) IN (0, 1, 2, 3, 4) THEN 'workday'
     WHEN WEEKDAY(CONVERT(rental_date, date)) IN (5, 6) THEN 'weekend'
     ELSE "I don't know!"
	END AS day_Type
FROM rental r;

-- 8. How many rentals were in the last month of activity?
SELECT COUNT(*)
FROM rental r
WHERE DATE_FORMAT(r.rental_date, '%Y%m') = (SELECT DATE_FORMAT(MAX(r2.rental_date), '%Y%m') AS last_month FROM rental r2)
ORDER BY r.rental_date DESC;