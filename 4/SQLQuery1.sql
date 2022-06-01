----------------------------------------------------------------
--1)
create procedure classStatusSP @res varchar(10) output
as
begin

	declare @num int
	select @num  = count(*) from tblstudent where stugrade < 10

	if (@num <= 1)
		begin
			set @res = 'GOOD'
		end
	else if (@num <= 3)
		begin
			set @res = 'Normal'
		end
	else
		begin
			set @res = 'Bad'
		end
end
Go

declare @result varchar(10)
exec classStatusSP @res = @result output
print (@result)

----------------------------------------------------------------
--2)
create procedure classShiftSP @num int
as
begin

	declare @localNum int
	select @localNum  = count(*) from tblstudent where stugrade < 10

	if (@localNum < @num)
		begin
			UPDATE tblstudent
			SET stuGrade = stuGrade + 1
			WHERE stuGrade BETWEEN 9 AND 10;
		end
	else
		begin
			UPDATE tblstudent
			SET stuGrade = stuGrade + 0.5
			WHERE stuGrade BETWEEN 9.5 AND 10;
		end
end
Go

exec classShiftSP 5
select * from tblstudent

----------------------------------------------------------------
--3)
create procedure swapNum @a int output, @b int output
as
begin
declare @tmp int
select @tmp = @a
select @a = @b
select @b = @tmp
end
GO

declare @first int, @second int 
select @first = 123, @second = 24
exec swapNum @a = @first output, @b = @second output

print (@first)
print (@second)

----------------------------------------------------------------
--4)
create function gradeFunc (@name nvarchar(20))
returns int
as
begin
declare @grade real;
select @grade = stugrade from tblstudent where stuname=@name
return @grade;
end

declare @return nvarchar(20);
exec @return=gradeFunc @name='ali'
print @return;




create function dd
returns int
begin
declare @num int;
select @num = DATENAME(DAY, getdate())
return @num + 4;
end 

declare @return int;
exec @return =dd
print @return 


create function dd2 (@num int)
returns int
begin
return @num + 4;
end 

declare @return int;
declare @a int;
set @a = DATENAME(DAY, getdate())
exec @return =dd2 @a
print @return
