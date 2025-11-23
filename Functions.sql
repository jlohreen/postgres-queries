select * from admissions;
select * from patients;
select * from appointments;
select * from bills;
select * from doctors;
select * from nurses;
select * from patients;
select * from payments;
select * from prescriptions;
select * from treatments;
select * from wards;

--1. Retrieve the list of all male patients who were born after 1990, including their patient ID, first
--name, last name, and date of birth.

select "PatientID","FirstName","LastName","DateOfBirth"
from patients
where "Gender" = 'M'
AND "DateOfBirth" > '1990-12-31'
ORDER by "DateOfBirth";


--2. Produce a report showing the ten most recent appointments in the system, ordered from the
--newest to the oldest.

select *from appointments
ORDER by "AppointmentDate" DESC
LIMIT 10;

--3. Generate a report that shows all appointments along with the full names of the patients and
--doctors involved.

select a."AppointmentID", a."AppointmentDate",
concat(p."FirstName",' ',p."LastName" )AS Patient_Name,
concat(d."FirstName",' ', d."LastName" )AS Doctor_Name
from appointments a
join
patients p 
ON a."PatientID" = p."PatientID"
join Doctors d
ON a."DoctorID" = a."DoctorID"
ORDER by a."AppointmentDate";


--4. Prepare a list that shows all patients together with any treatments they have received, ensuring
--that patients without treatments also appear in the results.

select p."PatientID",
concat(p."FirstName",' ',p."LastName" )AS Patient_Name  ,
t."TreatmentType", t."Outcome"
from patients p
left  join appointments a
ON p."PatientID" = a."PatientID"
left  join Treatments t
ON a."AppointmentID" = t."AppointmentID"
ORDER by p."PatientID", t."TreatmentID";

--5. Identify any treatments recorded in the system that do not have a matching appointment.

select t."TreatmentID",t."TreatmentType"
from Treatments t
left join appointments a ON t."AppointmentID" = a."AppointmentID"
where a."AppointmentID" IS NULL;


--6. Create a summary that shows how many appointments each doctor has handled, ordered from
--the highest to the lowest count.

select d."DoctorID",
concat(d."FirstName",' ', d."LastName" )AS Doctor_Name,
COUNT(a."AppointmentID") AS "TotalAppointments"
from  doctors d
join appointments a ON d."DoctorID" = a."DoctorID"
GROUP by d."DoctorID",d."FirstName", d."LastName"
ORDER by "TotalAppointments" DESC;

--7. Produce a list of doctors who have handled more than twenty appointments, showing their
--doctor ID, specialization, and total appointment count.


select d."DoctorID", d."Specialization",
COUNT(a."AppointmentID") AS "TotalAppointmentCount"
from doctors d
join appointments a ON d."DoctorID" = a."DoctorID"
GROUP BY d."DoctorID", d."Specialization"
having COUNT(a."AppointmentID") > 20
ORDER by "TotalAppointmentCount" DESC;

--8. Retrieve the details of all patients who have had appointments with doctors whose
--specialization is “Cardiology.”

SELECT p."PatientID",p."FirstName",p."LastName"
from Patients p
join appointments a
ON p."PatientID" = a."PatientID"
join Doctors d
ON a."DoctorID" = d."DoctorID"
WHERE d."Specialization" = 'Cardiology'
ORDER by p."PatientID";

--9. Produce a list of patients who have at least one bill that remains unpaid.

select p."PatientID", p."FirstName", p."LastName",b."OutstandingAmount"
from patients p
join  admissions a
on p."PatientID"=a."PatientID"
join bills b
on a."AdmissionID"=b."AdmissionID"
where  b."OutstandingAmount" is not null
and b."OutstandingAmount">0
order by p."PatientID";


--10. Retrieve all bills whose total amount is higher than the average total amount for all bills in
--the system.

select "BillID","TotalAmount" 
from bills
where "TotalAmount">(
select avg("TotalAmount")
from bills)
order by "TotalAmount";

--11. Modify the appointments table so that any appointment with a NULL status is updated to
--show “Scheduled.”

update appointments
set "Status" = 'Scheduled'
where  "Status" IS NULL;

--12. Remove all prescription records that belong to appointments marked as “Cancelled.”
select * from prescriptions
select * from doctors

delete from Prescriptions
where "AppointmentID" IN (
select "AppointmentID"
from appointments
where "Status" = 'Cancelled');

