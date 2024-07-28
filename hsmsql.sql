CREATE DATABASE IF NOT EXISTS hospital_database;

--- CREATING SCHEMA FOR hospital_database ---
USE hospital_database;
--- -----------------------------------CREATING PATIENT TABLE --- -----------------------------
CREATE TABLE patient(patient_ID INT,
patient_lastName VARCHAR (20) NOT NULL,
patient_firstName VARCHAR (20) NOT NULL,
patient_phoneNumber INT (15) NOT NULL,
patient_bloodType VARCHAR (10) NOT NULL,
email VARCHAR (20) NOT NULL,
sicknes_type VARCHAR (10) NOT NULL,
gender VARCHAR (5),
admision_date DATE,
discharge_date DATE,
PRIMARY KEY(patient_ID));

DESCRIBE patient;

--- --------------------------------CREATING ROOM TABLE --- -------------------------------------
CREATE TABLE room(
room_ID INT NOT NULL,
room_type VARCHAR (10) NOT NULL,
patient_ID INT NOT NULL,
room_cost DECIMAL (10,2),
PRIMARY KEY (room_ID),
FOREIGN KEY (patient_ID) REFERENCES patient(patient_ID)
);
DESCRIBE TABLE room;

DESCRIBE room;

-------------------------- ---CREATE LAB SCREENING TABLE--- --------------------------------------

CREATE TABLE lab_screening(
lab_ID INT NOT NULL,
patient_ID INT NOT NULL,
doctor_ID INT NOT NULL,
technician_ID INT NOT NULL,
test_cost DECIMAL (10, 2),
date DATE,
PRIMARY KEY (lab_ID),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID),
FOREIGN KEY (doctor_ID) REFERENCES doctor (doctor_ID)
);
DESCRIBE lab_screening;

------------------------------- ---CREATING DOCTOR TABLE--- ----------------------------------

CREATE TABLE doctor(
doctor_ID INT NOT NULL,
designation VARCHAR (20) NOT NULL,
emp_ID INT NOT NULL,
qualification VARCHAR (10) NOT NULL,
dept_ID INT NOT NULL,
PRIMARY KEY (doctor_ID),
FOREIGN KEY (emp_ID) REFERENCES employee (emp_ID),
FOREIGN KEY (dept_ID) REFERENCES dept(dept_ID)
);

-------------------------------------- ---CREATE DEPARTMENT TABLE--- --------------------------------------

CREATE TABLE dept(
dept_ID INT  NOT NULL,
dept_name VARCHAR (20) NOT NULL,
dept_head VARCHAR (10),
emp_count INT,
PRIMARY KEY (dept_ID)
);

---------------------------------- ---CREATE EMPLOYEE TABLE--- ---------------------------------------------

CREATE TABLE employee(
emp_ID INT,
emp_LastName VARCHAR (30),
emp_FirstName VARCHAR (30),
emp_DOB DATE,
emp_employedDate DATE,
emp_email VARCHAR (20),
emp_dept VARCHAR (20),
emp_address VARCHAR (50),
dept_ID INT,
emp_NIN INT,
PRIMARY KEY (emp_ID),
FOREIGN KEY (dept_ID) REFERENCES dept (dept_ID)
);


----------------------------- ---CREATE BILL TABLE--- ------------------------------------------------

CREATE TABLE bill(
bill_ID INT NOT NULL,
date DATE NOT NULL,
room_cost DECIMAL (10,2),
test_cost DECIMAL (10,2) NOT NULL,
other_charges DECIMAL (10,2) NOT NULL,
prescription_cost DECIMAL (10,2) NOT NULL,
total DECIMAL (10,2) NOT NULL,
patient_ID INT NOT NULL,
prescription_ID INT NOT NULL,
lab_ID INT NOT NULL,
room_ID INT NOT NULL,
remaining_balance DECIMAL (10,2) NOT NULL,
policy_number INT NOT NULL,
PRIMARY KEY (bill_ID),
FOREIGN KEY (patient_ID) REFERENCES patient(patient_ID),
FOREIGN KEY (room_ID) REFERENCES room (room_ID),
FOREIGN KEY (prescription_ID) REFERENCES prescription (prescription_ID),
FOREIGN KEY (policy_number) REFERENCES insurance (policy_number),
FOREIGN KEY (lab_ID) REFERENCES lab_screening(lab_ID)
);


--------------------------- ---CREATE INSURANCE TABLE--- ---------------------------------------------

