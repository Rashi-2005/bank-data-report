use customer ;
select * from `bank data new` ;

-- 1st ques. Branch Wise Total Customers :-
select branch,count(ï»¿Customer_ID) from `bank data new` group by branch ;
-- 2nd ques. City Wise Total Account Balance :-
select city,sum(account_balance) from `bank data new` group by city ;
-- 3rd ques. Kaun sa transaction type sabse zyada use ho raha hai? 
select transaction_type,count(ï»¿Customer_ID) from `bank data new` group by transaction_type order by count(ï»¿Customer_ID) desc limit 1;
-- 4th ques. Har transaction type ka average amount kya hai? 
select transaction_type,avg(account_balance) as average_amount from `bank data new` group by transaction_type ;
-- 5th ques. Age group ke according customers ka distribution (BETWEEN 18 AND 25 THEN '18-25'),(bETWEEN 26 AND 35 THEN '26-35'),(BETWEEN 36 AND 50 THEN '36-50'),(ELSE '50+') :-
select ï»¿Customer_ID,city,age,
case
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 50 then '36-50'
else '50+'
end as age_group
from `bank data new` ;
-- 6th ques.  Kaun sa loan type sabse zyada liya gaya hai? 
select loan_type,sum(loan_amount) from `bank data new` group by loan_type order by sum(loan_amount) desc limit 1 ;
-- 7th ques. Average credit score per branch. 
select * from `bank data new` ;
select branch,avg(credit_score) from `bank data new` group by branch;
-- 8th ques. Kitne customers internet banking use karte hai? 
select sum(if(internet_banking="yes",1,0)) as counting from `bank data new` ;
-- 9th ques. Monthly Transaction Trend :- doubt
select monthname(transaction_date) as monthly,sum(transaction_amount) from `bank data new` group by monthname(transaction_date);
-- 10th ques.  Top 10 High Balance Customers 
select ï»¿Customer_ID,account_balance,row_number() over(order by account_balance desc) as top_10 from `bank data new` limit 10;
-- 11th ques. Sirf un customers ko include karo jinka balance 1 lakh se zyada hai :-
select ï»¿Customer_ID,sum(account_balance) from `bank data new` group by ï»¿Customer_ID having sum(account_balance)>100000;
-- 12th ques.  Customers Who Did Transactions Above Average :-
select ï»¿Customer_ID,transaction_amount from `bank data new` where transaction_amount>(select avg(transaction_amount) from `bank data new`);
-- 13th ques. Customers With Both Internet and Mobile Banking :-
select * from `bank data new` where internet_banking="yes" and mobile_banking="yes" ;
-- 14th ques.  Transaction Amount Greater Than Branch Average :-
select transaction_channel,transaction_amount from `bank data new` where transaction_amount>(select avg(transaction_amount) from `bank data new` where transaction_channel="branch");
-- 15th ques. Top 5 Customers Per Branch :-
select * from `bank data new`;
select branch,ï»¿Customer_id,account_balance from (select *,row_number() over(partition by branch order by account_balance desc) as highest from `bank data new`)
bd where highest<6; 
-- 16th ques.  Customers inactive for 60 days :- 
select ï»¿Customer_ID,transaction_date,last_login_days_ago as days from `bank data new` where last_login_days_ago>60 ;
describe `bank data new` ;
-- 17th ques. ustomers Whose Balance Is Higher Than Their City Average :- doubt ye h ki mujhe city order me chahiye
select ï»¿Customer_ID,city,account_balance from `bank data new` bd1 where account_balance>(select avg(account_balance) from `bank data new` bd2 where bd1.city=bd2.city);
-- 18th ques. Find Branch With Highest Average Transaction :-
select branch,avg(transaction_amount) from `bank data new` group by branch order by avg(transaction_amount) desc limit 1 ;

