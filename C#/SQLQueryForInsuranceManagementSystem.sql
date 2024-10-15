create database InsuranceManagementSystem;

-- Users Table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

-- Policies Table
CREATE TABLE Policies (
    PolicyId INT IDENTITY(1,1) PRIMARY KEY,
    PolicyName VARCHAR(100) NOT NULL,
    Premium DECIMAL(10, 2) NOT NULL
);

-- Clients Table
CREATE TABLE Clients (
    ClientId INT IDENTITY(1,1) PRIMARY KEY,
    ClientName VARCHAR(50) NOT NULL,
    ContactInfo VARCHAR(100) NOT NULL,
    PolicyId INT,
    FOREIGN KEY (PolicyId) REFERENCES Policies(PolicyId) 
        ON DELETE CASCADE
);

CREATE TABLE Claims (
    ClaimId INT IDENTITY(1,1) PRIMARY KEY,
    ClaimNumber VARCHAR(50) NOT NULL,
    DateFiled DATE NOT NULL,
    ClaimAmount DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    PolicyId INT,
    ClientId INT,
    FOREIGN KEY (PolicyId) REFERENCES Policies(PolicyId)
        ON DELETE NO ACTION,   -- Replace with NO ACTION to prevent cycles
    FOREIGN KEY (ClientId) REFERENCES Clients(ClientId)
        ON DELETE CASCADE      -- Keep cascade here if needed
);

-- Payments Table
CREATE TABLE Payments (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    ClientId INT,
    FOREIGN KEY (ClientId) REFERENCES Clients(ClientId)
        ON DELETE CASCADE
);


--inserting data

INSERT INTO Users (Username, Password, Role) VALUES
('vinay_solanki', '123', 'admin'),
('nimisha_gahage', '123', 'user'),
('mrunali_123', '123', 'user'),
('anisha_123', '123', 'user'),
('vijay_patel', '123', 'user');

INSERT INTO Policies (PolicyName, Premium) VALUES
('Health Insurance', 5000.00),
('Vehicle Insurance', 7000.00),
('Life Insurance', 10000.00),
('Home Insurance', 6000.00),
('Travel Insurance', 3000.00);

INSERT INTO Clients (ClientName, ContactInfo, PolicyId) VALUES
('Vinay Solanki', 'vinay@gamil.com', 1),
('Nimisha Ghadage', 'nimisha@gmail.com', 2),
('Mrunali Rajkule', 'mrunali@gmail.com', 3),
('Anisha Kuber', 'anisha@gmail.com', 1),
('Vijay patel', 'vijay@gmail.com', 4);

INSERT INTO Claims (ClaimNumber, DateFiled, ClaimAmount, Status, PolicyId, ClientId) VALUES
('CLAIM001', '2024-01-10', 15000.00, 'Approved', 1, 1),
('CLAIM002', '2024-01-12', 20000.00, 'Pending', 2, 2),
('CLAIM003', '2024-02-05', 25000.00, 'Rejected', 3, 3),
('CLAIM004', '2024-02-10', 12000.00, 'Approved', 1, 4),
('CLAIM005', '2024-03-01', 18000.00, 'Pending', 4, 5);

INSERT INTO Payments (PaymentDate, PaymentAmount, ClientId) VALUES
('2024-01-15', 5000.00, 1),
('2024-01-20', 7000.00, 2),
('2024-02-10', 10000.00, 3),
('2024-02-20', 6000.00, 4),
('2024-03-05', 3000.00, 5);

select * from Claims;
select * from Clients;
select * from Payments;
select * from Policies;
select * from Users;



