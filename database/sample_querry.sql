-- Hospital Management System
-- Analytical Queries
-- Run sample_data.sql first before using these queries


-- 1. How many patients has each department seen?
SELECT d.dept_name, COUNT(DISTINCT a.patient_id) AS total_patients
FROM Appointment a
JOIN Doctor doc ON a.doctor_id = doc.doctor_id
JOIN Department d ON doc.department_id = d.department_id
GROUP BY d.dept_name
ORDER BY total_patients DESC;


-- 2. How long are patients staying on average per room type?
SELECT r.room_type, 
       ROUND(AVG(DATEDIFF(ad.discharge_date, ad.admission_date)), 1) AS avg_stay_days
FROM Admission ad
JOIN Room r ON ad.room_id = r.room_id
WHERE ad.discharge_date IS NOT NULL
GROUP BY r.room_type
ORDER BY avg_stay_days DESC;


-- 3. Which doctors have the most appointments?
SELECT d.first_name, d.last_name, dept.dept_name,
       COUNT(a.appointment_id) AS total_appointments
FROM Appointment a
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Department dept ON d.department_id = dept.department_id
GROUP BY d.doctor_id, d.first_name, d.last_name, dept.dept_name
ORDER BY total_appointments DESC;


-- 4. Which patients have had abnormal lab results?
SELECT p.first_name, p.last_name, lt.test_type, 
       lt.test_result, lt.test_date
FROM Lab_Test lt
JOIN Appointment a ON lt.appointment_id = a.appointment_id
JOIN Patient p ON a.patient_id = p.patient_id
WHERE lt.test_result = 'Abnormal'
ORDER BY lt.test_date DESC;


-- 5. Payment breakdown by method and status
SELECT payment_method, payment_status,
       COUNT(*) AS total_transactions
FROM Payment
GROUP BY payment_method, payment_status
ORDER BY payment_method;


-- 6. Who still has a pending payment?
SELECT p.first_name AS patient_first, p.last_name AS patient_last,
       d.first_name AS doctor_first, d.last_name AS doctor_last,
       a.appointment_date, pay.payment_method
FROM Payment pay
JOIN Appointment a ON pay.appointment_id = a.appointment_id
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
WHERE pay.payment_status = 'Pending'
ORDER BY a.appointment_date;


-- 7. What are the most common treatments?
SELECT treatment_type, COUNT(*) AS total_times_performed
FROM Treatment
GROUP BY treatment_type
ORDER BY total_times_performed DESC;


-- 8. Full patient journey from appointment to discharge
SELECT p.first_name, p.last_name,
       a.appointment_date,
       d.first_name AS doctor,
       dept.dept_name AS department,
       t.treatment_type,
       lt.test_type, lt.test_result,
       r.room_type,
       ad.admission_date, ad.discharge_date,
       pay.payment_method, pay.payment_status
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Department dept ON d.department_id = dept.department_id
LEFT JOIN Treatment t ON a.appointment_id = t.appointment_id
LEFT JOIN Lab_Test lt ON a.appointment_id = lt.appointment_id
LEFT JOIN Admission ad ON a.appointment_id = ad.appointment_id
LEFT JOIN Room r ON ad.room_id = r.room_id
LEFT JOIN Payment pay ON a.appointment_id = pay.appointment_id
ORDER BY p.last_name, a.appointment_date;


-- 9. Patients with known allergies
SELECT p.first_name, p.last_name, 
       mr.blood_group, mr.allergies
FROM Medical_Record mr
JOIN Patient p ON mr.patient_id = p.patient_id
WHERE mr.allergies IS NOT NULL 
AND mr.allergies != 'None'
ORDER BY p.last_name;


-- 10. Overall workload per department
SELECT dept.dept_name,
       COUNT(DISTINCT a.appointment_id) AS total_appointments,
       COUNT(DISTINCT ad.admission_id) AS total_admissions,
       COUNT(DISTINCT lt.test_id) AS total_lab_tests
FROM Department dept
LEFT JOIN Doctor d ON dept.department_id = d.department_id
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
LEFT JOIN Admission ad ON a.appointment_id = ad.appointment_id
LEFT JOIN Lab_Test lt ON a.appointment_id = lt.appointment_id
GROUP BY dept.dept_name
ORDER BY total_appointments DESC;