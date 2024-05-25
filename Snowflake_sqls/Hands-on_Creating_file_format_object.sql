Hands-on: Creating file format object
In this exercise, you will create a stage and a file format object and load data using this file format object.


Instructions:
1. Create a stage & file format object

The data is available under s3://snowflake-assignments-mc/fileformat/

Data type: CSV 

Data delimited by '|' (pipe)

The header is in the first line.


2. List the files in the table


3. Load the data in the existing customers table using the COPY command your stage and the created file format object.


4. Find out how many rows have been loaded in this load.


----------------------------------------------------------------------------------------------------------------------------


create database practice_db ;
use practice_db
create schema test;


create file format practice_db.test.csv_file_format;

alter file format practice_db.test.csv_file_format set SKIP_HEADER=1 ,field_delimiter='|';

desc file format practice_db.test.csv_file_format

CREATE OR REPLACE STAGE practice_db.test.aws_stage
    url='s3://snowflake-assignments-mc/fileformat/';

list @practice_db.test.aws_stage

create or replace TABLE practice_db.test.CUSTOMERS (
	ID NUMBER(38,0),
	FIRST_NAME VARCHAR(16777216),
	LAST_NAME VARCHAR(16777216),
	EMAIL VARCHAR(40),
	AGE NUMBER(38,0),
	CITY VARCHAR(16777216)
)
data_retention_time_in_days=3;



copy into practice_db.test.CUSTOMERS
from @practice_db.test.aws_stage
file_format = (format_name=practice_db.test.csv_file_format)
files=('customers4.csv')



select * from  practice_db.test.CUSTOMERS



