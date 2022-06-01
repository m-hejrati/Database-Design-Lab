CREATE TABLE logTable
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	ChangeDate DATETIME DEFAULT GETDATE(),
	Command NCHAR(6),
	OldPaymentNumber INT NULL,
	NewPaymentNumber INT NULL,
	OldPaymentDate Date NULL,
	NewPaymentDate Date NULL,
	OldPaymentAmount INT NULL,
	NewPaymentAmount INT NULL,
	OldLoanNumber INT NULL,
	NewLoanNumber INT NULL,
)
 
GO
 
CREATE TRIGGER paymentLogger
ON PAYMENT
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operation CHAR(6)
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
			INSERT INTO logTable (Command, ChangeDate, OldPaymentNumber, OldPaymentDate, OldPaymentAmount, OldLoanNumber)
			SELECT @operation, GETDATE(),  d.payment_number, d.payment_date, d.loan_number, d.loan_number
			FROM deleted d
 
	IF @operation = 'Insert'
			INSERT INTO logTable (Command, ChangeDate, NewPaymentNumber,  NewPaymentDate, NewPaymentAmount, NewLoanNumber)
			SELECT @operation, GETDATE(), i.payment_number, i.payment_date, i.payment_amount, i.loan_number
			FROM inserted i
 
	IF @operation = 'Update'
			INSERT INTO logTable (Command, ChangeDate, NewPaymentNumber, OldPaymentNumber, NewPaymentDate,OldPaymentDate, NewPaymentAmount, OldPaymentAmount, NewLoanNumber, OldLoanNumber)
			SELECT @operation, GETDATE(), i.payment_number, d.payment_number, i.payment_date, d.payment_date, i.payment_amount, d.payment_amount, i.loan_number, d.loan_number
			FROM deleted d, inserted i
END
GO


INSERT INTO PAYMENT (payment_number, payment_date, payment_amount, loan_number)
VALUES (6, '2022-01-08', 100 , 2);

select * from logTable
-- disable trigger paymentLogger on logTable


-------------------------------------------------------------------------------------------------------------
-- 4-B

CREATE TRIGGER triggerUpdate ON BRANCH
FOR UPDATE
AS
BEGIN
  IF UPDATE(branch_city)
  BEGIN
    ROLLBACK
    RAISERROR('Changes column name not allowed', 16, 1);
  END
END


UPDATE Branch
SET branch_city = 'Tehran'
WHERE branch_name = 'one';


--select * from Book;

disable trigger triggerUpdate on BRANCH;


CREATE TRIGGER triggerUpdate3 ON BRANCH
FOR UPDATE
AS
BEGIN
  IF UPDATE(branch_name)
  BEGIN
    ROLLBACK
    RAISERROR('Changes column name not allowed', 16, 1);
  END
END

UPDATE Branch
SET branch_name = 'five'
WHERE branch_city = 'Mashhad';

--Disable Foregin Key by using NOCHECK
ALTER TABLE dbo.LOAN
NOCHECK CONSTRAINT FK__LOAN__branch_nam__2B3F6F97

--select * from Book;

disable trigger triggerUpdate3 on BRANCH;