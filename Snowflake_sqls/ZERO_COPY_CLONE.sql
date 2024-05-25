CREATE TABLE EMPLOYEES_ClONE
CLONE EMPLOYEES


select * from EMPLOYEES_CLONE

CREATE TEMPORARY TABLE EMPLOYEES_CLONE_AGE_40
CLONE  EMPLOYEES

select * from EMPLOYEES_CLONE_AGE_40



---------------------------------------------------------------------
select * from EMPLOYEES

update employees set age=19

CREATE OR REPLACE TABLE EMPLOYEE_CLONE
CLONE EMPLOYEES at (OFFSET => -60*4)

select * from EMPLOYEE_CLONE

