SET SERVEROUTPUT ON SIZE 1000000


-- 1 --

DECLARE 
number_of_rows number(3);
BEGIN 
UPDATE instructor SET salary = salary + salary * 0.1 
WHERE salary < 75000;
IF SQL%FOUND THEN
number_of_rows := SQL%ROWCOUNT ;
DBMS_OUTPUT . PUT_LINE ( number_of_rows || ' instructors incremented ');
END IF;
END ;
/


-- SELECT * FROM instructor
-- where salary < 75000;



-- 4 --

CREATE SEQUENCE STUDENT_ID_SEQUENCE
MINVALUE 1
MAXVALUE 99
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE TRIGGER STUDENT_ID_GENERATOR
BEFORE INSERT ON STUDENT 
FOR EACH ROW

DECLARE
	ID varchar(5);
BEGIN

	SELECT ID INTO ID FROM dual;

	:NEW.ID := STUDENT_ID_SEQUENCE.NEXTVAL ;

END;
/



-- create table student
-- 	(ID varchar(5), 
-- 	 name varchar(20) not null, 
-- 	 dept_name varchar(20), 
-- 	 tot_cred numeric(3,0) check (tot_cred >= 0),
-- 	 primary key (ID),
-- 	 foreign key (dept_name) references department (dept_name) on delete set null
-- 	);
--  insert into student values ('98988', 'Tanaka', 'Biology', '120');



-- 5 --

