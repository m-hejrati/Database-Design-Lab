IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'week6_test2')
BEGIN
CREATE DATABASE week6_test2

END
GO
    USE week6_test2
GO


CREATE TABLE BRANCH (
    branch_name VARCHAR(64),
    branch_city VARCHAR(64),
	assets INT,
    PRIMARY KEY (branch_name)
);


CREATE TABLE EMPLOYEE (
    employee_id INT,
    employee_name VARCHAR(64),
	dependent_name VARCHAR(64),	
	telephone_number VARCHAR(20),
	starting_date DATE,
	employment_length INT,
    PRIMARY KEY (employee_id),
);


CREATE TABLE CUSTOMER (
	customer_id INT,
	customer_name VARCHAR(64),
	customer_street VARCHAR(64),
	customer_city VARCHAR(64),
	employee_id INT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (employee_id)
        REFERENCES EMPLOYEE (employee_id)
);


CREATE TABLE LOAN (
    loan_number INT,
	amount INT,
    branch_name VARCHAR(64),
	customer_id INT,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name)
        REFERENCES BRANCH (branch_name),
    FOREIGN KEY (customer_id)
        REFERENCES CUSTOMER (customer_id)
);


CREATE TABLE PAYMENT (
	payment_number INT,
	payment_date DATE,
	payment_amount INT,
	loan_number INT,
    PRIMARY KEY (payment_number),
    FOREIGN KEY (loan_number)
        REFERENCES LOAN (loan_number)
);


CREATE TABLE ACCOUNT (
	account_number INT,
	balance INT,
	customer_id INT,
    PRIMARY KEY (account_number),
);


CREATE TABLE CHECKING_ACCOUNT (
	account_number INT,
	overdraft_amount INT,
    PRIMARY KEY (account_number),
    FOREIGN KEY (account_number)
        REFERENCES ACCOUNT (account_number)
);


CREATE TABLE SAVING_ACCOUNT (
	account_number INT,
	interest_rate INT,
    PRIMARY KEY (account_number),
    FOREIGN KEY (account_number)
        REFERENCES ACCOUNT (account_number)
);

CREATE TABLE DEPOSITOR (
	customer_id INT,
	account_number INT,
	access_date DATE,
    PRIMARY KEY (customer_id, account_number),
    FOREIGN KEY (customer_id)
        REFERENCES CUSTOMER (customer_id),
    FOREIGN KEY (account_number)
        REFERENCES ACCOUNT (account_number)
);