
-- CREATE TABLES (columns only, no PK or FK yet)


-- Department table
CREATE TABLE Department (
    department_id INT,
    dept_name VARCHAR(50) NOT NULL,
    dept_location VARCHAR(50)
);

-- Room table
CREATE TABLE Room (
    room_id INT,
    room_type VARCHAR(25) NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(50)
);

-- Doctor table
CREATE TABLE Doctor (
    doctor_id INT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    salary DECIMAL(10,2),
    contact VARCHAR(20),
    department_id INT NOT NULL
);

-- Nurse table
CREATE TABLE Nurse (
    nurse_id INT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    salary DECIMAL(10,2),
    contact VARCHAR(20),
    department_id INT NOT NULL
);

-- Patient table
CREATE TABLE Patient (
    patient_id INT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    DOB DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact VARCHAR(20)
);

-- Medical_Record table 
CREATE TABLE Medical_Record (
    record_id INT,
    patient_id INT NOT NULL,  
    doctor_id INT NOT NULL,
    blood_type VARCHAR(30) NOT NULL,
    blood_group VARCHAR(30) NOT NULL,
    allergies VARCHAR(100)
);

-- Appointment table
CREATE TABLE Appointment (
    appointment_id INT,
    appointment_date DATE NOT NULL,
    appointment_venue VARCHAR(50) NOT NULL,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL
);

-- Admission table 
CREATE TABLE Admission (
    admission_id INT,
    appointment_id INT NOT NULL, 
    room_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    description VARCHAR(100)
);

-- Treatment table
CREATE TABLE Treatment (
    treatment_id INT,
    appointment_id INT NOT NULL,
    treatment_type VARCHAR(50) NOT NULL,
    treatment_date DATE NOT NULL
);

-- Prescription table
CREATE TABLE Prescription (
    prescription_id INT,
    treatment_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    date_issued DATE NOT NULL,
    date_to_finish DATE
);

-- Lab_Test table
CREATE TABLE Lab_Test (
    test_id INT,
    appointment_id INT NOT NULL,
    test_date DATE NOT NULL,
    test_result VARCHAR(200),
    test_type VARCHAR(50) NOT NULL
);

-- Payment table
CREATE TABLE Payment (
    payment_id INT,
    appointment_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL
);


--  ADD PRIMARY KEYS USING ALTER 


ALTER TABLE Department ADD PRIMARY KEY (department_id);
ALTER TABLE Room ADD PRIMARY KEY (room_id);
ALTER TABLE Doctor ADD PRIMARY KEY (doctor_id);
ALTER TABLE Nurse ADD PRIMARY KEY (nurse_id);
ALTER TABLE Patient ADD PRIMARY KEY (patient_id);
ALTER TABLE Medical_Record ADD PRIMARY KEY (record_id);
ALTER TABLE Appointment ADD PRIMARY KEY (appointment_id);
ALTER TABLE Admission ADD PRIMARY KEY (admission_id);
ALTER TABLE Treatment ADD PRIMARY KEY (treatment_id);
ALTER TABLE Prescription ADD PRIMARY KEY (prescription_id);
ALTER TABLE Lab_Test ADD PRIMARY KEY (test_id);
ALTER TABLE Payment ADD PRIMARY KEY (payment_id);


-- ADD UNIQUE CONSTRAINTS FOR 1-TO-1 RELATIONSHIPS
-- (to aviod duplicates in the database)


-- Each patient can only have one medical record 
ALTER TABLE Medical_Record ADD UNIQUE (patient_id);

-- Each appointment can only generate one admission
ALTER TABLE Admission ADD UNIQUE (appointment_id);


-- STEP 4: ADD FOREIGN KEYS USING ALTER TABLE


-- Doctor → Department
ALTER TABLE Doctor
ADD FOREIGN KEY (department_id) REFERENCES Department(department_id);

-- Nurse → Department
ALTER TABLE Nurse
ADD FOREIGN KEY (department_id) REFERENCES Department(department_id);

-- Medical_Record → Patient
ALTER TABLE Medical_Record
ADD FOREIGN KEY (patient_id) REFERENCES Patient(patient_id);

-- Medical_Record → Doctor
ALTER TABLE Medical_Record
ADD FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id);

-- Appointment → Doctor
ALTER TABLE Appointment
ADD FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id);

