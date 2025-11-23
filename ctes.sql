--11. For each patient in the database, identify their most recent appointment and list it along with
--the patient’s ID.

WITH RankedAppointments AS (
select "PatientID","AppointmentID", "AppointmentDate",
ROW_NUMBER() OVER (PARTITION BY "PatientID" ORDER BY "AppointmentDate" DESC) as rn
from appointments)
select "PatientID" ,"AppointmentID", "AppointmentDate"
FROM RankedAppointments
where rn = 1
ORDER BY
"PatientID";


--12. For every appointment in the system, assign a sequence number that ranks each patient’s
--appointments from most recent to oldest.

select "AppointmentID","PatientID","AppointmentDate",
RANK() OVER (PARTITION BY "PatientID" ORDER BY "AppointmentDate" DESC) AS "Patient_Appointment_Rank"
from appointments
ORDER by "PatientID", "Patient_Appointment_Rank";

--13. Generate a report showing the number of appointments per day for October 2021, including a
--running total across the month.

WITH DailyAppointments AS (
SELECT
CAST("AppointmentDate" AS DATE) AS "Appointment_Day",
COUNT("AppointmentID") AS "Daily_Count"
from appointments
where "AppointmentDate" >= '2021-10-01' AND "AppointmentDate" < '2021-11-01'
GROUP by CAST("AppointmentDate" AS DATE)
)
SELECT
"Appointment_Day",
"Daily_Count",
SUM("Daily_Count") OVER (ORDER BY "Appointment_Day") AS "Running_Total"
from DailyAppointments
ORDER by "Appointment_Day";

--14. Using a temporary query structure, calculate the average, minimum, and maximum total bill
--amount, and then return these values in a single result set.

WITH BillAggregates AS (
SELECT
      AVG("TotalAmount") AS "Average_Bill_Amount",
      MIN("TotalAmount") AS "Minimum_Bill_Amount",
      MAX("TotalAmount") AS "Maximum_Bill_Amount"
from bills)
select "Average_Bill_Amount","Minimum_Bill_Amount","Maximum_Bill_Amount"
from BillAggregates;

--15. Build a query that identifies all patients who currently have an outstanding balance, based on
--information from admissions and billing records.

WITH OutstandingPatients AS (
SELECT distinct   a."PatientID"
from admissions a
join bills b 
ON a."AdmissionID" = b."AdmissionID"
Where b."OutstandingAmount" > 0
and b."OutstandingAmount" IS NOT NULL
)
select P."PatientID", P."FirstName", P."LastName"
from  Patients P
join OutstandingPatients OP
ON P."PatientID" = OP."PatientID"
ORDER by P."PatientID";

--16. Create a query that generates all dates from January 1 to January 15, 2021, and show how
--many appointments occurred on each of those dates.
with dateseries as (
select generate_series(
'2021-01-01'::date,  
'2021-01-15'::date,  
 interval '1 day'     
    ) as date_val
)
select
 to_char(d.date_val, 'yyyy-mm-dd') as date,
 count(a."AppointmentID") as appointments
from dateseries d
left join appointments a
on a."AppointmentDate"::date = d.date_val
group by d.date_val
order by
d.date_val;









   




