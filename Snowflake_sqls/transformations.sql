desc stage MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE

list @MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE

--s3://bucketsnowflakes3/Loan_payments_data.csv

CREATE OR REPLACE TABLE FIRST_DB.PUBLIC.LOANS (

LOAN_ID VARCHAR(14),
LOAN_STATUS VARCHAR,
DUE_DATE DATE,
GENDER VARCHAR(10)
)
truncate FIRST_DB.PUBLIC.LOANS 
select * from FIRST_DB.PUBLIC.LOANS 

COPY INTO FIRST_DB.PUBLIC.LOANS 
    FROM ( select   SUBSTRING(s.$1,3,4),
                CASE WHEN s.$2 = 'PAIDOFF' THEN 'DONE' ELSE 'NOT DONE' END
                ,s.$6
                ,s.$11 
                from @MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE s 
    )
file_format= (type = csv field_delimiter=',' skip_header=1)
files=('Loan_payments_data.csv')





-------------------------------------------------------------

CREATE OR REPLACE TABLE FIRST_DB.PUBLIC.LOANS_2 AS SELECT * FROM FIRST_DB.PUBLIC.LOANS WHERE 1=2;


SELECT * FROM FIRST_DB.PUBLIC.LOANS_2


COPY INTO FIRST_DB.PUBLIC.LOANS_2 (LOAN_ID ,LOAN_STATUS)
FROM ( SELECT S.$1,S.$2 FROM @MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE S)
file_format= (type = csv field_delimiter=',' skip_header=1)
files=('Loan_payments_data.csv')


-------------------------------------------------------------------------

DROP TABLE FIRST_DB.PUBLIC.LOANS_AUTO_INC;

CREATE OR REPLACE TABLE FIRST_DB.PUBLIC.LOANS_AUTO_INC (

LOAN_ID NUMBER AUTOINCREMENT START 1 INCREMENT 1,
LOAN_STATUS VARCHAR,
DUE_DATE DATE,
GENDER VARCHAR(10)
)

ALTER TABLE FIRST_DB.PUBLIC.LOANS_AUTO_INC MODIFY GENDER VARCHAR(20)

COPY INTO FIRST_DB.PUBLIC.LOANS_AUTO_INC (LOAN_STATUS,DUE_DATE)
    FROM ( select   
                CASE WHEN s.$2 = 'PAIDOFF' THEN 'DONE' ELSE 'NOT DONE' END
                ,s.$6
                from @MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE s 
    )
file_format= (type = csv field_delimiter=',' skip_header=1)
files=('Loan_payments_data.csv')

SELECT * FROM FIRST_DB.PUBLIC.LOANS_AUTO_INC
