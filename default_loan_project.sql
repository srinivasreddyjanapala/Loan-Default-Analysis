create database loan_default;

use loan_default;

select * from loan_default;

select min(Age),max(Age),min(income),max(income),min(loanamount),max(loanamount),min(creditscore),max(creditscore)
from loan_default;


create  view customer_details as 
select trim(loanid)loan_id,age,round(income) as income,loanamount,creditscore,monthsemployed,NumCreditLines,round(InterestRate,2) as interest_rate,
loanterm,round(DTIRatio,2) as DTIRatio,trim(Education) as Education,trim(EmploymentType) as EmploymentType,trim(MaritalStatus) as MaritalStatus,
trim(HasMortgage) as HasMortgage,trim(HasDependents) as HasDependents,trim(LoanPurpose) as LoanPurpose,trim(HasCoSigner) as HasCoSigner,
default_customer,
case 
when age between 18 and 30 then 'young_age'
when age between 31 and 50 then 'middle_age'
else "50+" end  as age_group,
case when income between 15000 and 25000 then 'low_income'
when income > 25000 and income <=70000 then 'middle_income'
when income > 70000 and income <=120000 then 'high_income'
else 'very_high_income' end as income_group,
case when creditscore <650 then 'risky_customers'
else 'valueable_customers' end as credit_risk_customers
from loan_default;

#1.Total loans and overall default rate.

select count(loan_id) as total_loans,sum(default_customer) as total_defaults, round(sum(default_customer)/count(loan_id) *100,2) as default_percent
from customer_details;


#2.Default rate by age group (young_age, middle_age, 50+).

SELECT 
    age_group,
    COUNT(*) AS total_loans,
    SUM(default_customer) AS defaults,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY age_group
ORDER BY default_rate DESC;

#3.Default rate by income group (low_income, middle_income, high_income, very_high_income).

select income_group,count(*) as total_loans,sum(default_customer) as defaults,
round(sum(default_customer)/count(*)*100,2) as default_per
from customer_details
group by income_group;

#4.Default rate by credit risk customers (risky_customers vs valuable_customers).

select credit_risk_customers,count(*) as total_loans,sum(default_customer) as defaults,
round(sum(default_customer)/count(*)*100,2) as default_per
from customer_details
group by credit_risk_customers;

#5.Loan distribution by purpose (Auto, Education, Business, Personal).

SELECT 
    LoanPurpose,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY LoanPurpose
ORDER BY total_loans DESC;

# followup question:
select LoanPurpose,count(*) as total_loans,sum(default_customer) as defaults,round(sum(default_customer)/count(*)*100,2) as default_rate
from customer_details
where EmploymentType= 'Unemployed'
group by LoanPurpose;

#6.Default rate by employment type.

select EmploymentType,count(*) as total_loans,sum(default_customer) as total_defaults,
round(sum(default_customer)/count(*) *100,2) as default_rate
from customer_details
group by EmploymentType
order by default_rate desc;



#7. Default rate by marital status

SELECT 
    MaritalStatus,
    COUNT(*) AS total_loans,
    SUM(default_customer) AS defaults,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY MaritalStatus
ORDER BY default_rate DESC;

#8. Default rate: with vs without mortgage.

SELECT 
    HasMortgage,
    COUNT(*) AS total_loans,
    SUM(default_customer) AS defaults,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY HasMortgage;

#9.Default rate: with vs without co-signer.

SELECT 
    HasCoSigner,
    COUNT(*) AS total_loans,
    SUM(default_customer) AS defaults,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY HasCoSigner;

#10.Average Loan-to-Income ratio of defaulters vs non-defaulters.

select default_customer,count(*) as loans,avg(income) as avg_income,avg(loanamount) as avg_loan_amount
from customer_details
group by default_customer;


#11.Correlation proxy: Does higher credit score reduce default probability?
SELECT 
    CASE 
        WHEN creditscore < 580 THEN 'Poor (<580)'
        WHEN creditscore BETWEEN 580 AND 669 THEN 'Fair (580-669)'
        WHEN creditscore BETWEEN 670 AND 739 THEN 'Good (670-739)'
        WHEN creditscore BETWEEN 740 AND 799 THEN 'Very Good (740-799)'
        ELSE 'Exceptional (800+)' END AS credit_score_band,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(default_customer)/COUNT(*),2) AS default_rate
FROM customer_details
GROUP BY credit_score_band
ORDER BY default_rate DESC;

#12.Interest rate distribution among defaulters vs non-defaulters.

select default_customer ,round(avg(interest_rate),2) as avg_interest_rate
from customer_details
group by default_customer;

#13.Loan term effect: short-term vs long-term loans and their default rates.

select loanterm,sum(default_customer),count(*) as total_loans,round(sum(default_customer)/count(*)*100,2) as default_rate
from customer_details
group by loanterm.


