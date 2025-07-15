use order_customer;

/* Exercise 1
COMPARISON	OPERATOR	QUERIES
1. From	the	TransactionMaster	table,	select	a	list	of	all	items	purchased	for	Customer_Number	296053.	Display	  the	Customer_Number Product_Number,	and	Sales_Amount	for	this	customer.
2. Select	all  columns	from	the LocationMaster table	for	transactions  made	in	the  Region	=	NORTH.
3. Select	the	distinct	products in	the	TransactionMaster	table.	In	other	words,	display	a	listing	of	each	of	  the	unique	products	from the	
  TransactionMaster table.
4. List	all	the	Customers	without	duplication
*/

select Customer_Number, Product_Number, Sales_Amount
from transactionmaster
where Customer_Number = 296053;

select * 
from locationmaster
where Region = "NORTH";

select distinct Product_Number
from transactionmaster;

select distinct Customer_Number, FirstofCustomer_Name
from customermaster;

/* Exercise 2
Consider	a	database	of	social	groups	at	allows	people	to	become	members	of	groups:	  a	person	can	be	a	member	of	several	the	. AGGREGATE	FUCNTION	QUERIE AGGREGATE	FUCNTION	QUERIES
1. Find	the	average	Sales	Amount	for	Product	Number	30300	in	Sales	Period	P03.
2. Find  the	maximum	Sales	Amount	amongst	all	the	transactions.
3. Count	total	number	of	transactions	for	each	Product	Number	and	display	in	descending	order
4. List	the	total	number	of	transactions	in	Sales	period	P02	and	P03
5. What	is	the	total	number of	rows	in	the	TransactionMaster	table?
6. Look	into	the	PriceMaster	table	to	find	the	price	of	the	cheapest	product	that	was	ordered.*/

select avg(Sales_Amount), Sales_Period
from transactionmaster
where Sales_Period = "P03";

select max(Sales_Amount)
from transactionmaster;

select count(Product_Number),Product_Number
from transactionmaster
order by Product_Number desc;

select count(Invoice_Number), Sales_Period
from transactionmaster
where Sales_Period in ("P02" , "P03") ;

select count(*) as noofrows
from transactionmaster;

select min(Price), Product_Number
from pricemaster;

/* Exercise 3
LIKE  FUNCTION	QUERIES
1. Select	all	Employees	where	Employee-­‐Status  =	“A”
2. Select	all	Employees where	Job	escription	is	“TEAMLEAD	1”.
3. List	the	Last	name, Employee	Status	and	Job	Title	of	all	employees	whose	names	contains  the	letter	"o"	as	the	second	letter.
4. List	the	Last	name,	Employee Status   and	Job	Title	of	all	employees	whose First names	start	with	the	letter	"A"	and	does	
not	contain  the	letter	"i".	
  5. List	the	 First  name	and	Last	names	of	employees	with	Employee	Status“I”	whose	Job	Code	is	not	SR2	and	SR3.
6. Find	out	details	ofemployees	whose	last	name	ends	with	“N”	nd	first	name	begins	with	“A”	or	“D”.
7. Find  the	list  of	products  with	the	word  “Maintenance”	in	their	product*/
select Employee_Number,Employee_Status 
from employee_master
where Employee_Status = "A";

select Employee_Number,Job_Title 
from employee_master
where Job_Title  = "TEAMLEAD 1";

select *
from  employee_master                       
where First_Name like "_O%";


select *
from  employee_master                       
where First_Name like "A%" and First_Name not like "%i%";

select First_Name, Last_Name, Employee_Status,Job_Code 
from  employee_master                       
where Employee_Status = "I" and Job_Code  in ("SR2", "SR3");

select *
from  employee_master                       
where First_Name like "A%" and First_Name like "D%" AND Last_Name like "%N";

select *
from productmaster
where Product_Description like "%Maintenance%";

/* Exercise 4
DATE	FUNCTION	QUERIES
1. List	the	employees	who	were	hired	before	01/01/2000	(hint:use	#	for	date	values).
2. Find	the total	number	years	of	employment	for all the employees	who	have	retired.
3. List	the	transactions,	which	were	performed	on	Wednesday	or	Saturdays.
4. Find	the	list	of	employees	who	are	still working	at	the	present.*/

select Service_Date, str_to_date(Service_Date, "%Y-%m-%d")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from transactionmaster; 

SET SQL_SAFE_UPDATES = 0;

update transactionmaster
set Service_Date  = str_to_date(left(Service_Date,10), "%Y-%m-%d"); 

 select Hire_Date, str_to_date(Hire_Date, "%Y-%m-%d")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from employee_master ;

update employee_master
set Hire_Date  = str_to_date(left(Hire_Date,10), "%Y-%m-%d"); 

 select Last_Date_Worked, str_to_date(Last_Date_Worked, "%Y-%m-%d")                  /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from employee_master ;

update employee_master
set Last_Date_Worked  = str_to_date(left(Last_Date_Worked,10), "%Y-%m-%d"); 

select Employee_Number,
Round((datediff(Last_Date_Worked, Hire_Date))/365.25,2) as years
from employee_master
where Last_Date_Worked <>"";

select Invoice_Number, weekday(Invoice_Date) as WKDAY
from transactionmaster
where weekday(Invoice_Date) IN (2,5);         /* 0- MONDAY, 6- SUNDAY */

