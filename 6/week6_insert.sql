IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'week6_test2')
BEGIN
CREATE DATABASE week6_test2

END
GO
    USE week6_test2
GO

INSERT INTO BRANCH (branch_name, branch_city, assets)
VALUES ('one', 'Tehran', '12000'),
		('two', 'Tehran', '13000'),
		('three', 'mashhad', '15000');

INSERT INTO EMPLOYEE (employee_id, employee_name, dependent_name, telephone_number, starting_date, employment_length)
VALUES (1, 'Ali', 'Ali2', '123456', '2022-03-01', 2),
		 (2, 'Hasan', 'Hasan2', '234567', '2022-05-08', 1),
		 (3, 'Abbas', 'Abbas2', '345678', '2022-02-28', 4);

INSERT INTO CUSTOMER (customer_id, customer_name, customer_street, customer_city, employee_id)
VALUES (1, 'Ali', 'S12', 'Tehran', '1'),
		 (2, 'Hasan', 'S32', 'Tehran', '1'),
		 (3, 'Abbas', 'S32', 'Tehran', '2'),
		 (4, 'Ali2', 'S32', 'Tehran', '3');

INSERT INTO LOAN (loan_number, amount, branch_name, customer_id)
VALUES (1, 100, 'one', 2),
		 (2, 250, 'three', 1);

INSERT INTO PAYMENT (payment_number, payment_date, payment_amount, loan_number)
VALUES (1, '2022-05-08', 500 , 1),
		 (2, '2022-06-8', 600, 1);

INSERT INTO ACCOUNT (account_number, balance, customer_id)
VALUES (1, 500, 1),
		 (2, 200, 2),
		 (3, 800, 3),
		 (4, 700, 4);

INSERT INTO CHECKING_ACCOUNT (account_number, overdraft_amount)
VALUES (1, 100),
		 (2, 200);

INSERT INTO SAVING_ACCOUNT (account_number, interest_rate)
VALUES (3, 500),
		 (4, 600);

INSERT INTO DEPOSITOR (customer_id, account_number, access_date)
VALUES (1, 1, '2022-01-02'),
		 (2, 2, '2022-02-22'),
		 (4, 3, '2022-03-13');