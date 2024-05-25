CREATE DATABASE SNOWPIPE;

CREATE OR REPLACE STORAGE INTEGRATION azure_to_snowpipe_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = AZURE
    ENABLED = TRUE
    AZURE_TENANT_ID = 'e95de14a-6a7a-4aa8-8c6d-a5dc10757adb'
    STORAGE_ALLOWED_LOCATIONS = ('azure://snowpipe2testpavan.blob.core.windows.net/snowpipe')


DESC STORAGE INTEGRATION azure_to_snowpipe_integration

CREATE OR REPLACE FILE FORMAT azure_csv_file_format
    TYPE =CSV
    FIELD_DELIMITER =','
    SKIP_HEADER=1 ;


CREATE OR REPLACE STAGE azure_stage
STORAGE_INTEGRATION = azure_to_snowpipe_integration
url='azure://snowpipe2testpavan.blob.core.windows.net/snowpipe'
FILE_FORMAT= azure_csv_file_format ;

LIST @azure_stage

------------------------------------------------------------------------------------------------------------------------
--CREATE QUEVE STORAGE IN AZURE

CREATE OR REPLACE NOTIFICATION INTEGRATION snowpipe_event_azure 
    ENABLED = TRUE 
    NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
    TYPE=QUEUE
    AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://snowpipe2testpavan.queue.core.windows.net/snowpipequeve'
    AZURE_TENANT_ID = 'e95de14a-6a7a-4aa8-8c6d-a5dc10757adb' ;



DESC  NOTIFICATION INTEGRATION snowpipe_event_azure 



--------------------------------------------------------------------------------------------------------------

select  $1,$2,$3,$4,$5,$6 from @azure_stage


create table employees
(
  customer_id int,

  first_name varchar(50),

  last_name varchar(50),

  email varchar(50),

  age int,

  department varchar(50)
);

select * from employees

truncate employees

COPY into employees from @azure_stage on_error=continue


-------------------------------------------------------------------------

CREATE PIPE azure_pipe
auto_ingest = true
integration= snowpipe_event_azure
as
COPY into employees from @azure_stage on_error=continue;

Alter pipe azure_pipe refresh;

-------------------------------------------------------------------
select SYSTEM$PIPE_STATUS('azure_pipe')

