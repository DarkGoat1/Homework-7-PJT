use sakila

#1a
select first_name, 
last_name
FROM actor


#1b

select 
UPPER(CONCAT(first_name, ' ', last_name)) as 'FullName'
FROM actor

#2a
select *
FROM actor
WHERE first_name = 'Joe'

#2b
select *
FROM actor
WHERE last_name LIKE "%GEN%"

#2b Any combo of G, E or N or GEN in sequence? see below. Proof of concept applies to 2c

select *
FROM actor
WHERE last_name LIKE "%G%"
AND last_name LIKE "%E%"
AND last_name LIKE "%N%"

#2c

select *
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name

#2d

SELECT country_id,
country
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China')

#3a

ALTER TABLE actor
ADD COLUMN description BLOB

#3b screw this

ALTER TABLE actor
DROP COLUMN description

#4a

SELECT 
last_name,
count(last_name)
FROM actor
GROUP BY last_name

#4b

SELECT 
last_name,
count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name) > 1

#4c

select *
FROM actor
WHERE first_name = 'Groucho'

UPDATE actor
   SET first_name = 'Harpo' 
   WHERE actor_id = 172;
   
#4d

UPDATE actor
   SET first_name = 'Groucho' 
   WHERE first_name = 'Harpo';
   
#5a
SELECT *
FROM Address

#6a
Select
s.first_name,
s.last_name,
a.address
FROM staff s
JOIN address a ON s.address_id = a.address_id



#6b
Select
s.first_name,
SUM(p.amount)
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE payment_date LIKE "%2005-08%"
GROUP BY s.first_name

#6c
select f.title,
COUNT(f.title) as 'count of actors'
FROM film f
join film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title

#6d

select f.title,
COUNT(f.film_id)
from inventory i
join film f ON i.film_id = f.film_id
Where f.title = "Hunchback Impossible"

#6e

SELECT c.customer_id,
c.first_name,
c.last_name,
SUM(p.amount) as 'total spend'
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name

#7a

SELECT *
FROM Film f
WHERE f.title LIKE "K%"
OR f.title LIKE "Q%"
AND f.language_id = 1

#7b
select f.title,
a.first_name,
a.last_name
FROM film f
join film_actor fa ON f.film_id = fa.film_id
join actor a ON a.actor_id = fa.actor_id
WHERE f.title = "Alone Trip"

#7c
select c.first_name,
c.last_name,
c.email,
co.country
FROM customer c
JOIN address a ON a.address_id= c.address_id
join city ci ON ci.city_id = a.city_id
join country co ON co.country_id = ci.country_id
WHERE co.country = "Canada"

#7d

select *
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.category_id = 8

#7e

SELECT f.title,
COUNT(rental_id) AS 'total rentals'
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY COUNT(rental_id) desc

#7f staff id = store id

SELECT r.staff_id as 'Store Number',
SUM(p.amount) as 'Total Business'
FROM rental r
JOIN payment p ON r.rental_id = p.payment_id
GROUP BY r.staff_id

#7g

select s.store_id,
ci.city,
co.country
from store s
JOIN address a ON a.address_id = s.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id

#7h

SELECT c.name,
SUM(p.amount)
FROM rental r
JOIN payment p ON r.rental_id = p.payment_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY sum(p.amount) desc
LIMIT 5

#8a, b + c

create view top_genres AS
SELECT c.name,
SUM(p.amount)
FROM rental r
JOIN payment p ON r.rental_id = p.payment_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY sum(p.amount) desc
LIMIT 5

select * FROM top_genres


DROP VIEW top_genres
