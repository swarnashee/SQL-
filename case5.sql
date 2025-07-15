reate database Harry_Potter;

use Harry_Potter;

/*Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age. */

select distinct power from wands 
where( select wands.code, ID, coins_needed, power
FROM wands, wands_property     
where wands.code = wands_property.code
order by power desc)
order by age desc;

select distinct power, wands.code, ID, coins_needed,  wands_property.age
FROM wands, wands_property     
where wands.code = wands_property.code
order by power desc, age desc;

select distinct power, wands.ID, coins_needed,  wands_property.age
FROM wands, wands_property     
where wands.code = wands_property.code
group by age
order by power desc;

select distinct power, wands.ID, coins_needed,  wands_property.age
FROM wands, wands_property     
where wands.code = wands_property.code
order by age desc, power ;