select Invoice_Number, weekday(Invoice_Date) as WKDAY,
DAYNAME(Invoice_Date) AS DayName                            /* daynm - weekdatnm */
from transactionmaster
where weekday(Invoice_Date) IN (2,5);

select Employee_Number, Hire_Date, Last_Name
from employee_master
where Last_Date_Worked like "00-00-00";

/* Exercise 5
GROUP	BY	CLAUSE QUERIES
1. List	the	number	of	Customers	from	each	City	and State.
2. For	each	Sales	Period	find	the	average	Sales	Amount.
3. Find	the	  total	number	of	customers	in	each	Market.
4. List	thenumber	of	customers	and	the	average	Sales	Amount	in	each	Region.
5. From	the	TransactionMaster table,	select	the	Product	number,	maximum	price,	and	minimum	price	for	each	specific	item	in	the	table.	
 products will	need to	bebroken	up  into	separate groups.	*/

select Customer_Number, count(Customer_Number) as Totalcustomer, FirstOfCity, FirstOfState
from customermaster
Group by FirstOfState, FirstOfCity ;

select avg(Sales_Amount), Sales_Period
from transactionmaster
group by Sales_Period;

select Branch_Number, count(Branch_Number) as Total,Market
from locationmaster
Group by Market;

select Product_Number,max(Sales_Amount) as maxamount, min(Sales_Amount) as minamount
from transactionmaster
group by Product_Number;

/* Exercise 6 
ORDER	BY	CLAUSE	QUERIES
1. Select	the	Name	of	customer	companies,	city,	and	state	for	all	customers	in	the	CustomerMaster	table.	Display	the	results	in	Ascending Order	
based	on	the	Customer	Name	(company	name).
2. Same	thing	as	question	#1,	but	display	the	results	in	descending	order.
3. Select	the	product	number	andsales	amount for	all	of	the	items	in	the	TransactionMaster table	  that	the	sales	amount	is	greater than	100.00.	display the	results	in	descending	order	based	on	the	price.*/

select Customer_Number, FirstOfCity, FirstOfState, FirstOfCustomer_Name
from customermaster
order by FirstOfCustomer_Name ;


select Customer_Number, FirstOfCity, FirstOfState, FirstOfCustomer_Name
from customermaster
order by FirstOfCustomer_Name desc;

select Product_Number,Sales_Amount
from transactionmaster
where Sales_Amount >= "100"
order by Sales_Amount desc;

/* Exercise 7 HAVING	
  CLAUSE	
  QUERIES
1. How	many	branches are	in	each	unique	region	in	the	LocationMaster	table	that	has more	than	
one	branch in the region?	Select	the	region and	display	the	
  number	of	branches are	in	each	if	it's	greater	than	
2. From	the	TransactionMaster table,	select	the	item,	maximum	sale amount,	and	minimum	sales	amount	for	each	product	number	in	
  the	table.	Only	display	the	results	if	the	maximum	price	for	one	of	the	items	isgreater	than	390.00.
3. How	many	orders	did	each	customer	company	make?	Use	the	TransactionMaster table.	Select	the customer_Number,
	count	the	numberof	orders	they	made,	and	the	sum	their	0rders	if	they	purchased	more	than	1	item.*/

select distinct Region, count(Branch_Number), Branch_Number
from locationmaster
group by Region;


select Product_Number,max(Sales_Amount) as maxamount, min(Sales_Amount) as minamount
from transactionmaster
group by Product_Number
having count(Sales_Amount) > 390;

select Customer_Number,count(*),Invoice_Number,count(Invoice_Number) as nooforder
from transactionmaster
group by Customer_Number
having sum(Invoice_Number)>1;

/* Exercise 8
IN	AND	BETWEEN	FUNCTION	QUERIES
1. List	all	the	employees	who	have	worked	between	22	March	2004	and	21 April	2004.
2. List	the	names	of	Employees	
  whose	Job	Code	is	in	SR1,SR2	or SR3.
3. Select	the	Invoice	date,	Product	number and	Branch	number	of	all	transactions,	which	have	Sales	amount	ranging	from	150.00	to	200.00.
4. Select	the	Branch	Number,	Market	and	Region	from	the	LocationMaster table	for all	of the	rows	where	the Market value	is either:Dallas,Denver,Tulsa,	or Canada.*/

select Employee_Number, Hire_Date
from employee_master
where Last_Date_Worked between 2004-03-22 and 2004-04-21;

select *
from  employee_master
where Job_Code  in ("SR1", "SR2", "SR3");

select *
from transactionmaster
where Sales_Amount between 150 and 200;

select *
from locationmaster
where Market in ("Dallas", "Denver", "Tulsa" , "Canada");


/* Exercise 9
TABLE	JOINS 
1. Write	a	query	using	a	join	to	determine	which	products were 
 ordered by each	of the	customers in	the customerMaster table.	Select the Customer_Number,	FirstOfCustomer_Name,	FirstOfCity,	
  Product_NumberInvoice_Number,	Invoice_date,	and	Sales_Amount for	everything	each	custome */

SELECT  * 
FROM transactionmaster as t join customermaster as c
where t.Customer_Number = c.Customer_Number
;

SELECT  * 
FROM transactionmaster as t join customermaster as c
where t.Customer_Number = c.Customer_Number
order by FirstOfCity;
