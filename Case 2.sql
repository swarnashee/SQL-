use items_customer;

select order_date
from items_ordered;

select order_date, str_to_date(order_date, "%d-%m-%Y")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from items_ordered;     
                                              /* Y for 2021, m for months no, M for August, dd for 12,01 */
SET SQL_SAFE_UPDATES = 0;

update items_ordered
set order_date  = str_to_date(left(order_date,10), "%d-%m-%Y");  

/* Excercise 1, */

select customerid, item, price
from items_ordered
where customerid = 10449;

select * 
from items_ordered
where item = "Tent";

select customerid, order_date, price, item
from items_ordered
where item like "S%";

select distinct item
from items_ordered;

/* Excercise 2, */

select max(price), item
from items_ordered;

select avg(price), item, order_date,
monthname(order_date) as m
from items_ordered
where order_date in (12);

select count(*) as totalrows
from items_ordered;

select min(price), item 
from items_ordered
where item = "Tent";

/* Excercise 3 */

select  distinct state, count(customerid) as totalpeople
from customers
group by state;

select item, max(price), min(price)
from items_ordered
group by item;

select customerid, item, count(*) as NoofOrder, sum(quantity*price) as SumofOrder
from items_ordered
group by customerid;

/* Excercise 4 */

select state, count(*) as noofPeople
from customers
group by state
having count(*)>1;

select item, max(price), min(price)
from items_ordered
group by item
having max(price) > 190;

select customerid, item, count(*) as NoofOrder, sum(quantity) as totalQ
from items_ordered
group by customerid
having sum(quantity)>1;

/* Excercise 5 */

SELECT firstname, lastname, city
from customers
order by lastname; 

SELECT firstname, lastname, city
from customers
order by lastname desc; 

select item, price
from items_ordered
where  price>10
order by price;

/* Excercise 6 */

select customerid, order_date, item
from items_ordered
where item not like "Snow Shoes" and item not like "Ear Muffs";

select customerid, order_date, item
from items_ordered
where item not in ("Snow Shoes" , "Ear Muffs");


select  item, price
from items_ordered
where item like "s%" or item like "p%" or item like "f%";

select  item, price
from items_ordered
where item regexp "^[spf]";

select  item, price
from items_ordered
where item regexp "^(S|P|F)";

/* Excercise 7 */

select  order_date, item, price
from items_ordered
where price between 10 and 80;

SELECT firstname, state, city
from customers
 where state in ("Arizona", "Washington", "Oklahoma", "Colorado", "Hawai");
 
 /* Excercise 8 */
 
 select item, sum(price)/sum(quantity) as priceperunit
 from items_ordered
 group by item;
 
 /* Excercise 9 */
 
 select *
from items_ordered JOIN customers
ON items_ordered.customerid = customers.customerid;

 select *
from items_ordered JOIN customers
ON items_ordered.customerid = customers.customerid
order by state desc;