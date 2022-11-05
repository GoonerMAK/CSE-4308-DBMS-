
SET SERVEROUTPUT ON SIZE 1000000

-- 1(a)

BEGIN
        DBMS_OUTPUT.PUT_LINE('200042115');
END;
/


-- 1(b)

DECLARE
username VARCHAR2 (20);
BEGIN
username := '&username';
DBMS_OUTPUT . PUT_LINE ( '' || USERNAME );
DBMS_OUTPUT . PUT_LINE ( 'Length of my name is ' || LENGTH(username));
END;
/


-- 1(c)

declare
i integer;
j integer;
begin
i := &i;     
j := &j;     
dbms_output.put_line(i+j);     
end;
/


-- 1(d)

DECLARE
D DATE := SYSDATE ;
BEGIN
DBMS_OUTPUT . PUT_LINE ( TO_CHAR ( SYSDATE, 'HH24 :MI:SS '));
END ;
/


-- 1(e)  (without CASE)

declare
i integer;
begin
i := &i;     
IF(mod(i, 2) = 0) THEN
    dbms_output.put_line('EVEN');
ELSE
    dbms_output.put_line('ODD');
END IF;
end;
/

-- (with CASE) --

declare
i integer;
begin
i := &i;     
CASE mod(i, 2)
WHEN 0 THEN dbms_output.put_line('EVEN');
ELSE DBMS_OUTPUT . PUT_LINE ( 'ODD');
END CASE;
end;
/


-- 1(f)

CREATE OR REPLACE
PROCEDURE PrimeCheck ( num IN NUMBER , Answer out varchar)
AS
BEGIN
    Answer :='Prime';

for i in 2..(num/2)
loop 
if mod(num, i) = 0 then Answer := 'Not Prime'; 
exit;
end if;
end loop;

END;
/


DECLARE
    num NUMBER;
    Answer varchar(10);
BEGIN
    num:=&num;
    PrimeCheck(num, Answer);
    dbms_output.put_line(Answer);
END ;
/




-- 2(a) --

CREATE OR REPLACE PROCEDURE RichestBranches ( N IN NUMBER)
AS
MaxRows number;
BEGIN
    SELECT COUNT(*) into MaxRows FROM branch; 

if(N > MaxRows) then dbms_output.put_line('Error.... Invalid rows');

else 
    for i in (SELECT * FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC) where ROWNUM <= N)
    loop  dbms_output.put_line(i.branch_name || '   ' || i.branch_city || '   ' || i.ASSETS);
    end loop;

end if;
END;
/


DECLARE
    N NUMBER;
BEGIN
    N:=&N;
    RichestBranches(N);
END ;
/


-- SELECT COUNT(*) FROM branch;
-- SELECT * from branch B ORDER BY B.assets DESC;
-- SELECT * FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC) WHERE ROWNUM <= 5;



-- 2(b) --

CREATE or REPLACE PROCEDURE CustomerStatus(name in varchar2)
AS
    NetLoan number;
    NetBalance number;
BEGIN 

    SELECT BalanceAmount into NetBalance from 
    (SELECT customer_name, SUM(balance) as BalanceAmount from account, depositor
    WHERE account.account_number = depositor.account_number and name = depositor.customer_name);

    SELECT LoanAmount into NetLoan from 
    (SELECT customer_name, SUM(amount) as LoanAmount from loan, borrower
    WHERE Loan.loan_number = borrower.loan_number and name = borrower.customer_name);
 
    if( NetBalance > NetLoan ) then dbms_output.put_line('Green Zone');
    else dbms_output.put_line('Red Zone');
    End if;
End;
/

DECLARE
    name VARCHAR2(55);
BEGIN
    name := '&name';
    CustomerStatus(name);
END;
/



-- -- 2(c) --        (tried to print all the taxes of all customers)

-- CREATE or REPLACE PROCEDURE TaxCheck() 
-- AS
--     Tax number;
-- BEGIN 

--     for i in (SELECT customer_name, SUM(balance) as BalanceAmount from account, depositor
--                 WHERE account.account_number = depositor.account_number
--                 Group by customer_name)

-- SELECT i.BalanceAmount INTO TAX;
--     loop  
        
--         if( i.BalanceAmount >= 750 ) then Tax := i.BalanceAmount*0.08;
--         ELSE Tax := 0;
        
--         DBMS_OUTPUT.put_line( 'Tax for ' || i.customer_name || ' is ' || Tax );    
--         end if;
--     end loop;

-- End;
-- /


-- DECLARE
--     name VARCHAR2(55);
-- BEGIN
--     name := '&name';
--     CustomerStatus(name);
-- END;
-- /



-- 2(c) --

CREATE OR REPLACE FUNCTION TaxDue(name varchar2) RETURN NUMBER
AS
    NetBalance number;
    Tax number;
BEGIN
    SELECT sum(account.balance) INTO NetBalance FROM account,depositor 
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    IF((NetBalance) >=750) THEN Tax := 0.08*NetBalance;
    ELSE Tax:=0;
    END IF;
    RETURN Tax;
END;
/

DECLARE
    Name varchar2(10);
BEGIN
    name := '&name';
    DBMS_OUTPUT.PUT_LINE(TaxDue(name));
END;
/



-- 2(d) --

CREATE OR REPLACE FUNCTION CategoryCheck(name varchar2) RETURN varchar2
AS
    NetLoan number;
    NetBalance number;
    Category varchar2(4);
BEGIN 

    SELECT BalanceAmount into NetBalance from 
    (SELECT customer_name, SUM(balance) as BalanceAmount from account, depositor
    WHERE account.account_number = depositor.account_number and name = depositor.customer_name);

    SELECT LoanAmount into NetLoan from 
    (SELECT customer_name, SUM(amount) as LoanAmount from loan, borrower
    WHERE Loan.loan_number = borrower.loan_number and name = borrower.customer_name);

    IF(NetBalance>1000 AND NetLoan<1000) THEN Category := 'C-A1';

    ELSIF (NetBalance<500 AND NetLoan>2000) THEN Category := 'C-C3';
    ELSE Category:='C-B1';
    END IF;

    RETURN Category;

END;
/


DECLARE
    Name varchar2(10);
BEGIN
    name := '&name';
    DBMS_OUTPUT.PUT_LINE(CategoryCheck(name));
END;
/