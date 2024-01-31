# Murder Mystery 🔎
## Try the challenge at [mystery.knightlab.com](https://mystery.knightlab.com/)
## Full SQL and notes in the downloads

### Solution

Find witness details from a murder on 15th January 2018 in SQL City
```
SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND date = '20180115'
AND city = 'SQL City'
LIMIT 10;
```
Security footage shows that there were 2 witnesses, let's find them.
The first witness lives at the last house on "Northwestern Dr".
```
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;
```
The second witness, named Annabel, lives somewhere on "Franklin Ave".
```
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
AND name LIKE 'Annabel %'
LIMIT 10;
```
We have information on both witnesses, now we want to use the person_id to search for their interview transcript
```
SELECT *
FROM interview
WHERE person_id = 14887
	OR person_id = 16371
LIMIT 10;

Note - the query above could also be written as:

SELECT *
FROM interview
WHERE person_id IN (14887,16371)
LIMIT 10;
```
The interviews highlighted key information. We now want to search for individuals with a gold membership at the gym, a membership that contains '48Z' and a registration plate that contains 'H42W'
```
SELECT *
FROM get_fit_now_member AS G
INNER JOIN person AS P ON G.person_id = P.id
INNER JOIN drivers_license as DL on DL.id = P.license_id
WHERE membership_status = 'gold'
AND G.id LIKE '48Z%'
AND plate_number LIKE '%H42W%'
LIMIT 10;
```
We have narrowed this down to one individual. Let's look for their interview transcript
```
SELECT *
FROM interview
WHERE person_id = 67318
LIMIT 10;
```
It is indicated that someone else is behind the murders so we need to search for an individual who has been to the SQL Symphony Concert 3 times in December 2017
```
SELECT person_id, COUNT(*)
FROM facebook_event_checkin
WHERE event_name LIKE '%SQL Symphony Concert%'
AND date LIKE '201712%'
GROUP BY person_id
HAVING COUNT(*) = 3
LIMIT 10;
```
