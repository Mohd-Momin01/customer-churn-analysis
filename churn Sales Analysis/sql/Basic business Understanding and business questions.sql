
                                                -- Total No of customer____
Select count(Customer_ID) [Total_Customer] From churn_cleaned

Select TOP 5 * From Churn_Cleaned

                                                 --Customer Demographics--
select Gender , Count(*) [No of Customer] From churn_cleaned
Group by Gender

                                              --Locationwise (State) footprint--
Select State, Count(*) [No of Customer] From churn_cleaned
group by State
order by Count(*) Desc

                                             --Customer Segments--  
select Subscription_Type,count(*)[No of Customer]
From churn_cleaned
Group by Subscription_Type
Order By Count(*) Desc

                                              --Subscription Mix--


