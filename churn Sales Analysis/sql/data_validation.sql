--How many unique customers are in the company database?
Select Distinct Count(*) [Total Customer] from Customer_profile

--Does the customer profile table contain duplicate customer records?
Select  distinct Count(Customer_ID) from Customer_profile  

--are every customer has a service record
Select count(*) [No of Customer] from customer_profile c left join customer_services s
ON c.Customer_ID = s.Customer_ID
where s.Customer_ID is null

--Check missing behavior records
Select count(*) [No of Customer] from customer_profile c left join customer_behavior s
ON c.Customer_ID = s.Customer_ID
where s.Customer_ID is null

--Check missing critical values
SELECT 
    SUM(CASE WHEN [Customer_ID]  IS NULL THEN 1 ELSE 0 END) AS  Customer_Id,
    SUM(CASE WHEN [Customer_Name] IS NULL THEN 1 ELSE 0 END) AS Customer_Name,
    SUM(CASE WHEN [Senior_Citizen] IS NULL THEN 1 ELSE 0 END) AS Age,
    SUM(CASE WHEN [Dependents] IS NULL THEN 1 ELSE 0 END) AS Dependents ,
    SUM(CASE WHEN [State] IS NULL THEN 1 ELSE 0 END) AS State,
    SUM(CASE WHEN [City] IS NULL THEN 1 ELSE 0 END) AS City,
    SUM(CASE WHEN [Customer_Segment] IS NULL THEN 1 ELSE 0 END) AS Customer_Segment
FROM customer_profile

--Are there customers with impossible negative charges or LTV?
 Select [Monthly_Charges],[Total_Charges],[Annual_Charges],[Estimated_LTV] from customer_services
 where Monthly_Charges < 0
 
 -- Invalid Ages 
 select age from customer_profile
 where age<18 or age>100

-- Unique customers
-- No duplicate IDs
-- Profile-  Services relationship
-- Profile-  Behavior relationship
-- Critical NULLs
-- Same customer count across tables
-- Valid Churn_Flag
-- No negative financial values
-- Reasonable age values