CREATE TABLE insurance(
policy_number INT NOT NULL,
patient_ID INT NOT NULL,
insurance_code INT NOT NULL,
policy_startDate DATE NOT NULL,
policy_provider VARCHAR (50) NOT NULL,
insurance_plan VARCHAR (20) NOT NULL,
company_pay DECIMAL (10,2),
insurance_cover VARCHAR (30),
maternity BOOLEAN,
dental BOOLEAN,
optical BOOLEAN,
PRIMARY KEY (policy_number),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID)
);

DESCRIBE insurance;

-------------------------------- ---CREATE PRESCRIPTION TABLE--- ---------------------------------------

CREATE TABLE prescription(
prescription_ID INT NOT NULL,
prescription_name VARCHAR (10) NOT NULL,
prescription_quantity INT NOT NULL,
prescription_cost DECIMAL (10,2),
patient_ID INT NOT NULL,
PRIMARY KEY (prescription_ID),
FOREIGN KEY (patient_ID) REFERENCES patient(patient_ID)
);

DROP TABLE prescription;

ALTER TABLE prescription
ADD doctor_ID INT;

DESCRIBE prescription;

ALTER TABLE prescription
ADD medicine_ID INT;

ALTER TABLE prescription
ADD dossage INT;

ALTER TABLE prescription
RENAME COLUMN dossage TO dosage;

ALTER TABLE prescription 
ADD date DATE;

ALTER TABLE prescription
DROP prescription_name;

ALTER TABLE prescription
DROP prescription_quantity;

ALTER TABLE prescription
DROP prescription_cost;

ALTER TABLE prescription
ADD FOREIGN KEY (medicine_ID) REFERENCES medicine(medicine_ID);

----------------------------------- ---CREATE MEDICINE TABLE--- --------------------------------------

CREATE TABLE medicine(
medicine_ID INT NOT NULL,
medicine_name VARCHAR(10) NOT NULL,
medicine_quantity INT NOT NULL,
medicine_cost DECIMAL (10,2),
PRIMARY KEY (medicine_ID)
);

DESCRIBE medicine;

----------------------------- ---CREATE MEDICAL HISTORY TABLE--- --------------------------------------

CREATE TABLE medical_history(
record_ID INT NOT NULL,
patient_ID INT NOT NULL,
allergies VARCHAR (20),
underline_conditionS VARCHAR (20),
PRIMARY KEY (record_ID),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID)
);

DESCRIBE medical_history;

-------------------------------- ---CREATE EMERGENCY CONTANCT TABLE--- --------------------------------

CREATE TABLE emergency_contact(
contact_ID INT NOT NULL,
contact_name VARCHAR (20),
contact_phone INT NOT NULL,
relationship VARCHAR (10),
patient_ID INT NOT NULL,
contact_address VARCHAR (50),
PRIMARY KEY (contact_ID),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID)
);

DESCRIBE emergency_contact;

---------------------------------- ---CREATE APPOINTMENT TABLE--- --------------------------------------

CREATE TABLE appointment (
appt_ID INT NOT NULL,
schedule_appt DATETIME,
booking_date DATE,
booking_time TIME,
doctor_ID INT NOT NULL,
Patient_ID INT NOT NULL,
PRIMARY KEY (appt_ID),
FOREIGN KEY (doctor_ID) REFERENCES doctor (doctor_ID),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID)
);

DESCRIBE appointment;

------------------------ ---CREATE NURSE TABLE--- ----------------------------------------------------

CREATE TABLE nurse(
nurse_ID INT NOT NULL,
doctor_ID INT NOT NULL,
patient_ID INT NOT NULL,
emp_ID INT NOT NULL,
dept_ID INT NOT NULL,
PRIMARY KEY (nurse_ID),
FOREIGN KEY (doctor_ID) REFERENCES doctor (doctor_ID),
FOREIGN KEY (patient_ID) REFERENCES patient (patient_ID),
FOREIGN KEY (emp_ID) REFERENCES employee (emp_ID),
FOREIGN KEY (dept_ID) REFERENCES dept (dept_ID)
);

DESCRIBE nurse;


---------------------------- ---CREATE PAYROLL TABLE--- ----------------------------------------------

CREATE TABLE payroll(
account_no INT NOT NULL,
salary DECIMAL (10,2),
bonus DECIMAL (10,2),
emp_ID INT NOT NULL,
iban INT, 
PRIMARY KEY (account_no),
FOREIGN KEY (emp_ID) REFERENCES employee (emp_ID)
);

DESCRIBE payroll;