create database PetPals;
use PetPals;

create table Pets (
PetID int primary key identity(1,1),
Name varchar(100) not null,
Age int check (age >=0) not null,
Breed varchar(100),
Type varchar(50) check(type in('Dog','Cat','Bird','Reptile','Other')),
AvailableForAdoption bit not null
);

create table Shelters(
ShelterID int primary key identity(1,1),
Name varchar(100) not null,
Location varchar(255) not null
);

create table Donations (
DonationID int primary key identity(1,1),
DonorName varchar(100) not null,
DonationType varchar(50) check (DonationType in('Cash','Item')),
DonationAmount decimal(10,2) check (DonationAmount > 0),
DonationItem varchar(100),
DonationDate datetime not null
);

create table AdoptionEvents (
EventID int primary key identity(1,1),
EventName varchar(100) not null,
EventDate datetime not null,
Location varchar(255) not null
);

create table Participants (
ParticipantID int primary key identity(1,1),
participantName varchar(100) not null,
ParticipantType varchar(50) check (ParticipantType in ('Shelter','Adopter')),
EventID int,
foreign key (EventID) references AdoptionEvents (EventID)
);

--inserting data
insert into Shelters (Name, Location)
values 
('Paws Home', 'Mumbai'),
('Happy Tails', 'Chennai'),
('Safe Haven', 'Bangalore'),
('Pet Paradise', 'Delhi'),
('Rescue Ranch', 'Hyderabad'),
('Pet Shelter', 'Pune'),
('Animal Aid', 'Kolkata'),
('Stray Care', 'Ahmedabad'),
('Care4Pets', 'Jaipur'),
('Pets R Us', 'Lucknow');

insert into Pets (Name, Age, Breed, Type, AvailableForAdoption)
values 
('Bruno', 2, 'Labrador', 'Dog', 1),
('Whiskers', 3, 'Persian Cat', 'Cat', 1),
('Coco', 1, 'Golden Retriever', 'Dog', 1),
('Milo', 5, 'Beagle', 'Dog', 0),
('Simba', 4, 'Indian Pariah', 'Dog', 1),
('Luna', 6, 'Siamese Cat', 'Cat', 1),
('Rocky', 2, 'German Shepherd', 'Dog', 0),
('Kiwi', 1, 'Parrot', 'Bird', 1),
('Fluffy', 5, 'Angora Rabbit', 'Other', 1),
('Rex', 7, 'Doberman', 'Dog', 1);

insert into Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate)
values 
('Amit Sharma', 'Cash', 5000, NULL, '2023-08-12'),
('Sneha Rao', 'Item', NULL, 'Dog Food', '2023-07-22'),
('Ravi Patel', 'Cash', 3000, NULL, '2023-06-15'),
('Neha Singh', 'Cash', 4500, NULL, '2023-08-18'),
('Raj Malhotra', 'Item', NULL, 'Cat Food', '2023-09-01'),
('Vikram Joshi', 'Cash', 6000, NULL, '2023-09-05'),
('Pooja Desai', 'Cash', 2500, NULL, '2023-07-29'),
('Anjali Verma', 'Item', NULL, 'Dog Bed', '2023-05-21'),
('Kiran Rao', 'Cash', 7000, NULL, '2023-09-20'),
('Rohit Kumar', 'Item', NULL, 'Bird Cage', '2023-06-10');

insert into AdoptionEvents (EventName, EventDate, Location)
values 
('Mega Adoption Drive', '2023-10-10', 'Mumbai'),
('Pet Fair 2023', '2023-09-15', 'Chennai'),
('Adoptathon 2023', '2023-08-20', 'Bangalore'),
('Pet Carnival', '2023-07-12', 'Delhi'),
('Stray Care Fest', '2023-09-25', 'Hyderabad'),
('Rescue Expo', '2023-06-14', 'Pune'),
('Pets Fest', '2023-05-30', 'Kolkata'),
('Furry Friends Fest', '2023-08-10', 'Ahmedabad'),
('Happy Tails Day', '2023-09-02', 'Jaipur'),
('Paw Day Out', '2023-07-18', 'Lucknow');

insert into Participants (ParticipantName, ParticipantType, EventID)
values 
('Paws Home', 'Shelter', 1),
('Happy Tails', 'Shelter', 2),
('Safe Haven', 'Shelter', 3),
('Pet Paradise', 'Shelter', 4),
('Rescue Ranch', 'Shelter', 5),
('Animal Aid', 'Shelter', 6),
('Pooja Desai', 'Adopter', 1),
('Ravi Patel', 'Adopter', 2),
('Neha Singh', 'Adopter', 3),
('Anjali Verma', 'Adopter', 4);

--5. Write an SQL query that retrieves a list of available pets (those marked as available for adoption)
select Name, Age, Breed, Type
from Pets where AvailableForAdoption = 1;

/*6. Write an SQL query that retrieves the names of participants (shelters and adopters) registered
for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query
joins the necessary tables to retrieve the participant names and types.
*/
declare @EventID int = 2;

select p.ParticipantName,p.ParticipantType 
from Participants p
join AdoptionEvents a 
on p.EventID = a.EventID 
where p.EventID = @EventID;

/*7. Create a stored procedure in SQL that allows a shelter to update its information (name and
location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information.
Ensure that the procedure performs the update and handles potential errors, such as an invalid
shelter ID. */
create procedure UpdateShelterInfo
	@ShelterID int,
	@NewName varchar(100),
	@NewLocation varchar(255)