-- Appointment → Patient
ALTER TABLE Appointment
ADD FOREIGN KEY (patient_id) REFERENCES Patient(patient_id);

-- Admission → Appointment
ALTER TABLE Admission
ADD FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id);

-- Admission → Room
ALTER TABLE Admission
ADD FOREIGN KEY (room_id) REFERENCES Room(room_id);

-- Treatment → Appointment
ALTER TABLE Treatment
ADD FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id);

-- Prescription → Treatment
ALTER TABLE Prescription
ADD FOREIGN KEY (treatment_id) REFERENCES Treatment(treatment_id);

-- Lab_Test → Appointment
ALTER TABLE Lab_Test
ADD FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id);

-- Payment → Appointment
ALTER TABLE Payment
ADD FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id);





-- inseretd data for lab


INSERT INTO Department (department_id, dept_name, dept_location) VALUES
(1, 'Cardiology', 'Building A Floor 1'),
(2, 'Neurology', 'Building B Floor 2'),
(3, 'Orthopedics', 'Building C Floor 1'),
(4, 'Pediatrics', 'Building D Floor 3'),
(5, 'Radiology', 'Building E Floor 2');

INSERT INTO Room (room_id, room_type, capacity, location) VALUES
(1, 'Single', 1, 'Ward A'),
(2, 'Double', 2, 'Ward A'),
(3, 'Single', 1, 'Ward B'),
(4, 'Double', 2, 'Ward B'),
(5, 'ICU', 1, 'Critical Care'),
(6, 'General', 4, 'Ward C'),
(7, 'General', 4, 'Ward C');

INSERT INTO Doctor (doctor_id, first_name, last_name, salary, contact, department_id) VALUES
(1, 'James', 'Harrington', 6500, '07100112233', 1),
(2, 'Amelia', 'Stone', 6500, '07100445566', 1),
(3, 'Daniel', 'Okafor', 7000, '07100778899', 2),
(4, 'Fatima', 'Rahman', 7000, '07100998877', 2),
(5, 'Michael', 'Dawson', 7200, '07100334455', 3),
(6, 'Grace', 'Nwoye', 6800, '07100667788', 4);

INSERT INTO Nurse (nurse_id, first_name, last_name, salary, contact, department_id) VALUES
(1, 'Emily', 'Clark', 2800, '07911122334', 1),
(2, 'Hannah', 'Lewis', 2800, '07911122335', 1),
(3, 'Ibrahim', 'Sule', 3000, '07922233445', 2),
(4, 'Zainab', 'Musa', 3000, '07922233446', 2),
(5, 'Peter', 'Johnson', 3200, '07933344556', 3),
(6, 'Linda', 'Martins', 3200, '07933344557', 4);

INSERT INTO Patient (patient_id, first_name, last_name, DOB, gender, contact) VALUES
(1, 'John', 'Miller', '1989-04-12', 'Male', '07011100001'),
(2, 'Sophia', 'Adams', '1991-07-19', 'Female', '07011100002'),
(3, 'Ahmed', 'Khalid', '1985-11-03', 'Male', '07011100003'),
(4, 'Grace', 'Ofori', '1994-02-27', 'Female', '07011100004'),
(5, 'Daniel', 'Boateng', '1990-08-14', 'Male', '07011100005'),
(6, 'Mary', 'Collins', '1987-06-06', 'Female', '07011100006'),
(7, 'Samuel', 'Adeyemi', '1993-12-21', 'Male', '07011100007');

INSERT INTO Medical_Record
(record_id, patient_id, doctor_id, blood_type, blood_group, allergies) VALUES
(1, 1, 1, 'A', 'Positive', 'None'),
(2, 2, 1, 'B', 'Negative', 'Peanuts'),
(3, 3, 3, 'O', 'Positive', 'Penicillin'),
(4, 4, 4, 'AB', 'Positive', 'Latex'),
(5, 5, 5, 'A', 'Negative', 'None'),
(6, 6, 2, 'B', 'Positive', 'Dust'),
(7, 7, 6, 'O', 'Negative', 'None');

