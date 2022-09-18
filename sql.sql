/*
Exercise 1 — Tasks
*/
--1.Find the title of each film 
SELECT title FROM movies;
--2.Find the director of each film
SELECT director FROM movies;
--3.Find the title and director of each film
SELECT title,director FROM movies;
--4.Find the title and year of each film
SELECT title,year FROM movies;
--5.Find all the information about each film
SELECT * FROM movies;

/*Exercise 2 — Tasks

*/

--1.Find the movie with a row id of 6 
SELECT * FROM movies where id=6
--2.Find the movies released in the years between 2000 and 2010
SELECT * FROM movies where year between 2000 and 2010
--3.Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies where year not between 2000 and 2010
--4.Find the first 5 Pixar movies and their release year
SELECT * FROM movies where id<6


/*Exercise 3 — Tasks
*/
--1.Find all the Toy Story movies 
SELECT * FROM movies where title LIKE "%Toy Story%";

--2.Find all the movies directed by John Lasseter
SELECT * FROM movies where  Director="John Lasseter";
--3.Find all the movies (and director) not directed by John Lasseter
SELECT * FROM movies where  Director!="John Lasseter";
--4.Find all the WALL-* movies
SELECT * FROM movies where  title LIKE "WALL-_";

/*
Exercise 4 — Tasks

*/
--1.List all directors of Pixar movies (alphabetically), without duplicates
SELECT * FROM movies GROUP BY Director;

--2.List the last four Pixar movies released (ordered from most recent to least)
SELECT * FROM movies order by year desc limit 4;

--3.List the first five Pixar movies sorted alphabetically
SELECT * FROM movies order by title asc limit 5;

--4.List the next five Pixar movies sorted alphabetically
SELECT * FROM movies order by title asc limit 5 offset 5;

/*
Review 1 — Tasks

*/
--1.List all the Canadian cities and their populations 
SELECT * FROM north_american_cities where Country="Canada";

--2.Order all the cities in the United States by their latitude from north to south
SELECT * FROM north_american_cities where Country="United States" order by latitude desc;

--3.List all the cities west of Chicago, ordered from west to east
SELECT * FROM north_american_cities where Longitude < (SELECT Longitude FROM north_american_cities where city="Chicago") order by Longitude
--4.List the two largest cities in Mexico (by population)
SELECT * FROM north_american_cities where Country="Mexico" order by Population desc limit 2

--5.List the third and fourth largest cities (by population) in the United States and their population
SELECT * FROM north_american_cities where Country="United States" order by Population desc limit 2 offset 2

/*
Exercise 6 — Tasks

*/
--1.Find the domestic and international sales for each movie 
SELECT * FROM movies
INNER JOIN Boxoffice
ON id = movie_id
--2.Show the sales numbers for each movie that did better internationally rather than domestically
SELECT * FROM movies
INNER JOIN Boxoffice
ON id = movie_id and Domestic_sales < International_sales
--3.List all the movies by their ratings in descending order
SELECT * FROM movies
INNER JOIN Boxoffice
ON id = movie_id order by rating desc


/*
Exercise 7 — Tasks


*/
--1.Find the list of all buildings that have employees 
SELECT distinct Building_name  FROM employees
left join Buildings
on Building=Building_name

--2.Find the list of all buildings and their capacity
SELECT * FROM  Buildings

--3.List all buildings and the distinct employee roles in each building (including empty buildings)

SELECT role,Building_name
FROM Buildings
left join employees
on Building=Building_name
group by role,Building_name

/*
Exercise 8 — Tasks
*/
--1.Find the name and role of all employees who have not been assigned to a building 
SELECT * FROM employees where Building Is null;

--2.Find the names of the buildings that hold no employees
SELECT Building_name
FROM Buildings
left join employees
on Building=Building_name
where role is null
/*
Exercise 9 — Tasks
*/
--1.List all movies and their combined sales in millions of dollars 

SELECT DISTINCT
    title,
    (domestic_sales + international_sales) / 1000000 AS sales
FROM movies
INNER JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

--2.List all movies and their ratings in percent

SELECT *,
    (rating * 10) AS rating
FROM movies
INNER JOIN boxoffice
    ON id = movie_id;

--3.List all movies that were released on even number years

SELECT title FROM movies WHERE year % 2 = 0;

/*
Exercise 10 — Tasks
*/

--1.Find the longest time that an employee has been at the studio 
SELECT max(Years_employed) FROM employees;
--2.For each role, find the average number of years employed by employees in that role
SELECT Role, AVG(Years_Employed) 
FROM Employees
GROUP BY Role;
--3.Find the total number of employee years worked in each building
SELECT Building, sum(Years_Employed) 
FROM Employees
GROUP BY Building

/*
Exercise 11 — Tasks
*/
--1.Find the number of Artists in the studio (without a HAVING clause) 
SELECT count(*) FROM employees where role="Artist"

--2.Find the number of Employees of each role in the studio
SELECT count(role),role FROM employees group by role;   

--3.Find the total number of years employed by all Engineers
SELECT sum(Years_employed) FROM employees where role="Engineer";

/*
Exercise 12 — Tasks
*/

--1.Find the number of movies each director has directed 
SELECT Director,count(*) FROM movies group by Director;

--2.Find the total domestic and international sales that can be attributed to each director
SELECT Director,sum(Domestic_sales+International_sales) as Total_Sales FROM movies
inner join Boxoffice
on id=movie_id
group by Director;

/*
Exercise 13 — Tasks

*/
--1.Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) 

INSERT INTO movies
(Title, Director, Year, Length_minutes)
VALUES ("Toy Story 4", "Pete Docter", 1999,87);

--2.Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.

INSERT INTO boxoffice
(movie_id, rating, Domestic_sales,International_sales)
VALUES (15, 8.7, 340000000,270000000);

/*
Exercise 14 — Tasks
*/
--1.The director for A Bug's Life is incorrect, it was actually directed by John Lasseter 
UPDATE Movies SET Director = "John Lasseter" WHERE Title="A Bug's Life"

--2.The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE Movies SET year = 1999 WHERE Title="Toy Story 2"

--3.Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE Movies SET title = "Toy Story 3",Director="Lee Unkrich"
WHERE Title="Toy Story 8"
/*
Exercise 15 — Tasks
*/
--1.This database is getting too big, lets remove all movies that were released before 2005. 
DELETE FROM Movies
WHERE Year<2005;
--2.Andrew Stanton has also left the studio, so please remove all movies directed by him.

DELETE FROM Movies
WHERE director="Andrew Stanton";

/*
Exercise 16 — Tasks

--1.Create a new table named Database with the following columns:
– Name A string (text) describing the name of the database
– Version A number (floating point) of the latest version of this database
– Download_count An integer count of the number of times this database was downloaded
This table has no constraints.
*/

CREATE TABLE Database (
    id INTEGER PRIMARY KEY,
    Name TEXT,
    Version INTEGER, 
    Download_count INTEGER
);


