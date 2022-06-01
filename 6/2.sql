CREATE VIEW first_view
AS SELECT CUSTOMER.customer_id, CUSTOMER.customer_name, LOAN.branch_name, LOAN.amount as amount_of_loan
FROM CUSTOMER inner join LOAN on Customer.customer_id = LOAN.customer_id  ; 

select * from first_view;



select ACCOUNT.account_number, interest_rate from
DEPOSITOR inner join account on DEPOSITOR.account_number = ACCOUNT.account_number
inner join saving_account on saving_account.account_number = ACCOUNT.account_number
where YEAR(access_date) > 2009



select payment_number from 
PAYMENT inner join LOAN on PAYMENT.loan_number = LOAN.loan_number 
inner join BRANCH on BRANCH.branch_name = LOAN.branch_name where branch_city ='tehran';