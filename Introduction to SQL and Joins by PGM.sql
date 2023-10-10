--Ejercicio1
select title, replacement_cost, rental_rate
from film
where rental_rate between 0.99 and 3.99

--Ejercicio2
SELECT release_year, rental_duration, rental_rate, replacement_cost, rating, category 
from film
join film_category on film.film_id=film_category.film_id 
JOIN category ON film_category.category_id=category.category_id
where release_year = 2006
	and (rental_rate = 0.99 or rental_rate = 2.99)
	and replacement_cost <= 19.99
	and length >=90 and length <= 150
	and rating in ('G', 'PG', 'PG-13')
	and rental_duration <= 5
	and (category.name LIKE 'Comedy' OR category.name LIKE 'Family' OR category.name LIKE 'Children')
	

--Ejercicio3
SELECT
TO_CHAR(r.rental_date, 'dd-mm-yyyy') AS "Fecha de renta",
TO_CHAR(r.rental_date, 'HH24:MI') AS "Hora de renta",
film.title AS "Título",
CONCAT(c.first_name, ' ', c.last_name) AS "Cliente", 
customer.email as "Email",
customer.phone as "Telefono",
CONCAT(a.address, '. ', a.district, ', ', a.postal_code, '. ', ci.city, ', ', ci.country) AS "Dirección Completa del Cliente",
CONCAT(s.first_name, ' ', s.last_name) AS "Nombre staff"
from rental r,
	join customer c ON r.customer_id=c.customer_id
	join address a ON c.address_id=a.address_id
	join staff s ON r.staff_id=s.staff_id
	join city ci ON a.city_id=ci.city_id
where rental.rental_date::date='2005-07-31'
order by rental.rental_date


--Ejercicio4
SELECT 
    TO_CHAR(r.rental_date, 'DD-MON-YYYY') AS "Fecha de Renta",
    TO_CHAR(r.rental_date, 'HH24:MI') AS "Hora de Renta",
    CONCAT(c.first_name, ' ', c.last_name) AS "Nombre",
    a.phone AS "Teléfono Cliente",
    co.country AS "País de Cliente",
    CONCAT(s.first_name, ' ', s.last_name) AS "Nombre del Empleado",
    a.phone AS "Telefono staff",
    co2.country AS "País staff"
FROM rental r
JOIN staff s ON r.staff_id=s.staff_id
JOIN address a ON s.address_id=a.address_id
JOIN city ci ON a.city_id=ci.city_id
JOIN country co2 ON ci.country_id=co2.country_id
JOIN customer c ON r.customer_id=c.customer_id
JOIN address a2 ON c.address_id=a2.address_id
JOIN city ci2 ON a2.city_id=ci2.city_id
JOIN country co ON ci2.country_id=co.country_id
WHERE r.rental_date::date='2022-06-12'
ORDER BY r.rental_date


--Ejercicio5
SELECT
    r.rental_id,
    f.title AS "Película",
    f.rental_rate AS "Tarifa de Renta",
    p.amount AS "Pago realizado"
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE r.rental_date >= '2005-08-01' AND r.rental_date < '2005-09-01'
    AND f.rental_rate <> p.amount
ORDER BY r.rental_id;
