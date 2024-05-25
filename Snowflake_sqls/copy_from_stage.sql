// Creating ORDERS table

CREATE OR REPLACE TABLE FIRST_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
    
SELECT count(*) FROM FIRST_DB.PUBLIC.ORDERS;

truncate FIRST_DB.PUBLIC.ORDERS;
   
// First copy command

COPY INTO FIRST_DB.PUBLIC.ORDERS
    FROM @aws_stage
    file_format = (type = csv field_delimiter=',' skip_header=1);




// Copy command with fully qualified stage object

COPY INTO FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1);




// List files contained in stage

LIST @MANAGE_DB.external_stages.aws_stage;    




// Copy command with specified file(s)

COPY INTO FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails.csv');
    



// Copy command with pattern for file names

COPY INTO FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order*.';







    ---------------------