INSERT INTO Appointment
(appointment_id, appointment_date, appointment_venue, doctor_id, patient_id) VALUES
(1, '2026-01-05', 'Consultation Room 1', 1, 1),
(2, '2026-01-06', 'Consultation Room 2', 2, 1),
(3, '2026-01-07', 'Consultation Room 1', 3, 2),
(4, '2026-01-08', 'Consultation Room 3', 3, 3),
(5, '2026-01-09', 'Consultation Room 4', 5, 4),
(6, '2026-01-10', 'Consultation Room 2', 5, 5),
(7, '2026-01-11', 'Consultation Room 5', 6, 6),
(8, '2026-01-12', 'Consultation Room 1', 6, 7);

INSERT INTO Treatment
(treatment_id, appointment_id, treatment_type, treatment_date) VALUES
(1, 1, 'Hypertension Management', '2026-01-05'),
(2, 2, 'ECG Review', '2026-01-06'),
(3, 3, 'Neurological Assessment', '2026-01-07'),
(4, 4, 'Migraine Treatment', '2026-01-08'),
(5, 5, 'Bone Alignment Therapy', '2026-01-09'),
(6, 6, 'Physiotherapy Session', '2026-01-10'),
(7, 7, 'Pediatric Checkup', '2026-01-11'),
(8, 8, 'Follow Up Consultation', '2026-01-12');

INSERT INTO Prescription
(prescription_id, treatment_id, dosage, date_issued, date_to_finish) VALUES
(1, 1, 'One tablet twice daily', '2026-01-05', '2026-01-15'),
(2, 2, 'Aspirin once daily', '2026-01-06', '2026-01-16'),
(3, 3, 'Anti seizure medication', '2026-01-07', '2026-01-21'),
(4, 4, 'Pain relief tablets', '2026-01-08', '2026-01-18'),
(5, 5, 'Calcium supplements', '2026-01-09', '2026-01-29'),
(6, 6, 'Muscle relaxant', '2026-01-10', '2026-01-20'),
(7, 7, 'Vitamin syrup', '2026-01-11', '2026-01-25'),
(8, 8, 'General multivitamins', '2026-01-12', '2026-01-22'),
(9, 8, 'Pain relief gel', '2026-01-12', '2026-01-19');

INSERT INTO Lab_Test
(test_id, appointment_id, test_date, test_result, test_type) VALUES
(1, 1, '2026-01-05', 'Normal', 'Blood Test'),
(2, 2, '2026-01-06', 'Normal', 'ECG'),
(3, 3, '2026-01-07', 'Abnormal', 'MRI'),
(4, 4, '2026-01-08', 'Normal', 'CT Scan'),
(5, 5, '2026-01-09', 'Abnormal', 'X Ray'),
(6, 6, '2026-01-10', 'Normal', 'Ultrasound'),
(7, 7, '2026-01-11', 'Normal', 'Blood Test'),
(8, 8, '2026-01-12', 'Abnormal', 'ECG');

INSERT INTO Admission
(admission_id, appointment_id, room_id, admission_date, discharge_date, description) VALUES
(1, 1, 1, '2026-01-05', '2026-01-09', 'Cardiac monitoring'),
(2, 2, 2, '2026-01-06', '2026-01-10', 'Observation'),
(3, 3, 3, '2026-01-07', '2026-01-11', 'Neurology care'),
(4, 4, 4, '2026-01-08', '2026-01-12', 'Migraine observation'),
(5, 5, 6, '2026-01-09', '2026-01-14', 'Orthopedic recovery'),
(6, 6, 7, '2026-01-10', '2026-01-15', 'Physiotherapy support'),
(7, 7, 4, '2026-01-11', '2026-01-13', 'Child monitoring'),
(8, 8, 2, '2026-01-12', '2026-01-16', 'Routine admission');

INSERT INTO Payment
(payment_id, appointment_id, payment_method, payment_date, payment_status) VALUES
(1, 1, 'Card', '2026-01-05', 'Paid'),
(2, 2, 'Cash', '2026-01-06', 'Paid'),
(3, 3, 'Insurance', '2026-01-07', 'Paid'),
(4, 4, 'Card', '2026-01-08', 'Paid'),
(5, 5, 'Insurance', '2026-01-09', 'Paid'),
(6, 6, 'Cash', '2026-01-10', 'Pending'),
(7, 7, 'Card', '2026-01-11', 'Paid'),
(8, 8, 'Cash', '2026-01-12', 'Paid');

