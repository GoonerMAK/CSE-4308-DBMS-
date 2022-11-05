
--1


create OR REPLACE VIEW Advisor_Selection
AS
SELECT instructor.ID, instructor.name, instructor.dept_name	 FROM instructor;

SELECT * FROM Advisor_Selection;


--2

create OR REPLACE VIEW Student_Count 
AS 
SELECT instructor.name, COUNT(s_ID) The_Count FROM instructor, teaches, section, takes, student, advisor
WHERE instructor.ID = teaches.ID AND
		teaches.course_id = section.course_id AND
			takes.course_id = section.course_id AND
				takes.ID = student.ID AND
					student.ID = advisor.s_ID AND
						instructor.ID = advisor.i_ID
						GROUP BY instructor.name;

SELECT * FROM Student_Count;


--  SELECT instructor.name, COUNT(s_ID) The_Count FROM instructor  natural JOIN advisor
--  	GROUP BY instructor.name;



--3(a)

drop role students_role;
create ROLE student_role;
GRANT SELECT ON advisor to student_role;
GRANT SELECT ON course to student_role;

DROP USER student_user;
CREATE USER student_user IDENTIFIED BY s;
GRANT student_role TO student_user;


--3(b)

drop role course_teacher_role;
create ROLE course_teacher_role;
GRANT SELECT ON student to course_teacher_role;
GRANT SELECT ON course to course_teacher_role;

DROP USER course_teacher_user;
CREATE USER course_teacher_user IDENTIFIED BY ct;
GRANT course_teacher_role TO course_teacher_user;


--3(c)

drop role head_role;
create ROLE head_role;
GRANT course_teacher_role to head_role;
GRANT SELECT ON instructor to head_role;
GRANT insert ON instructor to head_role;


DROP USER head_user;
CREATE USER head_user IDENTIFIED BY h;
GRANT head_role TO head_user;



--3(d)

drop ROLE ADMIN_ROLE;
create ROLE ADMIN_ROLE;
GRANT SELECT ON department to ADMIN_ROLE;
GRANT SELECT ON instructor to ADMIN_ROLE;
GRANT UPDATE ON department TO ADMIN_ROLE;

DROP USER ADMIN_USER;
CREATE USER ADMIN_USER IDENTIFIED BY a;
GRANT ADMIN_ROLE TO ADMIN_USER;


GRANT CREATE SESSION TO student_user;
GRANT CREATE SESSION TO course_teacher_user;
GRANT CREATE SESSION TO head_user;
GRANT CREATE SESSION TO ADMIN_USER;


conn student_user/s;
SELECT * FROM system.advisor;     -- will show data
SELECT * FROM system.course;      -- will show data

SELECT * FROM system.instructor;  -- will not show data


conn head_user/h;

SELECT * FROM system.student;      	  -- will show data
SELECT * FROM system.course;	      -- will show data
SELECT * FROM system.instructor;      -- will show data

SELECT * FROM system.teaches;         -- will not show data

INSERT INTO system.instructor values ('12129', 'MAK', 'Comp. Sci.', '30000');
SELECT * FROM system.instructor;      


conn ADMIN_USER/a;
SELECT * FROM system.department;
SELECT * FROM system.instructor;

SELECT * FROM system.teaches;      -- will not show data

UPDATE system.department SET budget = 90000
WHERE dept_name = 'Comp. Sci.';

SELECT * FROM system.department;

