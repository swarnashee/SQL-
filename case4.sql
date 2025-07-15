create database taxi;
use taxi;

SET SQL_SAFE_UPDATES = 0;

select pickup_date, str_to_date(pickup_date, "%d-%m-%Y")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from data; 

update data
set pickup_date  = str_to_date(left(pickup_date,10), "%d-%m-%Y"); 

select pickup_time, str_to_date(pickup_time, "%H:%i")                 
from data; 

update data
set pickup_time = str_to_date(left(pickup_time,5), "%H:%i"); 

select pickup_datetime, str_to_date(pickup_datetime, "%d-%m-%Y %H:%i")                  
from data;

update data
set pickup_datetime = str_to_date(left(pickup_datetime,16), "%d-%m-%Y %H:%i"); 

select Confirmed_at, str_to_date(Confirmed_at, "%d-%m-%Y %H:%i")                  
from data;

update data
set Confirmed_at = str_to_date(left(Confirmed_at,16), "%d-%m-%Y %H:%i"); 

/*2	Make a table with count of bookings with booking_type = p2p catgorized by booking mode as 'phone', 'online','app',etc */

select Booking_mode, Booking_id, count(*) as cntinfo
from data
where Booking_type = "p2p"
group by Booking_mode;

/* 4:Find top 5 drop zones in terms of  average revenue	*/

select DropArea, avg(Fare) as revenue
from data
group by DropArea
order by 2 desc;

/*5	Find all unique driver numbers grouped by top 5 pickzones */

select distinct Driver_number , PickupArea, zone_id, Area
from data as D inner join localities as L
on D.PickupArea = L.Area
group by PickupArea
order by sum(Fare) desc limit 5;

/*7	Make a hourwise table of bookings for week between Nov01-Nov-07 and highlight the hours with more than average no.of bookings day wise */

/*Done in two parts, and then combined later  */ 

/* Part 1 Hour-wise no. of bookings */

Select Hour (pickup_time), pickup_date, Count(*)
FROM data
WHERE pickup_date between "01-11-2013" and "07-11-2013"
Group By Hour(pickup_time);

/* Part 2 – Avge Daily Bookings */

Select Avg(Booking_id) as AvgDayWiseBookings
From (Select Pickup_date, Count(*) as Bookings
FROM data
WHERE pickup_date between "01-11-2013" and "07-11-2013"
Group By pickup_date);

/* Combined Solution – Q7:*/

Select Hour(Pickup_time), Count(*)
FROM data
WHERE pickup_date between 01-11-2013 and 07-11-2013
Group By Hour(pickup_time)
HAVING Count(*) >
(Select Avg(Bookings) as AvgDayWiseBookings
From (Select Pickup_date, Count(*) as Bookings
FROM data
WHERE pickup_date between 01-11-2013 and 07-11-2013
Group By pickup_date));
