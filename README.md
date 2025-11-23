# Hospital Database Queries

This repository contains SQL queries for managing and analyzing a hospital database hosted on Aiven Postgres. The queries cover a wide range of operations, including retrieving patient information, handling appointments, billing, treatments, and managing staff data.

## Database Structure

The main tables used in the queries include:

- **Patients** – Patient information including ID, name, gender, and date of birth.
- **Doctors** – Doctor information including ID, name, specialization, and contact details.
- **Nurses** – Nurse details.
- **Appointments** – Appointment records linking patients, doctors, and nurses.
- **Admissions** – Patient admission details.
- **Bills** – Billing and payment information.
- **Prescriptions** – Medication prescribed during appointments.
- **Treatments** – Treatments associated with appointments.
- **Wards** – Hospital wards information.
- **Payments** – Payment transactions.

## Key Queries and Operations

1. **Patient Queries**
   - Retrieve all male patients born after 1990.
   - List patients with outstanding balances or unpaid bills.
   - Insert new patient records.

2. **Appointments**
   - View the 10 most recent appointments.
   - Rank appointments by patient or day.
   - Generate reports linking patients and doctors.
   - Record new appointments with validation via stored procedures.

3. **Doctors**
   - Count and list doctors by number of appointments.
   - Insert new doctor records using a stored procedure.
   - Analyze monthly metrics including cancellation rates.

4. **Treatments and Prescriptions**
   - List treatments for patients, including those without treatments.
   - Identify treatments without associated appointments.
   - Delete prescriptions linked to cancelled appointments.

5. **Billing**
   - Calculate average, minimum, and maximum total bill amounts.
   - Identify bills above average.
   - Calculate patient balances with outstanding amounts.





```sql
SET search_path TO hospital;
