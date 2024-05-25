CREATE DATABASE AZURE_TEST;
USE AZURE_TEST;
CREATE SCHEMA TEST;

--------
-- create integration object that contains the access information
CREATE STORAGE INTEGRATION azure_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID = 'e95de14a-6a7a-4aa8-8c6d-a5dc10757adb'
  STORAGE_ALLOWED_LOCATIONS = ('azure://snowfalke2azure.blob.core.windows.net/snowflakecsv', 'azure://snowfalke2azure.blob.core.windows.net/snowflakejson');

-- Describe integration object to provide access
DESC STORAGE integration azure_integration;

SHOW INTEGRATIONS

create or replace file format AZURE_TEST.TEST.azure_file_csv_format
SKIP_HEADER=1
TYPE= CSV
FIELD_DELIMITER=',';

create or replace stage azure_csv_stage
STORAGE_INTEGRATION=azure_integration
url = 'azure://snowfalke2azure.blob.core.windows.net/snowflakecsv'
FILE_FORMAT=AZURE_TEST.TEST.azure_file_csv_format ;

list @azure_csv_stage


create table employees_azure
(
  customer_id int,

  first_name varchar(50),

  last_name varchar(50),

  email varchar(50),

  age int,

  department varchar(50)
);

select * from employees_azure

copy into employees_azure
from (select $1,$2,$3,$4,$5,$6 from @azure_csv_stage)
ON_ERROR=CONTINUE;


select * from @azure_csv_stage