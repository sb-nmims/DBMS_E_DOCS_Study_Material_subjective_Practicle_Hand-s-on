CREATE TABLE DEPOSIT (ACTNO VARCHAR(5), CNAME VARCHAR(18), 
BNAME VARCHAR(18), AMOUNT Int, ADATE DATE);

CREATE TABLE BRANCH (BNAME VARCHAR(18), CITY VARCHAR(18));

CREATE TABLE CUSTOMER (CNAME VARCHAR(19), CITY VARCHAR(18));

CREATE TABLE BORROW (LOANNO VARCHAR(5), CNAME VARCHAR(18), BNAME VARCHAR(18), 
AMOUNT Int);



INSERT INTO DEPOSIT VALUES ('100', 'ANIL', 'VRCE', 1000.00, '1-MAR-95');
INSERT INTO DEPOSIT VALUES ('101', 'SUNIL', 'AJNI', 5000.00, '4-JAN-96');
INSERT INTO DEPOSIT VALUES ('102', 'MEHUL', 'KAROLBAGH', 3500.00, '17-NOV-95');
INSERT INTO DEPOSIT VALUES ('104', 'MADHURI', 'CHANDNI', 1200.00, '17-DEC-95');
INSERT INTO DEPOSIT VALUES ('105', 'PRAMOD', 'M.G.ROAD', 3000.00, '27-MAR-96');
INSERT INTO DEPOSIT VALUES ('106', 'SANDIP', 'ANDHERI', 2000.00, '31-MAR-96');
INSERT INTO DEPOSIT VALUES ('107', 'SHIVANI', 'VIRAR', 1000.00, '5-SEP-95');
INSERT INTO DEPOSIT VALUES ('108', 'KRANTI', 'NEHRU PLACE', 5000.00, '2-JUL-95');
INSERT INTO DEPOSIT VALUES ('109', 'NAREN', 'POWAI', 7000.00, '10-AUG-95');

INSERT INTO BRANCH VALUES ('VRCE', 'NAGPUR');
INSERT INTO BRANCH VALUES ('AJNI', 'NAGPUR');
INSERT INTO BRANCH VALUES ('KAROLBAGH', 'DELHI');
INSERT INTO BRANCH VALUES ('CHANDNI', 'DELHI');
INSERT INTO BRANCH VALUES ('DHARAMPETH', 'NAGPUR');
INSERT INTO BRANCH VALUES ('M.G.ROAD', 'BANGALORE');
INSERT INTO BRANCH VALUES ('ANDHERI', 'BOMBAY');
INSERT INTO BRANCH VALUES ('VIRAR', 'BOMBAY');
INSERT INTO BRANCH VALUES ('NEHRU PLACE', 'DELHI');
INSERT INTO BRANCH VALUES ('POWAI', 'BOMBAY');

INSERT INTO CUSTOMER VALUES ('ANIL','CALCUTTA');
INSERT INTO CUSTOMER VALUES ('SUNIL','DELHI');
INSERT INTO CUSTOMER VALUES ('MEHUL','BARODA');
INSERT INTO CUSTOMER VALUES ('MANDAR','PATNA');
INSERT INTO CUSTOMER VALUES ('MADHURI','NAGPUR');
INSERT INTO CUSTOMER VALUES ('PRAMOD','NAGPUR');
INSERT INTO CUSTOMER VALUES ('SANDIP','SURAT');
INSERT INTO CUSTOMER VALUES ('SHIVANI','BOMBAY');
INSERT INTO CUSTOMER VALUES ('KRANTI','BOMBAY');
INSERT INTO CUSTOMER VALUES ('NAREN','BOMBAY');

INSERT INTO BORROW VALUES ('201', 'ANIL', 'VRCE', 1000.00);
INSERT INTO BORROW VALUES ('206', 'MEHUL', 'AJNI', 5000.00);
INSERT INTO BORROW VALUES ('311', 'SUNIL', 'DHARAMPETH', 3000.00);
INSERT INTO BORROW VALUES ('321', 'MADHURI', 'ANDHERI', 2000.00);
INSERT INTO BORROW VALUES ('375', 'PRAMOD', 'VIRAR', 8000.00);
INSERT INTO BORROW VALUES ('481', 'KRANTI', 'NEHRU PLACE', 3000.00);


--SELECTING DATA FROM SINGLE TABLE		
--1.	Give account no. and amount of depositors.
--2.	Give name of customer having living city BOMBAY and branch city DELHI


1) 
select actno, amount from deposit;

2) 
select c.cname 
from customer c join deposit d on c.cname=d.cname
join borrow b on c.cname= b.cname join branch br on d.bname =br.bname
where c.city = 'BOMBAY' and br.city='DELHI';


JOIN OR CARTESIAN PRODUCT
3.	Give names of customers having the same living city as their branch city

3) 
select distinct c.cname 
from customer c join branch b on c.city = b.city;
select * from customer
select * from branch











2) 
select Distinct cname from customer e, branch b 
where e.city='BOMBAY' and b.city= 'DELHI';

3) 

select Distinct cname from customer join branch on customer.CITY=BRANCH.CITY;

OR

select Distinct cname from customer e,branch b where e.city=b.city;


--4.	Give names of customers who are borrowers as well as depositors and having living city NAGPUR

4)
select customer.cname from CUSTOMER join DEPOSIT on 
CUSTOMER.cname= deposit.cname
join borrow on customer.cname=borrow.cname where customer.city='Nagpur';

OR

select c1.cname from customer c1, deposit d1, borrow b1
where c1.city='Nagpur' and c1.cname=d1.cname
and d1.cname=b1.cname;

--5.	Give names of borrowers having loan amount greater than the loan amount of Anil