as
begin
	if exists (select 1 from Shelters where ShelterID = @ShelterID)
		begin
			update Shelters 
			set Name = @NewName, Location = @NewLocation 
			where ShelterID = @ShelterID;
		end
	else
		begin
		raiserror('Shelter not found',16,1);
		end
end;
select * from Shelters where ShelterID = 1;
exec UpdateShelterInfo @ShelterID = 122,@NewName = 'Vinay Pet Shop',@NewLocation = 'Pune';
select * from Shelters where ShelterID = 1;

/*8. Write an SQL query that calculates and retrieves the total donation amount for each shelter (by
shelter name) from the "Donations" table. The result should include the shelter name and the
total donation amount. Ensure that the query handles cases where a shelter has received no
donations.*/

/*as there is not foreign key in Donations table for shelterID as there is no relation between 
donar and which shelter has donate the amount therefore i am updating the 
table and adding foreign key */

alter table Donations
add ShelterID int , foreign key(ShelterID) references Shelters(ShelterID);

update Donations set ShelterID = 1 where DonationID = 1;
update Donations set ShelterID = 2 where DonationID = 2;
update Donations set ShelterID = 3 where DonationID = 3;
update Donations set ShelterID = 2 where DonationID = 4;
update Donations set ShelterID = 4 where DonationID = 5;
update Donations set ShelterID = 5 where DonationID = 6;
update Donations set ShelterID = 2 where DonationID = 7;
update Donations set ShelterID = 1 where DonationID = 8;
update Donations set ShelterID = 9 where DonationID = 9;
update Donations set ShelterID = 10 where DonationID = 10;

select s.Name , sum(d.DonationAmount) as TotalDonations
from Donations d
join Shelters s on d.ShelterID = s.ShelterID group by s.Name;

/*9. Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an
owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result
set.*/

--as mention in above schema of the tables there were not mention about OwnerID i need to alter the table 

select * from Pets
alter table Pets add OwnerID int null;

update Pets
set OwnerID = 1 
where PetID in (4, 7); 

select Name,Age,Breed,Type
from Pets
where OwnerID is null;

/*10. Write an SQL query that retrieves the total donation amount for each month and year (e.g.,
January 2023) from the "Donations" table. The result should include the month-year and the
corresponding total donation amount. Ensure that the query handles cases where no donations
were made in a specific month-year.*/
select format(DonationDate,'MMMM yyyy') as MonthYear , sum(DonationAmount) as TotalDonations
from Donations
group by format(DonationDate,'MMMM yyyy');

/*11. Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older
than 5 years.*/

select distinct Breed 
from Pets 
where (Age between 1 and 3) or (Age > 5);

/*12. Retrieve a list of pets and their respective shelters where the pets are currently available for
adoption.*/
/*as there is no connection between pet table and shelter table we cannot retrieve the data of pet which
are available for adoption*/
alter table Pets 
add ShelterID int , foreign key (ShelterID) references Shelters(ShelterID);

select * from Pets
update Pets set ShelterID = 1 where PetID =1;
update Pets set ShelterID = 2 where PetID =2;
update Pets set ShelterID = 3 where PetID =3;
update Pets set ShelterID = 4 where PetID =5;
update Pets set ShelterID = 2 where PetID =6;
update Pets set ShelterID = 3 where PetID =8;
update Pets set ShelterID = 6 where PetID =9;
update Pets set ShelterID = 7 where PetID =10;

select p.Name as PetName, s.Name as ShelterName 
from Pets p
join Shelters s 
on p.ShelterID = s.ShelterID where p.AvailableForAdoption=1;

/*13. Find the total number of participants in events organized by shelters located in specific city.
Example: City=Chennai*/
select * from AdoptionEvents
select * from Shelters
select count(p.participantID) as TotalParticipants 
from Participants p
join AdoptionEvents a on p.EventID = a.EventID
join Shelters s on a.Location = s.Location
where s.Location ='Chennai';

--14. Retrieve a list of unique breeds for pets with ages between 1 and 5 years.
select distinct Breed,Age from Pets 
where Age between 1 and 5;

--15. Find the pets that have not been adopted by selecting their information from the 'Pet' table.
select Name,Age,Breed,Type
from Pets
where OwnerID is null;

/*16. Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and
'User' tables.*/
--in a given schema of tables there is no mention about Adoption table and as per our instruction to us to skip this question

/*17. Retrieve a list of all shelters along with the count of pets currently available for adoption in each
shelter.*/
select s.Name as ShelterName,count(p.PetID) as AvailablePets
from Shelters s
left join Pets p on s.ShelterID = p.ShelterID
where p.AvailableForAdoption = 1
group by s.Name;

--18. Find pairs of pets from the same shelter that have the same breed.
select * from Pets
insert into Pets (Name,Age,Breed,Type,AvailableForAdoption,ShelterID) 
values 
('Rocky',9,'Doberman','Dog',1,7),
('Mithu',3,'Parrot','Bird',1,3);

select p1.Name as Pet1, p2.Name as Pet2,p1.Breed, s.Name as Shelter
from Pets p1
join Pets p2 on p1.ShelterID = p2.ShelterID and p1.Breed = p2.Breed and p1.PetID < p2.PetID
join Shelters s on p1.ShelterID = s.ShelterID; 

--19. List all possible combinations of shelters and adoption events.
select s.Name as ShelterName , e.EventName
from Shelters s
cross join AdoptionEvents e;

--20. Determine the shelter that has the highest number of adopted pets.
select * from Pets
select top 1 s.Name as ShelterName, COUNT(p.PetID) as TotalAvailablePets
from Pets p
join Shelters s on p.ShelterID = s.ShelterID
where p.AvailableForAdoption = 1
group by s.Name
order by TotalAvailablePets desc;


