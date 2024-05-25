select * from employees order by customer_id;

select * from employees at (OFFSET => -60*10) order by customer_id;

alter session set timezone ='UTC'
select current_timestamp

update  employees set last_name = 'kingu'
update  employees set age = 19


select * from employees order by customer_id

select * from employees before (timestamp => '2024-05-22 04:32:05.325 +0000'::timestamp) order by customer_id

--coreect 
select * from employees before (statement => '01b47dd9-3201-180a-0008-e646000118ee') order by customer_id


--wrong quevry
select * from employees before (statement => '01b47dd9-3201-175c-0008-e6460001327e') 


--USE BACKUP TABLE
create or replace table employees_bkp as
select * from employees before (statement => '01b47dd9-3201-180a-0008-e646000118ee') 


select * from employees_bkp

--TRUNCATE EMPLOYEE and load from BKP

TRUNCATE EMPLOYEES

INSERT INTO EMPLOYEES SELECT * FROM EMPLOYEES_BKP

SELECT * FROM EMPLOYEES
