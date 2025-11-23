--20. Create a stored procedure that adds a new record to the Doctors table.
--The procedure should accept the doctor’s ID, first name, last name, specialization, email, and
--phone number as input parameters.
--After creating the procedure, call it using a set of sample doctor details to insert a new doctor
--into the database.

CREATE PROCEDURE InsertNewDoctor ( 
 p_DoctorID VARCHAR(50), 
 p_FirstName VARCHAR(50),
 p_LastName VARCHAR(50),
 p_Specialization VARCHAR(50),
 p_Email VARCHAR(50),
 p_PhoneNumber VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO Doctors ("DoctorID", "FirstName", "LastName", "Specialization", "Email", "PhoneNumber")
VALUES (p_DoctorID, p_FirstName, p_LastName, p_Specialization, p_Email, p_PhoneNumber);
END;
$$;

CALL InsertNewDoctor(
    'D0009',
    'Dr. Michael',
    'Scott',
    'Orthopedics',
    'mscott@hospital.com',
    '555-8888'
);


--21. Create a stored procedure that records a new appointment and automatically performs
--validation before inserting.
--The procedure should accept an appointment ID, patient ID, doctor ID, appointment date, status,
--and nurse ID.
--Inside the procedure, implement the following logic:
--* Verify that the patient exists in the Patients table.
--* Verify that the doctor exists in the Doctors table.
--* If either does not exist, prevent the insertion and return an error message.
--* If both exist, insert the appointment into the Appointments table.
--After creating the procedure, call it with sample data to demonstrate both a successful and a
--failed insertion attempt.

CREATE OR REPLACE PROCEDURE RecordNewAppointment (
    p_AppointmentID VARCHAR(10),
    p_PatientID VARCHAR(10),
    p_DoctorID VARCHAR(10),
    p_AppointmentDate TIMESTAMP,
    p_Status VARCHAR(50),
    p_NurseID VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
DECLARE
    patient_exists BOOLEAN;
    doctor_exists BOOLEAN;
BEGIN
   
SELECT EXISTS (SELECT 1 FROM Patients WHERE "PatientID" = p_PatientID) INTO patient_exists;
SELECT EXISTS (SELECT 1 FROM Doctors WHERE "DoctorID" = p_DoctorID) INTO doctor_exists;

 IF NOT patient_exists THEN
 RAISE EXCEPTION 'Error: Patient ID % not found in Patients table.', p_PatientID;
 ELSIF NOT doctor_exists THEN

RAISE EXCEPTION 'Error: Doctor ID % not found in Doctors table.', p_DoctorID;      
ELSE
      
INSERT INTO Appointments ("AppointmentID", "PatientID", "DoctorID", "AppointmentDate", "Status", "NurseID")
VALUES (p_AppointmentID, p_PatientID, p_DoctorID, p_AppointmentDate, p_Status, p_NurseID);
        
RAISE NOTICE 'Success: New appointment % recorded.', p_AppointmentID;
END IF;
END;
$$;

CALL RecordNewAppointment(
    'A1000',
    'P0001',
    'D0001',
    '2025-12-01 10:00:00',
    'Scheduled',
    'N0001'
);