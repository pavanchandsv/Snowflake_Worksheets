create or replace file format AZURE_TEST.TEST.azure_file_json_format
TYPE= JSON
;

create or replace stage azure_json_stage
STORAGE_INTEGRATION=azure_integration
url = 'azure://snowfalke2azure.blob.core.windows.net/snowflakejson'
FILE_FORMAT=AZURE_TEST.TEST.azure_file_json_format ;

list @azure_csv_stage

select $1:"emailAddress"::STRING,
        $1:"userId"::STRING,
        $1:"jobTitleName"::STRING,
        $1:"firstName"::STRING,
        $1:"lastName"::STRING,
        $1:"preferredFullName"::STRING,
        $1:"employeeCode"::STRING,
        $1:"region"::STRING,
        $1:"phoneNumber"::STRING,
        $1:"emailAddress"::STRING
from @azure_json_stage

create table employee_raw_json (
raw variant
)

copy into employee_raw_json 
from @azure_json_stage

select * from employee_raw_json