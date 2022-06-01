CREATE DATABASE [Session6]
GO

USE [Session6]
GO 

CREATE TABLE [branch] (
  [branch name] nvarchar(30) primary key,
  [branch city] nvarchar(30),
  [assets] int
)
GO

CREATE TABLE [customer] (
  [customer id] int identity(1, 1) primary key,
  [customer name] nvarchar(30),
  [customer street] nvarchar(30),
  [customer city] nvarchar(30)
)
GO

CREATE TABLE [loan] (
  [loan number] int primary key,
  [loan amount] int,
  [customer id] int,
  [branch name] nvarchar(30),
  CONSTRAINT [FK loan for customer] foreign key ([customer id])
  references [dbo].[customer]([customer id]),
  CONSTRAINT [FK loan from branch] foreign key ([branch name])
  references [dbo].[branch]([branch name])
)
GO

CREATE TABLE [payment] (
  [payment number] int primary key,
  [payment amount] int,
  [payment date] datetime,
  [loan number] int,
  CONSTRAINT [FK payment of loan] foreign key ([loan number])
  references [dbo].[loan]([loan number])
)
GO

CREATE TABLE [employee] (
  [employee id] int identity(1, 1) primary key,
  [employee name] nvarchar(30),
  [dependent name] nvarchar(30),
  [employment length] int,
  [start date] date,
  [telephone number] nvarchar(30),
  [customer id] int,
  [manager id] int,
  CONSTRAINT [FK employee and customer] foreign key ([customer id])
  references [dbo].[customer]([customer id]),
  CONSTRAINT [FK employee and manager] foreign key ([manager id])
  references [dbo].[employee]([employee id])
)
GO

CREATE TABLE [account] (
  [account number] int primary key,
  [account date] datetime,
  [balance] int,
  [customer id] int,
  CONSTRAINT [FK account for customer] foreign key ([customer id])
  references [dbo].[customer]([customer id])
)
GO

CREATE TABLE [checking account] (
  [account number] int,
  [overdraft amount] int,
  CONSTRAINT [FK type for account - checking] foreign key ([account number])
  references [dbo].[account]([account number])
)
GO

CREATE TABLE [saving account] (
  [account number] int,
  [interest rate] float,
  CONSTRAINT [FK type for account - saving] foreign key ([account number])
  references [dbo].[account]([account number])
)
GO

-- constraint that allows one type for each account not both
-- it is defined on one table, which is not perfect, but it does work
CREATE OR ALTER TRIGGER noDuplicate on [dbo].[saving account]
AFTER INSERT AS
BEGIN
	IF EXISTS (SELECT * 
				FROM [saving account] AS [sa] 
				JOIN [checking account] AS [ca] 
				ON [sa].[account number] = [ca].[account number])
	BEGIN
		ROLLBACK
		RAISERROR('Duplicated Type', 16, 1)
	END
END
GO

INSERT INTO [Session6].[dbo].[customer] ([customer name], [customer street], [customer city])
VALUES	('John Arnott', 'Kings Road', 'London'),
		('Mark Avis', 'North Street', 'Blackburn'),
		('Zoe Bates', 'Church Street', 'Sunderland'),
		('Kay Campbell', 'Queen Street', 'Nottingham'),
		('Thelma Elkington', 'George Street', 'Southall')
SELECT * FROM [Session6].[dbo].[customer]
GO 

INSERT INTO [Session6].[dbo].[account] ([account number], [balance], [account date], [customer id])
VALUES	(24729819, 151250, '2022-04-25', 1),
		(15593829, 939760, '2022-04-22', 2),
		(78409460, 467030, '2022-04-15', 3),
		(41201152, 360820, '2022-04-19', 4),
		(94086190, 330700, '2022-04-07', 5)
SELECT * FROM [Session6].[dbo].[account]
GO

INSERT INTO [Session6].[dbo].[checking account] ([account number], [overdraft amount])
VALUES	(24729819, 5423),
		(78409460, 7745)
INSERT INTO [Session6].[dbo].[saving account] ([account number], [interest rate])
VALUES	(15593829, 31),
		(41201152, 10),
		(94086190, 23)
SELECT * FROM [Session6].[dbo].[checking account]
SELECT * FROM [Session6].[dbo].[saving account]
GO

INSERT INTO [Session6].[dbo].[branch] ([branch name] , [branch city], [assets])
VALUES	('Lloyds Bank', 'Swindon', 2968815),
		('Barclays', 'Gloucester', 9173451)
SELECT * FROM [Session6].[dbo].[branch]
GO

INSERT INTO [Session6].[dbo].[loan] ([loan number], [loan amount], [branch name], [customer id])
VALUES	(8806, 864108, 'Lloyds Bank', 1),
		(3035, 956583, 'Lloyds Bank', 2),
		(4068, 453637, 'Barclays', 3),
		(3545, 958090, 'Barclays', 1),
		(1418, 839608, 'Barclays', 4)
SELECT * FROM [Session6].[dbo].[loan]
GO

