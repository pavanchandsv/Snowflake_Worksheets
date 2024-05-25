CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage_practice
    url='s3://snowflake-assignments-mc/loadingdata/'
    
--    credentials=(aws_key_id='ABCD_DUMMY_ID' aws_secret_key='1234abcd_key'); 
-- for public no need credentials


// Description of external stage

DESC STAGE MANAGE_DB.external_stages.aws_stage; 
    
    
// Alter external stage   

ALTER STAGE aws_stage
    SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');
    
    
// Publicly accessible staging area    

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage

LIST @aws_stage_practice;

//Load data using copy command
select count(*) from FIRST_DB.PUBLIC.CUSTOMERS

TRUNCATE TABLE FIRST_DB.PUBLIC.CUSTOMERS

COPY INTO FIRST_DB.PUBLIC.CUSTOMERS
    FROM @aws_stage_practice
     file_format= (type = csv field_delimiter=';' skip_header=1)


