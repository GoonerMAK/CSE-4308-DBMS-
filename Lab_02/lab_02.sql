DROP TABLE student;

create table student
(
id varchar(6) primary key,
name varchar(20),
dept_name varchar(20),
tot_credits int
);


insert into STUDENT values('00128','Zhang','Comp. Sci.',102);
insert into STUDENT values ('12345', 'Shankar', 'Comp. Sci.', 32);
insert into STUDENT values('19991' ,'Brandt', 'History', 80);
insert into STUDENT values('23121' ,'Chavez' ,'Finance', 110);
insert into STUDENT values ('44553', 'Peltier', 'Physics' ,56);
insert into STUDENT values ('45678', 'Levy', 'Physics' ,46);
insert into STUDENT values ('54321' ,'Williams', 'Comp. Sci.' ,5);
insert into STUDENT values ('55739' ,'Sanchez', 'Music' ,38);
insert into STUDENT values ('70557' ,'Snow' ,'Physics' ,0);
insert into STUDENT values ('76543' ,'Brown' ,'Comp. Sci.', 58);
insert into STUDENT values ('76653' ,'Aoi' ,'Elec. Eng.', 60);
insert into STUDENT values ('98765' ,'Bourikas', 'Elec. Eng.', 9);
insert into STUDENT values ('98988' ,'Tanaka' ,'Biology' ,120);


SELECT id, name, dept_name,tot_credits FROM student;

SELECT id, name FROM student;

SELECT id, name FROM student WHERE tot_credits>100;

SELECT name, dept_name FROM student WHERE tot_credits>= 80 and tot_credits<=120;

SELECT id, name FROM student WHERE dept_name = 'Comp. Sci.';

SELECT name, tot_credits from student WHERE dept_name='Physics';

SELECT id, name FROM student WHERE dept_name='Comp. Sci.' or tot_credits>10;

SELECT DISTINCT dept_name FROM student;