-- case study payXpert by Vinay Solanki 

create database payXpert;

use payXpert;

-- creating the tables for database
create table Employee(
EmployeeID int primary key identity(1,1),
FirstName varchar(50),
LastName varchar(50),
DateOfBirth date,
Gender char(1),
Email varchar(100),
PhoneNumber varchar(15),
Address varchar(255),
Position varchar(50),
JoiningDate date,
TerminationDate date null
);

create table Payroll (
PayrollID int primary key identity(1,1),
EmployeeID int,
PayPeriodStartDate date,
PayPeriodEndDate date,
BasicSalary decimal(10,2),
OvertimePay decimal(10,2),
Deductions decimal(10,2),
NetSalary decimal(10,2),
foreign key (EmployeeID) references Employee(EmployeeID)
);


create table Tax(
TaxID int primary key identity(1,1),
EmployeeID int,
TaxYear int,
TaxableIncome decimal(10,2),
TaxAmount decimal(10,2),
foreign key (EmployeeID) references Employee(EmployeeID)
);

create table FinancialRecord (
RecordID int primary key identity(1,1),
EmployeeID int,
RecordDate date,
Description varchar(255),
Amount decimal(10,2),
RecordType varchar(50),
foreign key (EmployeeID) references Employee(EmployeeID)
);

--inserting values
insert into Employee (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, Address, Position, JoiningDate, TerminationDate)
values
('Rahul', 'Sharma', '1990-05-12', 'M', 'rahul.sharma@example.com', '9876543210', 'Mumbai, Maharashtra', 'Software Engineer', '2015-06-20', NULL),
('Priya', 'Singh', '1988-11-23', 'F', 'priya.singh@example.com', '9876501234', 'Bangalore, Karnataka', 'HR Manager', '2018-03-15', NULL),
('Ankit', 'Verma', '1992-01-08', 'M', 'ankit.verma@example.com', '9876522345', 'Chennai, Tamil Nadu', 'Data Analyst', '2019-09-10', NULL),
('Sneha', 'Iyer', '1995-02-20', 'F', 'sneha.iyer@example.com', '9876515678', 'Delhi, Delhi', 'Marketing Executive', '2020-01-05', NULL),
('Vikas', 'Patel', '1985-07-14', 'M', 'vikas.patel@example.com', '9876537890', 'Ahmedabad, Gujarat', 'Project Manager', '2013-04-22', '2022-07-31');

insert into Payroll (EmployeeID, PayPeriodStartDate, PayPeriodEndDate, BasicSalary, OvertimePay, Deductions, NetSalary)
values
(1, '2023-08-01', '2023-08-31', 60000, 5000, 2000, 63000),
(2, '2023-08-01', '2023-08-31', 80000, 2000, 5000, 77000),
(3, '2023-08-01', '2023-08-31', 55000, 3000, 1500, 56500),
(4, '2023-08-01', '2023-08-31', 45000, 4000, 1000, 48000),
(5, '2022-06-01', '2022-06-30', 100000, 6000, 3000, 103000);

insert into Tax (EmployeeID, TaxYear, TaxableIncome, TaxAmount)
values
(1, 2023, 720000, 72000),
(2, 2023, 960000, 96000),
(3, 2023, 660000, 66000),
(4, 2023, 540000, 54000),
(5, 2022, 1200000, 120000);

insert into FinancialRecord (EmployeeID, RecordDate, Description, Amount, RecordType)
values
(1, '2023-09-05', 'Monthly Salary', 63000, 'Income'),
(2, '2023-09-06', 'Tax Payment', 77000, 'Tax Payment'),
(3, '2023-09-05', 'Monthly Salary', 56500, 'Income'),
(4, '2023-09-05', 'Monthly Salary', 48000, 'Income'),
(5, '2022-07-01', 'Final Settlement', 103000, 'Income');