5) 
select cname 
from borrow
where amount > (select amount from borrow where cname ='ANIL');
5)
select distinct b.cname from borrow b where b.amount> 
(select b2.amount from borrow b2 join customer c
on b2.cname=c.cname where c.cname ='ANIL');

5) 
select distinct e.cname from customer e, borrow b
where b.amount >(select amount from borrow where cname = 'ANIL');

select distinct b.cname from  borrow b
where b.amount >(select amount from borrow where cname = 'ANIL');

--6.	Give deposit details and loan details of customer in the city where Pramod is living.

6) 
select d.ACTNO, d.cname, d.amount as deposit_amount, b.LOANNO, b.amount as
LOAN_AMOUNT from deposit d join customer c on d.cname =c.cname join borrow b on 
d.cname = b.cname
where c.city ='NAGPUR';

6) 
select d.*, b.LOANNO from deposit d join borrow b on d.cname= b.cname where 
d.cname in (select cname from customer where cname = 'PRAMOD');

--7.	Give city of customer having the same branch city as that of Pramod.
7) 
select distinct c.city from customer c join deposit d on c.cname = d.cname 
join branch b on d.bname=b.bname where c.city = (select city from customer
where cname = 'PRAMOD');

OR

select distinct c.city from customer c, branch b
where c.city =b.city and 
b.city = (select city from customer where cname='PRAMOD');


--8.	Give the living city of Anil and the living city of Sunil
8)

select city from customer where cname in ( 'ANIL', 'SUNIL');

select city from customer 
where cname in ('ANIL', 'SUNIL');

13) select cname, amount from DEPOSIT
where cname in 
(select city from customer where cname ='ANIL' or cname = 'SUNIL');

8) 
select c.city from customer c 
where c.cname ='ANIL' or c.cname='SUNIL';


--SET OPERATIONS
--9.	List all the customers who are depositors but not borrowers


9) 
select c.cname from customer c
join deposit d on c.cname =d.cname
Left join borrow b on c.cname= b.cname
where b.cname IS NULL;

9)
select distinct cname from deposit 
where cname not in (select cname from borrow);


-- 10.	List all the customers living in city NAGPUR and having branch city BOMBAY or DELHI
10) 
select c.cname 
from customer c join deposit d on c.cname=d.cname join branch b
on d.bname = b.bname where c.city='NAGPUR' and 
(b.city ='BOMBAY' or b.city='DELHI');


10)
select c.cname from customer c 
join DEPOSIT d on c.cname=d.cname 
join BRANCH b on d.bname = b.bname
where c.city = 'NAGPUR' and (b.city = 'BOMBAY' or b.city = 'DELHI');





--11.	List the branch cities of Anil and Sunil
11) 
select distinct b.city from deposit d
join customer c on d.cname= c.cname join branch b on d.bname=b.bname
where c.cname in ('ANIL', 'Sunil')


select branch.city from customer join deposit on customer.cname =deposit.cname
join branch on deposit.bname = branch.bname where customer.cname= 'ANIL'
UNION
select branch.city from customer join deposit on customer.cname =deposit.cname
join branch on deposit.bname = branch.bname where customer.cname= 'SUNIL'





select distinct b.city from branch b, customer c
where c.cname='ANIL'or c.cname='SUNIL'


-- 12.	List the customer having deposit greater than 1000 and loan less than 10000
12)
select d.cname from deposit d join borrow b on d.cname = b.cname 
where d.amount > 1000 and b.amount<10000;

select cname from customer where cname in (select d.cname from deposit d
where d.amount>1000) and cname in (select b.cname from Borrow b Where 
b.amount<10000);


--13.	List all the customer names and amount for depositors living in the city where either Anil or Sunil is living
13) select c.cname, d.amount from customer c
join deposit d on c.cname = d.cname 
where c.city in (select city from customer where cname in ('ANIL', 'SUNIL'));


/*AGGREGATE FUNCTIONS
14.	List total deposit of customers living in city Nagpur
15.	List total deposit of customers living in the city where Sunil is living
16.	Give the branch wise deposit of customer after account date 1-jan-96
17.	Give branch wise loan of customer living in NAGPUR
18.	Give the number of customers who are depositors as well as borrowers
*/
14) select sum(d.amount) as total_deposit from 
deposit d join branch b on d.bname = b.bname
join customer c on d.cname= c.cname where c.city = 'NAGPUR';




14)
select sum(a.amount) from deposit as a , customer as b
where (a.cname = b.cname) and (b.city = 'NAGPUR');

select * from deposit
select * from customer


(15) 
select sum(d.amount) as total_deposit 
from deposit d
where d.cname in (select cname from customer where city = 
(select city from customer where cname= 'SUNIL'));

select * from deposit;

16)
select d.bname as branch_name, sum(d.amount) as total_deposit
from deposit d
where d.adate>'1996-01-01' group by d.bname;

select * from deposit;

17)
select borrow.LOANNO, borrow.cname, borrow.amount, branch.bname from 
borrow join branch on borrow.bname=branch.bname where branch .city ='NAGPUR'

18) 
select count(deposit.cname) from 
deposit join borrow on deposit.cname=borrow.cname;


/*
GROUP BY AND HAVING CLAUSE
19.	List the branches having a sum of deposit more than 1000 & located in city BOMBAY
20.	List the name of customers having maximum deposit in the customers living in NAGPUR
*/
19)
select b.bname
from deposit d join branch b on d.bname = b.bname
where b.city ='BOMBAY' group by b.bname having sum(d.amount)>1000;

20) 
select customer.cname 
from deposit, customer
Where amount = (select max(amount) from deposit join customer on 
customer.cname=deposit.cname where customer.city = 'NAGPUR') and
customer.city ='NAGPUR' and customer.cname=deposit.cname;




