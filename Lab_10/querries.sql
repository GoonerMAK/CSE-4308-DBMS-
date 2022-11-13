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



-- 2 --

CREATE OR REPLACE PROCEDURE PRINT_TIME_SLOT
AS
BEGIN
    FOR i IN (SELECT I.ID AS ID,I.NAME AS NAME,TS.TIME_SLOT_ID AS TIME_SLOT_ID, 
				TS.DAY AS DAY, TS.start_hr AS Start_Hour, TS.start_min AS Start_minute ,
						TS.end_hr AS end_hour, TS.end_min AS end_minute
				FROM INSTRUCTOR I, TEACHES T, SECTION S,TIME_SLOT TS
				WHERE I.ID = T.ID AND   
                    T.COURSE_ID = S.COURSE_ID AND T.SEC_ID = S.SEC_ID AND T.SEMESTER = S.SEMESTER AND T.YEAR = S.YEAR AND
                    S.TIME_SLOT_ID = TS.TIME_SLOT_ID) LOOP
        dbms_output.put_line(i.ID || '   '|| i.NAME || '   '|| i.TIME_SLOT_ID || '   ' || i.DAY || 
			'   ' || i.Start_Hour || '   '  || i.Start_minute  || '   ' || i.end_hour || '   '  || i.end_minute);
    END LOOP;
END;
/

BEGIN 
     PRINT_TIME_SLOT;
END;
/

-- SELECT I.ID AS ID,I.NAME AS NAME,TS.TIME_SLOT_ID AS TIME_SLOT_ID, TS.DAY AS DAY, TS.start_hr AS Start_Hour, TS.start_min AS Start_minute ,TS.end_hr AS end_hour, TS.end_min AS end_minute
-- FROM INSTRUCTOR I, TEACHES T, SECTION S,TIME_SLOT TS
-- WHERE I.ID = T.ID AND   
--                     T.COURSE_ID = S.COURSE_ID AND T.SEC_ID = S.SEC_ID AND T.SEMESTER = S.SEMESTER AND T.YEAR = S.YEAR AND
--                     S.TIME_SLOT_ID = TS.TIME_SLOT_ID;



-- 3 --

CREATE OR REPLACE PROCEDURE FIND_ADVISORS(N IN NUMBER)
AS
MAX_ROW NUMBER;
BEGIN
    SELECT COUNT(*) INTO MAX_ROW 
    FROM (SELECT I.ID, I.NAME, I.dept_name, I.salary, Under_Supervison FROM 
			(SELECT i_id,count(*) Under_Supervison 
			FROM advisor 
			group by i_id)Supervision , instructor I where Supervision.i_id=I.ID
			order by Under_Supervison desc);

    IF(N>MAX_ROW) THEN 
        DBMS_OUTPUT . PUT_LINE ('Invalid...');
        RETURN;
    END IF;

    FOR j IN (SELECT * FROM (SELECT I.ID, I.NAME, I.dept_name, I.salary, Under_Supervison FROM 
			(SELECT i_id,count(*) Under_Supervison 
			FROM advisor 
			group by i_id)Supervision , instructor I where Supervision.i_id=I.ID
			order by Under_Supervison desc) 
			WHERE ROWNUM<=N) LOOP
        	DBMS_OUTPUT . PUT_LINE (j.ID || '		' || j.NAME ||  '		' || j.dept_name 
				|| ' 	'|| j.salary || ' 	' || j.Under_Supervison);
    END LOOP;

END;
/


DECLARE
    N NUMBER(5);
BEGIN 
    N := '&number';
    FIND_ADVISORS(N);

END;
/


-- SELECT I.ID, I.NAME, I.dept_name, I.salary, Under_Supervison FROM 
-- 			(SELECT i_id,count(*) Under_Supervison 
-- 			FROM advisor 
-- 			group by i_id)Supervision , instructor I where Supervision.i_id=I.ID
-- 			order by Under_Supervison desc;




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

CREATE OR REPLACE TRIGGER Assingning_Advisor
After INSERT ON STUDENT 
FOR EACH ROW
DECLARE 
	teacher_id varchar(5);

BEGIN

	SELECT ID INTO teacher_id FROM (SELECT ID FROM instructor I WHERE :NEW.dept_name = I.dept_name)
	WHERE ROWNUM <= 1;

	INSERT INTO ADVISOR VALUES(:NEW.ID, teacher_id);

End;
/

