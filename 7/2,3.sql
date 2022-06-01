---22
create procedure bank_customeeer @name varchar(64), @bal int output, @acc_num int output
as
begin
select @bal = balance , @acc_num = account_number from ACCOUNT inner join 
CUSTOMER on CUSTOMER.customer_id = ACCOUNT.customer_id where customer_name = @name
end
GO

declare @bala int , @acc_number int

exec bank_customeeer  'Ali',  @bal=@bala output ,@acc_num = @acc_number output 

print @bala
print @acc_number




----------------------
--2
create procedure payment_info  @pay int , @branch varchar(64) output 
as
begin
select @branch = branch_name  from PAYMENT inner join 
LOAN on LOAN.loan_number = PAYMENT.loan_number where PAYMENT.payment_number = @pay
end
GO

declare @b_name varchar(64);

exec payment_info 1,@branch = @b_name output


----------------------


create function accnum ()
returns int
as 
begin
	declare @num int;
	select @num = ACCOUNT.account_number  from ACCOUNT inner join SAVING_ACCOUNT on ACCOUNT.account_number = SAVING_ACCOUNT.account_number
	where ACCOUNT.account_number =(select max(interest_rate) from SAVING_ACCOUNT)
	print @num
	return @num

end

declare @res int;
exec @res = accnum ;
print @res
-------------------------
create function employeeee (@idd int)
returns varchar(64)
begin
	declare @num varchar(64);
	select @num = dependent_name  from EMPLOYEE where employee_id= @idd
	return @num
end

declare @return varchar (64);
exec @return =employeeee   @idd = 2;
---------------------


