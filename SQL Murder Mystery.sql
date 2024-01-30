-- SQL Murder Mystery
-- The SQL Murder Mystery (knightlab.com)

SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND date = '20180115'
AND city = 'SQL City'
LIMIT 10;

--Security footage shows that there were 2 witnesses.
--The first witness lives at the last house on "Northwestern Dr".
--The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

--id,name,license_id,address_number,address_street_name,ssn
--14887,Morty Schapiro,118009,4919,Northwestern Dr,111564949

SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
	AND name LIKE 'Annabel %'
LIMIT 10;

--id,name,license_id,address_number,address_street_name,ssn
--16371,Annabel Miller,490173,103	Franklin Ave,318771143

SELECT *
FROM interview
WHERE person_id = 14887
	OR person_id = 16371
LIMIT 10;

--the query above could also be written as...

SELECT *
FROM interview
WHERE person_id IN (14887,16371)
LIMIT 10;

-- 14887
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
-- The membership number on the bag started with "48Z".
-- Only gold members have those bags.
-- The man got into a car with a plate that included "H42W".
-- 16371
-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius

-- id	person_id	name	membership_start_date	membership_status
-- 48Z7A	28819	Joe Germuska	20160305	gold
-- 48Z55	67318	Jeremy Bowers	20160101	gold

SELECT *
FROM get_fit_now_member AS G
INNER JOIN person AS P ON G.person_id = P.id
INNER JOIN drivers_license as DL on DL.id = P.license_id
WHERE membership_status = 'gold'
AND G.id LIKE '48Z%'
AND plate_number LIKE '%H42W%'
LIMIT 10;

-- id	person_id	name	membership_start_date	membership_status	id	name	license_id	address_number	address_street_name	ssn	id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 48Z55	67318	Jeremy Bowers	20160101	gold	67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279	423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS

SELECT *
FROM interview
WHERE person_id = 67318
LIMIT 10;

-- person_id	transcript
-- 67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.
-- know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT person_id, COUNT(*)
FROM facebook_event_checkin
WHERE event_name LIKE '%SQL Symphony Concert%'
AND date LIKE '201712%'
GROUP BY person_id
HAVING COUNT(*) = 3
LIMIT 10;

-- person_id	COUNT(*)
-- 24556	3
-- 99716	3

