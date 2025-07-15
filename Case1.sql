use case1;

select name, dob, str_to_date(dob, "%d-%m-%Y")                 /*Map the dd_mm_yyyy in mysql date format which is yy_mm_dd, str_to_date(column nm,<mapping parameters>)*/
from student;                                                   /* Y for 2021, m for months no, M for August, dd for 12,01 */

select name, dob, 
str_to_date(left(dob,10), "%d-%m-%Y")                 /*left extract first 10 char completely,covert my sql date format*/
from student;

SET SQL_SAFE_UPDATES = 0;

update student
set dob = str_to_date(left(DOB,10), "%d-%m-%Y"); 

select * from student;

/* 1. a) List all the 2A students */
SELECT *
from student
 where Class ="2B"
order by Class; 

/*b) List the names and Math test scores of the 1B boys * /

SELECT name, mtest, class
from student
 where Class ="1B"
order by mtest desc;

/* 2)b) List the classes, names of students whose names start with "T" and do not contain "y". */

select name, class
 from student
 where name like "T%" and name not like "%y%";
 
 /*2. a) List the classes, names of students whose names contain the letter "e" as the third letter.   */
 
 select name, class
from student
where name regexp "^..e";

 /*b) List the classes, names of students whose names start with "T" and do not contain "y"*/
 
 select Name, class
 from student
 where Name regexp"^[t]" and Name not regexp "[Y]";
 
 /* c) List the names of 1A students whose Math test score is not 51, 61, 71, 81, or 91*/
 
 select id, name, mtest
from student
where mtest not in (51,61,71,81,91);
 
 /*2)d) List the students who were born between 22 March 1986 and 21 April 1986 */
 
 select name, dob, class
 from student
 where dob BETWEEN "1986-03-22" and "1986-04-21";
 
 /*3. a) Find the number of girls living in TST*/
 
  select count(id) as totalgirls
from student
where sex = "F" and dcode = "TST";

/* b) List the number of pass in the Math test of each class. (passing mark = 50)*/

 select name,id, mtest as maths 
 from student       
 where Mtest >= 50
 group by class;
 
 /* c) List the number of girls grouped by each class */
 
  select count(name),id, class
 from student       
 where sex = "F"
 group by class;
 
 /*d) List the number of girls grouped by the year of birth.*/
 
   select count(name),id, dob
 from student       
 where sex = "F"
 group by dob;
 
 /*3)e) Find the average age of class 1 boys.*/
 
  select avg(mtest) as avgmarks
  from student
  where class like "1%";
  
  /*4. a) Find the average mark of mtest for each class*/
  
    select avg(mtest) as avgmarks, class
  from student
group by class;
  
  /* b) Find the maximum mark of mtest for each sex*/
  
    select max(mtest) as maxmarks, class, sex
  from student
group by sex;

/* c) Find the average mark of mtest for all students.*/

  select avg(mtest) as avgmarks, count(name)
  from student;

  /* 5)a) List the students who are common members of the Physics Club and the Chemistry Club.*/
  
  select *
  from chem
  where ID in (select ID from phy);
  
  /* 5) b) List the students who are common members of the Chemistry Club and Biology Club but not of the Physics Club. */
  
  select *
  from chem
  where id in (select id from bio)
  and id not in (select id from phy);
  
  /*6) a) Produce a list of parts in ascending order of quantity*/
  
  SELECT part_no
from client
order by Qty;

/*b) Produce a list of parts that consist of the keyword ‘Shaft’ in the description.*/

 SELECT part_no, Descript
from client
where Descript regexp "Shaft";

/* c) Produce a list of parts that have a quantity more than 20 and are supplied by ‘China Metals Co.*/

 SELECT *
from client
where Qty >= 20 and Supplier = "China Metals Co." ;

/*d) List all the suppliers without duplication.*/

 SELECT distinct Supplier
from client;

  /* 6) e) Increase the quantity by 10 for those parts with quantity less than 10.*/
  
  SET SQL_SAFE_UPDATES = 0;
  
  update client
  set Qty = Qty + 10
  where Qty < 10;
  
  select Qty +10
  from client                  /* select qty <10 ,  add 10 to qty in result, not change in table */
  where Qty < 10;
  
  /*f) Delete records with part_no equal to 879, 654, 231 and 23*/
  
delete 
from client
where Part_no = 879, Part_no = 654, Part_no = 231, Part_no = 23;

/* g) Add a field “Date_purchase” to record the date of purchase*/
/*DUE 6- E F G*/