INSERT INTO [Session6].[dbo].[payment] ([payment number], [payment amount], [payment date], [loan number])
VALUES	(8642, 373118, '2022-05-02', 8806),
		(1858, 388344, '2022-06-02', 8806),
		(3141, 102646, '2022-07-02', 8806),
		(5614, 635545, '2022-05-12', 3035),
		(7101, 321038, '2022-06-12', 3035),
		(3731, 453637, '2022-06-18', 4068),
		(7283, 630935, '2022-06-04', 3545),
		(7768, 327155, '2022-07-04', 3545),
		(8138, 561016, '2022-05-21', 1418),
		(7491, 278529, '2022-06-21', 1418)
SELECT * FROM [Session6].[dbo].[payment]
GO

INSERT INTO [Session6].[dbo].[employee] ([employee name], [dependent name], [employment length], [start date], [telephone number], [customer id])
VALUES	('Anna Althea', 'Kaden Gessica', 1, '2022-03-21', '679-456-8985', 1),
		('Maryna Cephas', 'Talia Samar', 2, '2022-02-20', '490-721-9826', 4),
		('Pio Elfleda', 'Przemo Gobind', 4, '2021-12-18', '658-231-2064', 5),
		('Farrah Erle', 'Sanaa Darnell', 5, '2021-11-20', '380-429-3987', 1),
		('Astarte Raicheal', 'Waheed Wanyonyi', 6, '2021-10-08', '252-424-5843', 2),
		('Yosuke Ana', 'Eleuterio Marianna', 7, '2021-09-01', '499-878-9569', 3),
		('Frida Amalia', 'Omari Tom', 7, '2021-09-01', '588-699-2731', 4),
		('Shirley Neja', 'Siri Comhghall', 8, '2021-08-15', '357-788-2954', 3)
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 1 WHERE [employee id] = 2
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 1 WHERE [employee id] = 3
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 1 WHERE [employee id] = 4
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 2 WHERE [employee id] = 5
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 2 WHERE [employee id] = 6
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 2 WHERE [employee id] = 7
UPDATE [Session6].[dbo].[employee]
SET [manager id] = 3 WHERE [employee id] = 8
SELECT * FROM [Session6].[dbo].[employee]
GO

-- 1) a
USE [Session6]
GO
CREATE OR ALTER VIEW [vCustomer] AS
SELECT c.[customer name], c.[customer id], l.[loan amount], b.[branch name]
FROM [customer] AS c
JOIN [loan] AS l
	ON c.[customer id] = l.[customer id]
	JOIN [branch] AS b
		ON l.[branch name] = b.[branch name]
GO
SELECT * FROM [vCustomer]
GO

-- 1) b
USE [Session6]
GO
SELECT ac.*, t.[interest rate]
FROM [account] AS ac
JOIN [saving account] AS t
ON ac.[account number] = t.[account number]
WHERE ac.[account date] > '2022-04-18'  -- '2009-01-01'
GO 

-- 1) c
USE [Session6]
GO
SELECT p.[payment number], l.[loan number]
FROM [payment] AS p
JOIN [loan] AS l
ON p.[loan number] = l.[loan number]
JOIN [branch] AS b
ON l.[branch name] = b.[branch name]
WHERE b.[branch city] = 'Swindon'
GO 


-- 3) a) 
create or alter function getHighestInterestRate ()
returns int
as 
begin
	declare @accountNum int, @maxInterest int;
	
	select @maxInterest = max([saving account].[interest rate])
	from [saving account];

	select @accountNum = [account number]
	from [saving account]
	where [saving account].[interest rate] = @maxInterest;

	return @accountNum;
end
go

select * from [saving account]
declare @accountWithHighestRate int;
exec @accountWithHighestRate = getHighestInterestRate;
print @accountWithHighestRate;


-- 3) b)
create function getDepartmentName (@employeeId int)
returns navarchar(30)
as
begin
	declare @depName nvarchar(30);

	select @depName = [dependent name]
	from employee
	where [employee id] = @employeeId

	return @depName;
end


-- 4) a)
create table paymentLog(
	changeType nvarchar(10),
	paymentNumber int
	);
go

CREATE TRIGGER logForPayment
ON payment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operation varchar(10)
		SET @operation = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operation = 'Delete'
			INSERT INTO paymentLog (changeType, paymentNumber)
			SELECT @operation, d.[payment number]
			FROM deleted d
 
	IF @operation = 'Insert'
			INSERT INTO paymentLog (changeType, paymentNumber)
			SELECT @operation, [payment number]
			FROM inserted i
 
	IF @operation = 'Update'
			INSERT INTO paymentLog (changeType, paymentNumber)
			SELECT @operation, d.[payment number]
			FROM deleted d, inserted i
END
GO

select * from paymentLog
insert into payment([payment number], [payment amount], [payment date], [loan number])
values (1442, 400000, GETDATE(), 1418);
update payment
set [payment number] = 4446
where [payment number] = 1442
delete from payment where [payment number] = 4446
select * from paymentLog


-- 4) b)
Create TRIGGER noBranchNameUpdate ON Branch
FOR UPDATE AS 
BEGIN 
  IF UPDATE([branch name])
  BEGIN
    ROLLBACK
    RAISERROR('No change in branch name', 16, 1);
  END
END; 
go

select * from branch
update branch
set [branch name] = 'Amirkabir'
where [branch city] = 'Swindon'
select * from branch