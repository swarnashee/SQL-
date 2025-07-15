use items_customer;

select order_date
from items_ordered;

select order_date, str_to_date(order_date, "%d-%m-%Y")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from items_ordered;     
                                              /* Y for 2021, m for months no, M for August, dd for 12,01 */
SET SQL_SAFE_UPDATES = 0;

update items_ordered
set order_date  = str_to_date(left(order_date,10), "%d-%m-%Y");  

/* Excercise 1, 
(Comparison Operators) 
1. From the items_ordered table, select a list of all items purchased for customerid 10449. 
Display the customerid, item, and price for this customer.
2. Select all columns from the items_ordered table for whoever purchased a Tent.
3. Select the customerid, order_date, and item values from the items_ordered table for any 
items in the item column that start with the letter "S".
4. Select the distinct items in the items_ordered table. In other words, display a listing of each 
of the unique items from the items_ordered table.*/

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

/* Excercise 2, 
(Aggregate Functions) 
1. Select the maximum price of any item ordered in the items_ordered table. Hint: Select the 
maximum price only.
2. Select the average price of all of the items ordered that were purchased in the month of Dec.
3. What are the total number of rows in the items_ordered table?
4. For all of the tents that were ordered in the items_ordered table, what is the price of the lowest 
tent? Hint: Your query should return the price only.
*/

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

/* Excercise 3  (Group By clause) 
1. How many people are in each unique state in the customers table? Select the state and display 
the number of people in each. Hint: count is used to count rows in a column, sum works on 
numeric data only.
2. From the items_ordered table, select the item, maximum price, and minimum price for each 
specific item in the table. Hint: The items will need to be broken up into separate groups.
3. How many orders did each customer make? Use the items_ordered table. */

select  distinct state, count(customerid) as totalpeople
from customers
group by state;

select item, max(price), min(price)
from items_ordered
group by item;

select customerid, item, count(*) as NoofOrder, sum(quantity*price) as SumofOrder
from items_ordered
group by customerid;

/* Excercise 4 
(HAVING clause) 
1. How many people are in each unique state in the customers table that have more than one 
person in the state? Select the state and display the number of how many people are in each if 
it's greater than 1.
2. From the items_ordered table, select the item, maximum price, and minimum price for each 
specific item in the table. Only display the results if the maximum price for one of the items is 
greater than 190.00.
3. How many orders did each customer make? Use the items_ordered table. Select the 
customerid, number of orders they made, and the sum of their orders if they purchased more 
than 1 item.*/

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

/* Excercise 5 
(ORDER BY clause)
1. Select the lastname, firstname, and city for all customers in the customers table. Display the 
results in Ascending Order based on the lastname.
2. Same thing as exercise #1, but display the results in Descending order.
3. Select the item and price for all of the items in the items_ordered table that the price is greater 
than 10.00. Display the results in Ascending order based on the price.
*/

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

/* Excercise 6 
(Combining Conditions & Boolean Operators)
1. Select the customerid, order_date, and item from the items_ordered table for all items unless 
they are 'Snow Shoes' or if they are 'Ear Muffs'. Display the rows as long as they are not either of 
these two items.
2. Select the item and price of all items that start with the letters 'S', 'P', or 'F'.
*/

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

/* Excercise 7 
(IN & Between)
1. Select the date, item, and price from the items_ordered table for all of the rows that have a 
price value ranging from 10.00 to 80.00.
2. Select the firstname, city, and state from the customers table for all of the rows where the state 
value is either: Arizona, Washington, Oklahoma, Colorado, or Hawaii.
*/

select  order_date, item, price
from items_ordered
where price between 10 and 80;

SELECT firstname, state, city
from customers
 where state in ("Arizona", "Washington", "Oklahoma", "Colorado", "Hawai");
 
 /* Excercise 8 
 (Mathematical Functions)
1. Select the item and per unit price for each item in the items_ordered table. Hint: Divide the 
price by the quantity.
*/
 
 select item, sum(price)/sum(quantity) as priceperunit
 from items_ordered
 group by item;
 
 /* Excercise 9 
 (Table Joins)
1. Write a query using a join to determine which items were ordered by each of the customers in 
the customers table. Select the customerid, firstname, lastname, order_date, item, and price for 
everything each customer purchased in the items_ordered table.
2. Repeat exercise #1, however display the results sorted by state in descending order.*/
 
 select *
from items_ordered JOIN customers
ON items_ordered.customerid = customers.customerid;

 select *
from items_ordered JOIN customers
ON items_ordered.customerid = customers.customerid
order by state desc;
