-- DATABASE

ALTER DATABASE NTYD_1 RENAME TO FIRST_DB;


-- CREATE TABLE
-- supported types: https://docs.snowflake.com/en/sql-reference/intro-summary-data-types
-- use double quotes for spaces in names


create table "FIRST_DB"."PUBLIC"."EMPLOYEE_SRC" (
    EMPLOYEE_ID INT,
    FIRST_NAME VARCHAR(10),
    LAST_NAME VARCHAR(10),
    EMAIL VARCHAR(30),
    PHONE_NUMBER STRING,
    HIRE_DATE DATE,
    JOB_ID VARCHAR(10),
    SALARY INT,
    COMMISSION_PCT INT,
    MANAGER_ID INT ,
    DEPARTMENT_ID INT
    )
 comment = 'this stores employee data from csv source';

--TESTING CAPS < SMALL letter denotions


create table "FIRST_DB"."PUBLIC"."EMPLOYEE_SRC_TEST" (
    EMPLOYEE_ID INT,
    "FIRST_NAME" VARCHAR(10),
    "Last_name" VARCHAR(10),
    "email" VARCHAR(30)
    );

--
USE DATABASE FIRST_DB;

 select employee_id
 from EMPLOYEE_SRC;


------------------------------------- LOAD DATA __________________________


COPY INTO EMPLOYEE_SRC 
FROM s3://first-bucket-pavanc/EMPLOYEE_DATA/EMP.csv
file_format= (  type = csv
                field_delimiter = ','
                skip_header = 1 );








-------------------
create table "FIRST_DB"."PUBLIC"."CUSTOMERS" (
    ID INT,
    FIRST_NAME VARCHAR,
    LAST_NAME VARCHAR,
    EMAIL VARCHAR(40),
    AGE INT,
    CITY VARCHAR
    );

USE DATABASE FIRST_DB;

COPY INTO CUSTOMERS
FROM s3://snowflake-assignments-mc/gettingstarted/customers.csv
file_format= (  type = csv
                field_delimiter = ','
                skip_header = 1 );

                
select count(*) from CUSTOMERS;
 