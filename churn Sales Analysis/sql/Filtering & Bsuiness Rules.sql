                         ----High-Value Customers----
Select TOP 5 * from churn_cleaned

Select Customer_ID , Estimated_LTV from churn_cleaned
Where Estimated_LTV > 50000
Order by Estimated_LTV Desc

                         -------At-Risk Customers-------
select Customer_ID, Risk_Segment,Satisfaction_Score from churn_cleaned
where Risk_Segment = 'High Risk' and Satisfaction_Score <5

                          --------Payment Risk--------
select Customer_ID,Payment_Delay_Days,Churn_Flag From churn_cleaned
Where Payment_Delay_Days> 5 and Churn_Flag =1

------------ Inactive customers------------------
Select TOP 5 * from churn_cleaned



