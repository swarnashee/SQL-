CREATE database SPOTIFY;


select * from  cleaned_dataset;

/*max min duration*/

select max(Duration_min) from cleaned_dataset;
select min(Duration_min) from cleaned_dataset;

delete from cleaned_dataset
where Duration_min =0;

/* no channel publish on spotify*/

select count(distinct `Channel`) from cleaned_dataset;


/* TOP 10 MOST VIEWED TRACK*/

SELECT Track, Artist, Views
FROM cleaned_dataset
ORDER BY Views DESC
LIMIT 10;

/*AVERAGE ENERGY PER ALBUM TYPE*/

SELECT Album_type, ROUND(AVG(Energy), 2) AS Avg_Energy
FROM cleaned_dataset
GROUP BY Album_type;

/*MOST STREAMED ARTIST*/

SELECT Artist, SUM(Stream) AS Total_Stream
FROM cleaned_dataset
GROUP BY Artist
ORDER BY Total_Stream DESC
LIMIT 1;

/*TOP PERFORMING ARTIST BY STREAM*/

SELECT Artist, SUM(Stream) AS Total_Streams
FROM cleaned_dataset
GROUP BY Artist
ORDER BY Total_Streams DESC
LIMIT 10;

/*MOST VIEWED TRACK ON YOU TUBE*/

SELECT Track, Artist, Views
FROM cleaned_dataset
ORDER BY Views DESC
LIMIT 10;

/*TOP LIKED TRACK BY ARTISH */
SELECT Artist, Track, Likes
FROM cleaned_dataset
ORDER BY Likes DESC
LIMIT 10;

/*AVERAGE AUDION FEATURES PER ALBUM*/

SELECT Album_type,
       ROUND(AVG(Danceability), 2) AS Avg_Danceability,
       ROUND(AVG(Energy), 2) AS Avg_Energy,
       ROUND(AVG(Valence), 2) AS Avg_Valence
FROM cleaned_dataset
GROUP BY Album_type;

/*TRACK POPULARITY SCORE*/

SELECT Track, Artist,
       (Views + Likes + Comments + Stream) AS Popularity_Score
FROM cleaned_dataset
ORDER BY Popularity_Score DESC
LIMIT 10;

/*MOST FREQUENT ALBUM PER ARTIST*/
SELECT Artist, Album_type, COUNT(*) AS Count
FROM cleaned_dataset
GROUP BY Artist, Album_type
ORDER BY Count DESC;

/*OFFICIAL VIDEOS VS VIEWS*/

SELECT official_video, ROUND(AVG(Views), 0) AS Avg_Views
FROM cleaned_dataset
GROUP BY official_video;

/*which features drive high stream count*/
SELECT 
  CASE 
    WHEN Energy > 0.7 THEN 'High Energy'
    WHEN Energy BETWEEN 0.4 AND 0.7 THEN 'Medium Energy'
    ELSE 'Low Energy'
  END AS Energy_Level,
  ROUND(AVG(Stream), 0) AS Avg_Streams
FROM cleaned_dataset
GROUP BY Energy_Level;

/*Licensing impact on views*/

SELECT Licensed, ROUND(AVG(Views), 0) AS Avg_Views
FROM cleaned_dataset
GROUP BY Licensed;

/*longest tracks with high engagement*/

SELECT Track, Artist, Duration_min, Views
FROM cleaned_dataset
WHERE Duration_min > 3
ORDER BY Views DESC
LIMIT 10;

/* find song which has more that 1 billion*/

/*Total number of comments for tracks where licensed = True*/

select sum(comments) as `Total Comments`
from cleaned_dataset
where licensed = 'true';

/* find the tracks that belongs to album type single*/

select * from cleaned_dataset
where Album_type = 'single';

/*count total number of tracks by each artist*/

select Artist, count(*) as Total_No_Songs
 from cleaned_dataset
group by Artist;

/* ***********************/
/* avg Danceability to track each album*/

select Album, avg(Danceability)
from cleaned_dataset
group by Album 
order by 2 desc;

/* top 5 track based on avg energy value*/

select track, avg(Energy)
from cleaned_dataset
group by track
order by 2 desc
limit 5;

/* List all the track with their views and  likes where official video = TRUE*/

select Track,sum(Views) as Total_Views,
sum(Likes) as Total_Likes
from cleaned_dataset
where official_video = 'True'
group by 1
order by 2 desc
limit 5;


/*for each album calculate the total views for all tracks*/

 select Album, track, sum(Views)
 from cleaned_dataset
 group by 1,2
 order by 3 desc;
 
/* top 3 most viewed tracks for each window function*/

select Artist,Track,sum(Views)
from cleaned_dataset
group by 1,2
order by 1,3 desc;
 
