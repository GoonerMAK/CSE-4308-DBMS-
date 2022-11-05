

--1

SELECT ACT_FIRSTNAME, ACT_LASTNAME FROM ACTOR, DIRECTOR 
WHERE ACTOR.ACT_FIRSTNAME = DIRECTOR.DIR_FIRSTNAME AND ACTOR.ACT_LASTNAME = DIRECTOR.DIR_LASTNAME;

SELECT ACT_FIRSTNAME, ACT_LASTNAME FROM ACTOR
INTERSECT
SELECT DIR_FIRSTNAME, DIR_LASTNAME FROM DIRECTOR;



--2

SELECT ACT_FIRSTNAME FROM ACTOR
UNION
SELECT DIR_FIRSTNAME FROM DIRECTOR;


--3  (280 to 590)


SELECT MOV_TITLE FROM MOVIE 
MINUS
SELECT MOV_TITLE FROM MOVIE, RATING
WHERE MOVIE.MOV_ID = RATING.MOV_ID;

SELECT MOV_TITLE FROM MOVIE WHERE MOVIE.MOV_ID NOT IN (SELECT RATING.MOV_ID FROM RATING);


--4


SELECT MOV_TITLE, AVG(NVL(REV_STARS,0)) FROM MOVIE, RATING
WHERE MOVIE.MOV_ID = RATING.MOV_ID
GROUP BY MOVIE.MOV_TITLE;


--5

SELECT MOV_TITLE, MIN(NVL(REV_STARS, 0)) AS MINIMUM_RATING FROM MOVIE,RATING 
WHERE MOVIE.MOV_ID = RATING.MOV_ID
GROUP BY MOV_TITLE
ORDER BY MINIMUM_RATING DESC; 


--6

SELECT ACTOR.ACT_LASTNAME, COUNT(RATING.MOV_ID) FROM ACTOR, RATING, CASTS 
WHERE CASTS.MOV_ID = RATING.MOV_ID  AND ACTOR.ACT_ID = CASTS.ACT_ID 
GROUP BY ACT_LASTNAME; 


--7

SELECT ACTOR.ACT_LASTNAME, AVG(MOV_TIME) from MOVIE, ACTOR, CASTS
WHERE CASTS.ACT_ID = ACTOR.ACT_ID  AND  MOVIE.MOV_ID = CASTS.MOV_ID 
GROUP BY ACTOR.ACT_LASTNAME
MINUS 
SELECT ACTOR.ACT_LASTNAME, AVG(MOV_TIME) FROM ACTOR, CASTS, MOVIE, DIRECTION, DIRECTOR
WHERE CASTS.ACT_ID = ACTOR.ACT_ID  AND
          MOVIE.MOV_ID = CASTS.MOV_ID AND MOVIE.MOV_ID = DIRECTION.MOV_ID AND
                 DIRECTION.DIR_ID = DIRECTOR.DIR_ID AND
                         (DIRECTOR.DIR_FIRSTNAME = 'James' AND DIRECTOR.DIR_LASTNAME = 'Cameron')
GROUP BY ACTOR.ACT_LASTNAME;



SELECT ACTOR.ACT_LASTNAME, AVG(MOV_TIME) from MOVIE, ACTOR, CASTS, DIRECTOR, DIRECTION
HAVING (CASTS.ACT_ID = ACTOR.ACT_ID  AND
          MOVIE.MOV_ID = CASTS.MOV_ID AND MOVIE.MOV_ID = DIRECTION.MOV_ID AND
                 DIRECTION.DIR_ID = DIRECTOR.DIR_ID AND
                         (DIRECTOR.DIR_FIRSTNAME = 'James' AND DIRECTOR.DIR_LASTNAME = 'Cameron'))
GROUP BY ACTOR.ACT_LASTNAME;



--8
SELECT DIR_FIRSTNAME, DIR_LASTNAME FROM DIRECTOR;

SELECT MOV_ID, AVG(NVL(REV_STARS,0)) AS AVG_STARS 
FROM RATING 
GROUP BY MOV_ID 
ORDER BY AVG_STARS DESC;


SELECT MOV_TITLE, AVG(REV_STARS) as average
FROM MOVIE
INNER JOIN RATING ON Movie.MOV_ID = Rating.MOV_ID
GROUP BY MOV_TITLE
HAVING  AVG(REV_STARS) = (
SELECT MAX(avg_stars)
FROM (
SELECT MOV_TITLE, AVG(REV_STARS) AS avg_stars
FROM MOVIE
INNER JOIN RATING ON Rating.MOV_ID = Movie.MOV_ID
GROUP BY movie.MOV_ID, MOV_TITLE
) I
);



--9

SELECT MOVIE.MOV_TITLE, MOVIE.MOV_ID, MOV_YEAR, MOV_LANGUAGE, MOV_RELEASEDATE, MOV_COUNTRY FROM MOVIE, DIRECTOR, ACTOR, DIRECTION, CASTS
WHERE CASTS.ACT_ID = ACTOR.ACT_ID  AND
          MOVIE.MOV_ID = CASTS.MOV_ID AND MOVIE.MOV_ID = DIRECTION.MOV_ID AND
                 DIRECTION.DIR_ID = DIRECTOR.DIR_ID AND
                        DIR_FIRSTNAME = ACT_FIRSTNAME AND DIR_LASTNAME = ACT_LASTNAME;




--10


SELECT MOV_TITLE, AVG_RATING
FROM(SELECT MOV_TITLE, AVG(NVL(REV_STARS,0)) AS AVG_RATING
FROM MOVIE, RATING
WHERE MOVIE.MOV_ID = RATING.MOV_ID
GROUP BY MOVIE.MOV_TITLE)
WHERE AVG_RATING > 7;


SELECT MOV_TITLE, AVG(NVL(REV_STARS,0))
FROM MOVIE, RATING
WHERE MOVIE.MOV_ID = RATING.MOV_ID
GROUP BY MOVIE.MOV_TITLE
HAVING AVG(NVL(REV_STARS,0)) > 7;


--11

SELECT MOV_TITLE FROM MOVIE, RATING WHERE MOVIE.MOV_ID = RATING.MOV_ID
GROUP BY MOVIE.MOV_TITLE
HAVING AVG(NVL(REV_STARS,0)) > (SELECT AVG(NVL(REV_STARS,0)) FROM RATING);


--12

SELECT DISTINCT MOV_TITLE, (SELECT AVG(NVL(REV_STARS,0)) FROM RATING WHERE MOVIE.MOV_ID = RATING.MOV_ID) as AVERAGE
FROM MOVIE, RATING
WHERE MOVIE.MOV_ID = RATING.MOV_ID;


--13

SELECT DISTINCT a.ACT_FIRSTNAME, b.ACT_LASTNAME AS Shared_FirstName
FROM Actor a INNER JOIN Actor b ON a.ACT_FIRSTNAME = b.ACT_FIRSTNAME 
WHERE ( (a.ACT_ID != b.ACT_ID)  AND a.ACT_GENDER = 'F');


SELECT ACT_FIRSTNAME ,COUNT(*) AS Occurrence 
FROM ACTOR 
WHERE ACT_GENDER = 'F'
GROUP BY ACT_FIRSTNAME HAVING COUNT(*)>1; 


--14


