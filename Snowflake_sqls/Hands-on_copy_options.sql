create table employees
(
  customer_id int,

  first_name varchar(50),

  last_name varchar(50),

  email varchar(50),

  age int,

  department varchar(50)
);

--2. Create a stage object pointing to 's3://snowflake-assignments-mc/copyoptions/example1'

create file format csv_comma_fileformat SKIP_HEADER=1;

create stage aws_copyoptions 
    url='s3://snowflake-assignments-mc/copyoptions/example1'
    file_format=PRACTICE_DB.TEST.CSV_COMMA_FILEFORMAT

list @aws_copyoptions

select * from employees

copy into employees 
from @aws_copyoptions
VALIDATION_MODE=RETURN_ERRORS;

copy into employees 
from @aws_copyoptions
ON_ERROR=CONTINUE;



--------------------------------------------------------------------

 ---- Create file format & load data ----   
 
 -- create table 
 create or replace table employees(   
     customer_id int,   
     first_name varchar(50),   
     last_name varchar(50),   
     email varchar(50),   
     age int,   
     city varchar(50));     
     
-- create file format object 
CREATE OR REPLACE FILE FORMAT EXERCISE_DB.public.aws_fileformat 
    TYPE = CSV FIELD_DELIMITER=',' 
    SKIP_HEADER=1;   

-- create stage object 
CREATE OR REPLACE STAGE EXERCISE_DB.public.aws_stage     
    url='s3://snowflake-assignments-mc/copyoptions/example1';       

-- List files in stage 
LIST @EXERCISE_DB.public.aws_stage;         

-- Use validation mode 
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES     
    FROM @aws_stage       
    file_format= EXERCISE_DB.public.aws_fileformat       
    VALIDATION_MODE = RETURN_ERRORS;    

-- Use ON_ERROR 
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES     
FROM @aws_stage       
file_format= EXERCISE_DB.public.aws_fileformat       
ON_ERROR = CONTINUE;        

