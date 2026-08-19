--How many customers have churned?
Select 
        Count(*) [ No of Customer_Churn], Churn_Flag 
       from customer_behavior
Where Churn_Flag=1
Group by Churn_Flag

--— Overall Churn Rate 
Select 
      Count(*)/Count(CustomerID)*100,
      Churn_Flag
from customer_behavior

--— Churn by Subscription Type
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Subscription_Type
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Subscription_Type

--— Churn by Contract Type
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Contract_Type
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Contract_Type

--— Churn by Age group
Select
     Count(*) [No of Churned Customer],C2.Age_Group
From 
customer_behavior c1 Join customer_profile c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Age_Group
Order by Count(*) Desc

--— Churn by State
--Which State has more churned Customer
Select
     Count(*) [No of Churned Customer],C2.State
From 
customer_behavior c1 Join customer_profile c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.State
Order by Count(*) Desc
--— Churn by Internet Service
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Internet_Service
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Internet_Service
--— Churn by Payment Method
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Payment_Method
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Payment_Method
--— Contract + Subscription Churn 
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Contract_Type,c2.Subscription_Type
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Contract_Type,c2.Subscription_Type
Order by Count(*) Desc
--— Churn by Tech Support
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Tech_Support
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Tech_Support

---— Churn by Auto Pay
Select
     Count(c1.Churn_Flag) [No of Churned Customer],C2.Auto_Pay
From 
customer_behavior c1 Join customer_services c2 
ON c1.Customer_ID=c2.Customer_ID
Where c1.Churn_Flag =1
Group by c2.Auto_Pay

--— High-Value Customers Who Churned 
Select
     c1.Customer_ID,
     c1.customer_Name,     
     Count(*) [No of Churned Customer], 
     C2.Estimated_LTV
From customer_profile c1 
Join customer_services c2  
     ON c1.Customer_ID=c2.Customer_ID
Join customer_behavior c3 
     ON c1.Customer_ID = c3.Customer_ID 
Where c3.Churn_Flag =1 
      and Estimated_LTV > 30000
Group by c1.Customer_ID,c1.Customer_Name,  C2.Estimated_LTV 
order by C2.Estimated_LTV desc

--— High-Risk Customers With High LTV
Select
     c1.Customer_ID,
     c2.Estimated_LTV,
     C3.Risk_Segment
From customer_profile c1 
Join customer_services c2 
   ON c1.Customer_ID=c2.Customer_ID
join customer_behavior C3
   ON c2.Customer_ID=c3.Customer_ID
Where C2.Estimated_LTV >15000
and Risk_Segment ='High risk'
Group by  c2.Estimated_LTV,
          c3.Risk_Segment,
          c1.Customer_ID
Order by Estimated_LTV Desc

CREATE PROCEDURE High_RiskCustomers
AS
BEGIN
Select
     c1.Customer_ID,
     c2.Estimated_LTV,
     C3.Risk_Segment
From customer_profile c1 
Join customer_services c2 
   ON c1.Customer_ID=c2.Customer_ID
join customer_behavior C3
   ON c2.Customer_ID=c3.Customer_ID
Where C2.Estimated_LTV >15000
and Risk_Segment ='High risk'
Group by  c2.Estimated_LTV,
          c3.Risk_Segment,
          c1.Customer_ID
Order by Estimated_LTV Desc 
END
--------HIGH Risk Customer With HIGH LTV--------------------
Exec High_RiskCustomers

--— Churn Reasons
Select Count(*)[No of Customer Churned],Churn_Reason from customer_behavior
Where Churn_Flag =1
Group by Churn_Reason

--— Churn by Tenure Group- USE CASE
    Select min(Tenure_Months),max(Tenure_Months),avg(Tenure_Months) from customer_services
    Select * From customer_services
    where Tenure_Months is NULL

SELECT
    CASE
        WHEN Tenure_Months < 15 THEN 'New'
        WHEN Tenure_Months >= 15 AND Tenure_Months < 30 THEN 'Early'
        WHEN Tenure_Months >= 30 AND Tenure_Months < 72 THEN 'Established'
        WHEN Tenure_Months >= 72 THEN 'Loyal'
    END AS Tenure_Group
FROM customer_services                   

Churn by Satisfaction Level

SELECT
    CASE
        WHEN Satisfaction_Score < 4 THEN 'Very Low'
        WHEN Satisfaction_Score >= 4 AND Satisfaction_Score < 6 THEN 'Low'
        WHEN Satisfaction_Score >= 6 AND Satisfaction_Score < 8 THEN 'Medium'
        WHEN Satisfaction_Score >= 8 THEN 'High'
    END AS Satisfaction_Level,
    COUNT(*) AS Total_Customers,
    SUM(CAST(Churn_Flag AS INT)) AS Churned_Customer
FROM customer_behavior
GROUP BY
    CASE
        WHEN Satisfaction_Score < 4 THEN 'Very Low'
        WHEN Satisfaction_Score >= 4 AND Satisfaction_Score < 6 THEN 'Low'
        WHEN Satisfaction_Score >= 6 AND Satisfaction_Score < 8 THEN 'Medium'
        WHEN Satisfaction_Score >= 8 THEN 'High'
    END
ORDER BY  SUM(CAST(Churn_Flag AS INT)) DESC



--Does payment delay behavior correlate with churn?
 -- Q34: Churn by Payment Delay

SELECT
    CASE
        WHEN Payment_Delay_Days <= 7 THEN 'Low'
        WHEN Payment_Delay_Days >= 8 AND Payment_Delay_Days <= 15 THEN 'Medium'
        WHEN Payment_Delay_Days >= 16 AND Payment_Delay_Days <= 30 THEN 'High'
        WHEN Payment_Delay_Days > 30 THEN 'Critical'
    END AS Payment_Delay_Risk,
    COUNT(*) AS Total_Customers,
    SUM(CAST(Churn_Flag AS INT)) AS Churned_Customer
FROM customer_services c1
JOIN customer_behavior c2
    ON c1.Customer_ID = c2.Customer_ID
GROUP BY
    CASE
        WHEN Payment_Delay_Days <= 7 THEN 'Low'
        WHEN Payment_Delay_Days >= 8 AND Payment_Delay_Days <= 15 THEN 'Medium'
        WHEN Payment_Delay_Days >= 16 AND Payment_Delay_Days <= 30 THEN 'High'
        WHEN Payment_Delay_Days > 30 THEN 'Critical'
    END
ORDER BY SUM(CAST(Churn_Flag AS INT)) DESC;

--Give management a churn summary by customer segment.
SELECT
    c1.Customer_Segment,
    COUNT(*) AS Total_Customers,
    SUM(CAST(Churn_Flag AS INT)) AS Churned_Customer,
    CAST(
        AVG(c3.Estimated_LTV)
        AS DECIMAL(12,2)
    ) AS Average_LTV,

    CAST(
        SUM(
            CASE
                WHEN c2.Churn_Flag = 1
                THEN c3.Estimated_LTV
                ELSE 0
            END
        )
        AS DECIMAL(14,2)
    ) AS Revenue_At_Risk

FROM customer_profile c1

JOIN customer_behavior c2
    ON c1.Customer_ID = c2.Customer_ID

JOIN customer_services c3
    ON c1.Customer_ID = c3.Customer_ID

GROUP BY
    c1.Customer_Segment

ORDER BY
    SUM(CAST(Churn_Flag AS INT)) DESC;