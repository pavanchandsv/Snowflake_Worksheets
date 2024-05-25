select  ID, NAME, PHONE, EMAIL, ADDRESS, POSTALZIP, REGION, COUNTRY, COMPANY, LASTTRANSACTION, DOB FROM CUSTOMERS

SELECT name,TRIM(NAME,' 0') as N,concat('|',N,'|') FROM CUSTOMERS


select split_part(trim(NAME,' 0'),',',1) as first_name, 
split_part(trim(NAME,' 0'),', ',2) as Last_name,
FROM CUSTOMERS

select concat('|',PHONE,'|'),RTRIM(LTRIM(PHONE,' 0+'),' ') FROM CUSTOMERS

select DOB,to_date(DOB,'MMMM DD, YYYY'),to_date(LASTTRANSACTION) from CUSTOMERS

select to_date(LASTTRANSACTION),datediff(days,to_date(LASTTRANSACTION),current_date) days_since_last_transaction from CUSTOMERS

select  ID,
split_part(trim(NAME,' 0'),',',1) as first_name, 
split_part(trim(NAME,' 0'),', ',2) as Last_name, 
LTRIM(PHONE,' 0+') as PHONE, 
EMAIL, 
ADDRESS, 
POSTALZIP, 
REGION, 
COUNTRY, 
COMPANY,
to_date(DOB,'MMMM DD, YYYY') as Date_of_birth ,
datediff(days,to_date(Date_of_birth),current_date) as Age,
to_date(LASTTRANSACTION) as LASTTRANSACTION,
datediff(days,to_date(LASTTRANSACTION),current_date) days_since_last_transaction
FROM CUSTOMERS


