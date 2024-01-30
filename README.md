# Murder Mystery 🔎
## Try the challenge at [mystery.knightlab.com](https://mystery.knightlab.com/)


### Solutions

Find witness details
```
SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND date = '20180115'
AND city = 'SQL City'
LIMIT 10;
```
