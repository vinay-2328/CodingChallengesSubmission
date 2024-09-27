create table Employee (
empID int primary key identity(1,1),
emp_name varchar(100)
);
create table Salary (
empID int,
salary int,
foreign key (empID) references Employee(empID)
);

insert into Employee values ('Vinay'),('Mrunali');
insert into Salary values (1,1000),(2,500);

delete from Employee 
where empID in (
delete from Salary 
where empID IN (1, 2);
select empID from Salary
)

insert into Employee values ('Anisha')

delete from Employee 
where empID = 3  
and not exists (
    select 1
	from Salary
	where Salary.empID = Employee.empID
);

select * from Employee
select * from Salary


declare @empID int = 3;
begin transaction;

delete from Salary 
where empID =@empID;

delete from Employee 
where empID  = @empID;

commit transaction;



