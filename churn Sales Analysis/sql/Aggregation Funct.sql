---------Revenue by Contract---------
Select Count(*) [No of Customers] ,Contract_Type,FORMAT(Sum (monthly_Charges),'N0') [Total Monthly Revenue] 
,FORMAt(Avg(monthly_charges),'N0') [Avg Monthly charges]    from churn_cleaned
Group by Contract_Type


     --Churn by Contract
Select TOP 5 * from churn_cleaned

Select 
    count(*) [ No of Customer],
    Contract_Type,Churn_Flag from churn_cleaned
    Where Churn_Flag =1
    Group by Contract_Type,Churn_Flag
order by Count(*)


---------Churn by Contract with CASE STATEMNT---------
Select 
    Contract_Type,
    Count(*) [Total Customers],
    SUM(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) [Churned Customers]
from churn_cleaned
Group by Contract_Type

--Churn Rate by Contract
Select 
  Contract_Type,
  Count(*) [Total Customers],
    SUM(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) [Churned Customers],
    FORMAT(
        CAST(SUM(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) AS FLOAT) / Count(*), 
        'P2'
    ) [Churn Rate Percentage]
from churn_cleaned
Group by Contract_Type