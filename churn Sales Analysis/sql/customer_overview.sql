--Customer Distribution by State
Select count(*) [No of Customer],State from customer_profile
Group by State
Order by Count(*) Desc

--Customer Segment Distribution
Select Count(*) [No of Customer], Customer_Segment from customer_profile
Group by Customer_Segment

--— Subscription Distribution
Select Count(*) [No of Customer], s.Subscription_Type from customer_profile c join customer_services s
ON c.Customer_ID = s.Customer_ID
group by s.Subscription_Type

--Contract Distribution
Select Count(*) [No of Customer], s.Contract_Type from customer_profile c join customer_services s
ON c.Customer_ID = s.Customer_ID
group by s.Contract_Type

--What is the average monthly amount charged to a customer?
Select count(*) [No of Customer],
Format(Avg(s.Monthly_Charges),'N0')[Avg of Monthly charges]
from customer_profile c join customer_services s
ON c.Customer_ID = s.Customer_ID

--What is the total annual revenue represented by the current customer base?
Select Customer_ID ,Format(Sum(Annual_Charges),'N0') [Total Revenue] from customer_services
Group by Customer_ID

--Average Customer Lifetime Value
Select Format(Avg(Estimated_LTV),'N0')  from customer_services

--— Revenue by Customer Segment
--Which customer segment contributes the most annual revenue?
Select  c.customer_Segment, Format(SUM(Annual_Charges),'N0') [Annual Revenue by Segment] from customer_profile c join customer_services s 
ON c.Customer_ID= s.Customer_ID
group by c.Customer_Segment
Order by Sum(s.Annual_Charges) Desc

--Which customer segment has the highest average customer lifetime value?
Select  c.customer_Segment, Format(Avg(lifeTime_Value),'N0') [Average LTV by Segment] from customer_profile c join customer_services s 
ON c.Customer_ID= s.Customer_ID
group by c.Customer_Segment
Order by Avg(s.lifetime_value) Desc

--Which subscription type generates the most annual revenue?
Select 
   Subscription_Type,
   Format(Sum(Annual_Charges),'N0') [Annual Revenue] 
from customer_services
Group by Subscription_Type
order by Sum(annual_Charges) Desc

--What proportion of customers are on each contract type?
Select Count(*) [No of Customer],Contract_Type from customer_services
group by Contract_Type
Order by Count(*) Desc

--Which contract type has customers with the longest average relationship with the company?
Select Count(*) [No of Customer], Contract_Type, Avg(Tenure_Months)[Avg Tenure Month] from customer_services
Group by Contract_Type
Order by Count(*) desc

--Give management a high-level snapshot of the customer base.
Select 
   Count(*) [No of Customer],
   Format(Avg(Monthly_charges),'N0') [Avg Monthly Charges],
   Format(Sum(Annual_Charges),'N0')[Total_annual_Revenue],
   Format(Avg(Lifetime_Value),'N0') [Avg Lifetime_Value],
   Format(Avg(Tenure_Months),'N0')[Avg Tenure Month] 
from customer_services









