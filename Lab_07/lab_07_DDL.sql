

DROP TABLE HospitalSystem;
DROP TABLE Hospital;
DROP TABLE Citizen;
DROP TABLE DISTRICT;
DROP TABLE DIVISION;
DROP TABLE ACCIDENT;
DROP TABLE LICENSE;


create table DIVISION
(
    name VARCHAR2(55),
    capacity numeric(10,2),
    constraint PK_DIVISION_NAME primary key(name)
);


create table DISTRICT
(
    name VARCHAR2(55),
    capacity numeric(10,2),
    division_name varchar2(55),
    constraint PK_DISTRICT_NAME primary key(name),
    constraint FK_DIVISION_NAME FOREIGN key(division_name) references DIVISION(name)
);


create table HOSPITAL
(
    Hospital_id NUMBER,
    name VARCHAR2(55),
    contact_number NUMBER,
    CONSTRAINT PK_hospital PRIMARY key(Hospital_id)    
);


CREATE TABLE License
(
    License_ID NUMBER,
    type VARCHAR(55),
    Issued DATE,
    expiry DATE,
    constraint PK_LICENSE PRIMARY KEY (License_ID)
);


create table Citizen
(
    NID NUMBER,
    name VARCHAR2(55),
    DOB DATE,
    BloodGroup VARCHAR2(3),
    division_name VARCHAR2(55),
    district_name varchar2(55),
    License_ID NUMBER,
    CONSTRAINT PK_CITIZEN_NID PRIMARY KEY (NID),
    CONSTRAINT FK_DISTRICT_CITIZEN FOREIGN KEY (district_name) REFERENCES DISTRICT(name),
    CONSTRAINT FK_DIVISION_CITIZEN FOREIGN KEY (division_name) REFERENCES DIVISION(name),
    CONSTRAINT FK_LICENSE_CITIZEN FOREIGN KEY (license_ID) REFERENCES LICENSE(License_ID)
);


CREATE TABLE HospitalSystem
(
    id NUMBER,
    admission_date DATE,
    release_date DATE,
    NID NUMBER,
    hospital_id NUMBER,
    CONSTRAINT PK_hospital_SYSTEM primary key(id),
    CONSTRAINT FK_CITIZEN_NID_IN_HOSPITAL foreign key(NID) references Citizen(NID),
    CONSTRAINT FK_HOSPITAL FOREIGN KEY (hospital_id) references Hospital(hospital_id)
);


CREATE TABLE ACCIDENT 
(
    ACCIDENT_ID NUMBER,
    ACCIDENT_DATE DATE,
    DEATHS NUMBER,
    location varchar2(55),
    License_ID NUMBER,
    constraint PK_ACCIDENT PRIMARY KEY (ACCIDENT_ID),
    constraint FK_LICENSE_ACCIDNT FOREIGN KEY (License_ID) REFERENCES LICENSE(LICENSE_ID) ON DELETE CASCADE
);

