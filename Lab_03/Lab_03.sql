--DROP TABLE account;
--DROP TABLE Customer;
--DROP TABLE DEPOSITOR_INFO;

/*CREATE table account 
(
    account_no char(5),
    balance number NOT NULL,
    CONSTRAINT PK_ACCOUNT_NO PRIMARY KEY (account_no)
);

CREATE table Customer 
(
    Customer_no char(5),
    Customer_name varchar2(20) NOT NULL,
    Customer_city varchar2(10),   
    CONSTRAINT PK_CUSTOMER_NO PRIMARY KEY (Customer_no)
);

CREATE table Depositor 
(
    account_no char(5),
    Customer_no char(5),
    CONSTRAINT PK_DEPOSITOR_NO PRIMARY KEY (account_no, Customer_no)
);


------------------TASK 2--------------------

--a
Alter table Customer ADD DATE_OF_BIRTH DATE;

--b
ALTER TABLE account MODIFY balance number(12,2);    

--c
ALTER TABLE Depositor RENAME COLUMN account_no TO A_NO;

ALTER TABLE Depositor RENAME COLUMN customer_no TO C_NO;

--d
Alter table Depositor RENAME TO DEPOSITOR_INFO;

--e
ALTER TABLE DEPOSITOR_INFO ADD CONSTRAINT FK_DEPOSITOR_ACCOUNT_NO FOREIGN KEY(A_NO) References account (account_no);

ALTER TABLE DEPOSITOR_INFO ADD CONSTRAINT FK_DEPOSITOR_CUSTOMER_NO FOREIGN KEY(C_NO) References Customer (Customer_no);



-------------------TASK 3---------------------

INSERT INTO account values('A-111', 11111);
INSERT INTO account values('A-222', 22222);
INSERT INTO account values('A-333', 333333);


INSERT INTO Customer values('C-111', 'mak', 'Dhaka', '01-dec-22');
INSERT INTO Customer values('C-222', 'AKASH', 'Khulna', '02-feb-22');
INSERT INTO Customer values('C-333', 'Mashrur', 'Barisal', '12-apr-2022');
INSERT INTO Customer values('C-444', 'Martin', 'Dhaka', '02-feb-2022');

INSERT INTO DEPOSITOR_INFO values('A-111', 'C-333');
INSERT INTO DEPOSITOR_INFO values('A-222', 'C-111');



--a--
SELECT account_no from account where balance < 100000;


--b--
SELECT Customer_name from Customer where Customer_city = 'Khulna';


--c--
SELECT Customer_name from Customer where Customer_name Like '%A%';


--d--
SELECT DISTINCT A_NO from DEPOSITOR_INFO;


--e--
SELECT * from account, DEPOSITOR_INFO;


--f--
SELECT * FROM Customer NATURAL JOIN DEPOSITOR_INFO;


--g--
SELECT Customer_name, Customer_city from Customer, DEPOSITOR_INFO 
where DEPOSITOR_INFO.C_NO = Customer.customer_no;


--h--
SELECT Customer_no, Customer_name, Customer_city, DATE_OF_BIRTH 
from Customer, DEPOSITOR_INFO, account 
where DEPOSITOR_INFO.C_NO = Customer.customer_no and 
      account.account_no = DEPOSITOR_INFO.A_NO and 
      account.balance > 1000;


--i--
SELECT account_no, balance from Customer, DEPOSITOR_INFO, account 
where DEPOSITOR_INFO.C_NO = Customer.customer_no and 
      DEPOSITOR_INFO.A_NO = account.account_no and 
      ( (account.balance BETWEEN 5000 AND 10000) or
      Customer.Customer_city = 'Dhaka');



delete from Customer;
delete from Account;
delete from DEPOSITOR_INFO;

-- D:\IUT 2-1\CSE 4308\Lab_03\Lab_03.sql

-- 
-- 
-- 