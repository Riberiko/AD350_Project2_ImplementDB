-- Team Stone AD350 Project 2 Implement DB

CREATE DATABASE ACME;
USE ACME;

CREATE TABLE User (
	userID INT UNSIGNED AUTO_INCREMENT,
	email VARCHAR(320) NOT NULL UNIQUE,
	password VARCHAR(50) NOT NULL,
	firstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	PRIMARY KEY (userID)
);

CREATE TABLE Product (
	productID INT UNSIGNED AUTO_INCREMENT,
	productName VARCHAR(50) NOT NULL UNIQUE,
	currentMSRP DECIMAL(6,2) NOT NULL,
	costToProduce DECIMAL(6,2) NOT NULL,
	releaseDate DATE NOT NULL,
	description VARCHAR(300) NOT NULL UNIQUE,
	PRIMARY KEY (productID)
);

CREATE TABLE Review (
	reviewID INT UNSIGNED AUTO_INCREMENT NOT NULL,
	productID INT UNSIGNED NOT NULL,
	userID INT UNSIGNED NOT NULL,
	score SMALLINT UNSIGNED NOT NULL, CHECK (score BETWEEN 0 AND 5),
	reviewDate DATE NOT NULL,
	PRIMARY KEY (reviewID),
	FOREIGN KEY (userID) REFERENCES User(userID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (productID) REFERENCES Product(productID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

CREATE TABLE Inventory (
	productID INT UNSIGNED NOT NULL,
	quantity SMALLINT UNSIGNED NOT NULL,
	updateDate DATE NOT NULL,
	PRIMARY KEY (productID),
	FOREIGN KEY (productID) REFERENCES Product(productID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE UserCreditCard (
	paymentID INT UNSIGNED AUTO_INCREMENT,
	userID INT UNSIGNED NOT NULL,
	cardNumber CHAR(16) NOT NULL,
	expMonth CHAR(2) NOT NULL,
	expYear CHAR(4) NOT NULL,
	PRIMARY KEY (paymentID),
	FOREIGN KEY (userID) REFERENCES User(userID) 
		ON DELETE RESTRICT
		ON UPDATE CASCADE 
);

CREATE TABLE UserAddress (
    addressID INT UNSIGNED AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    street VARCHAR(320) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state CHAR(2) NOT NULL,
    zip CHAR(5) NOT NULL,
    phone CHAR(10) NOT NULL,
    PRIMARY KEY (addressID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
	ON DELETE RESTRICT
        ON UPDATE CASCADE 
);

CREATE TABLE Transaction (
    transactionID INT UNSIGNED AUTO_INCREMENT,
    userID INT UNSIGNED NOT NULL,
    totalCost DECIMAL(6,2) NOT NULL,
    transactionDate DATE NOT NULL,
    addressID INT UNSIGNED NOT NULL,
    paymentID INT UNSIGNED NOT NULL,
    PRIMARY KEY (transactionID),
    FOREIGN KEY (userID) REFERENCES User(UserID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (addressID) REFERENCES UserAddress(addressID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (paymentID) REFERENCES UserCreditCard(paymentID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE TransactionLineItem (
	transactionID INT UNSIGNED NOT NULL,
	productID INT UNSIGNED NOT NULL,
	quantity SMALLINT UNSIGNED NOT NULL,
	unitPrice DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (transactionID, productID),
	FOREIGN KEY (transactionID) REFERENCES Transaction(transactionID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (productID) REFERENCES Product(productID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

CREATE TABLE LineItemPrice (
	transactionID INT UNSIGNED NOT NULL,
	productID INT UNSIGNED NOT NULL,
	price DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (transactionID, productID),
	FOREIGN KEY (transactionID) REFERENCES TransactionLineItem(transactionID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (productID) REFERENCES TransactionLineItem(productID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

INSERT INTO User (email, password, firstName, lastName)
	VALUES ('bbunny@acme.com', 'c@RR0ts', 'Bugs', 'Bunny'),
		   ('dduck@acme.com', 'F013gras', 'Daffy', 'Duck'),
		   ('ppig@acme.com', 'b@C0N', 'Porky', 'Pig'),
		   ('efudd@acme.com', 'F0Lks', 'Elmer', 'Fudd'),
		   ('ysam@acme.com', 'C0wb0y', 'Yosemite', 'Sam'),
		   ('fleghorn@acme.com', 'c00p', 'Foghorn', 'Leghorn'),
		   ('wcoyote@acme.com', 'Ro@dRuN', 'Wile', 'Coyote'),
		   ('lbunny@acme.com', 'spAC3j@m', 'Lola', 'Bunny'),
		   ('petpig@acme.com', 'p0Rky', 'Petunia', 'Pig'),
		   ('tbird@acme.com', 'Gr@nnY', 'Tweety', 'Bird');

INSERT INTO Product (productName, currentMSRP, costToProduce, releaseDate, description)
	VALUES ('Soap', '3.50', '1.00', '2022-01-02', 'For Cleaning'),
		   ('Chopsticks', '5.00', '2.00', '2022-01-30', 'For Eating'),
		   ('Boots', '30.00', '16.50', '2022-02-01', 'For Walking'),
		   ('TV', '120.00', '60.00', '2022-02-11', 'For Watching'),
		   ('Pot', '15.00', '7.00', '2022-02-13', 'For Cooking'),
		   ('Razor', '4.50', '2.00', '2022-03-05', 'For Shaving'),
           ('Chair', '35.00', '15.00', '2022-03-24', 'For Sitting'),
		   ('Hat', '25.00', '12.00', '2022-04-19', 'For Wearing'),
		   ('Pen', '2.00', '0.50', '2022-05-10', 'For Writing'),
		   ('Bone', '3.00', '1.00', '2022-06-17', 'For Dogs');

INSERT INTO Review (productID, userID, score, reviewDate)
	VALUES ('1', '1', '4', '2023-03-10'),
		   ('6', '1', '5', '2023-03-10'),
           ('3', '2', '3', '2023-03-11'),
           ('8', '2', '3', '2023-03-22'),
           ('4', '1', '4', '2023-04-20'),
           ('9', '3', '5', '2023-04-21'),
           ('7', '6', '5', '2023-04-26'),
           ('1', '8', '4', '2023-05-01'),
           ('10', '8', '5', '2023-05-01'),
           ('3', '8', '4', '2023-05-10');

INSERT INTO Inventory (productID, quantity, updateDate)
	VALUES ('1', '97', '2023-04-20'),
		   ('2', '46', '2023-04-05'),
           ('3', '28', '2023-04-28'),
           ('4', '19', '2023-04-05'),
           ('5', '29', '2023-05-01'),
           ('6', '99', '2023-03-01'),
           ('7', '29', '2023-04-18'),
           ('8', '37', '2023-05-01'),
           ('9', '142', '2023-05-12'),
           ('10', '175', '2023-04-20');

INSERT INTO UserCreditCard (userID, cardNumber, expMonth, expYEAR)
	VALUES ('1', '5430981239871235', '02', '2027'),
           ('2', '6759037851239832', '02', '2025'),
           ('3', '1209482740384995', '08', '2025'),
           ('4', '9840384572259354', '07', '2026'),
           ('5', '6890478366452210', '12', '2027'),
           ('1', '5893772644920485', '03', '2024'),
           ('6', '1092837726166378', '01', '2024'),
           ('7', '5788002377299947', '11', '2026'),
           ('8', '7593476293005837', '09', '2025'),
           ('7', '3723847566290028', '02', '2024');

INSERT INTO UserAddress (userID, street, city, state, zip, phone)
	VALUES ('1', '141 Main St', 'Seattle', 'WA', '98136', '2067895432'),
		   ('2', '305 Pine St', 'Seattle', 'WA', '98122', '2066348620'),
           ('3', '299 Barton St', 'Seattle', 'WA', '98124', '2068745632'),
           ('4', '222 Pike St', 'Seattle', 'WA', '98130', '2068745325'),
           ('5', '122 Main St', 'Seattle', 'WA', '98136', '2062950946'),
           ('1', '304 Union St', 'Seattle', 'WA', '98128', '2067895432'),
           ('6', '307 Pine St', 'Seattle', 'WA', '98122', '2060293400'),
           ('7', '102 Cherry St', 'Seattle', 'WA', '98132', '2061174933'),
           ('8', '500 Henderson St', 'Seattle', 'WA', '98129', '2064858863'),
           ('7', '284 Pike St', 'Seattle', 'WA', '98130', '2061174933');

INSERT INTO Transaction (userID, totalCost, transactionDate, addressID, paymentID)
	VALUES ('1', '11.50', '2023-03-01', '1', '1'),
		   ('2', '80.00', '2023-03-02', '2', '2'),
           ('1', '120.00', '2023-04-05', '6', '6'),
           ('5', '35.00', '2023-04-05', '5', '5'),
           ('3', '10.00', '2023-04-08', '3', '3'),
           ('6', '35.00', '2023-04-18', '7', '7'),
           ('8', '63.50', '2023-04-20', '9', '9'),
           ('8', '30.00', '2023-04-28', '9', '9'),
           ('7', '40.00', '2023-05-01', '8', '8'),
           ('7', '6.00', '2023-05-12', '10', '10');

INSERT INTO TransactionLineItem (transactionID, productID, quantity, unitPrice)
	VALUES ('1', '1', '2', '3.50'),
		   ('1', '6', '1', '4.50'),
           ('2', '3', '1', '30.00'),
           ('2', '8', '2', '25.00'),
           ('3', '4', '1', '120.00'),
           ('4', '2', '4', '5.00'),
           ('4', '10', '5', '3.00'),
           ('5', '9', '5', '2.00'),
           ('6', '7', '1', '35.00'),
           ('7', '1', '1', '3.50'),
           ('7', '10', '20', '3.00'),
           ('8', '3', '1', '30.00'),
           ('9', '5', '1', '15.00'),
           ('9', '8', '1', '25.00'),
           ('10', '9', '3', '2.00');

INSERT INTO LineItemPrice (transactionID, productID, price)
	VALUES ('1', '1', '7.00'),
           ('1', '6', '4.50'),
           ('2', '3', '30.00'),
           ('2', '8', '50.00'),
           ('3', '4', '120.00'),
           ('4', '2', '20.00'),
           ('4', '10', '15.00'),
           ('5', '9', '10.00'),
           ('6', '7', '35.00'),
           ('7', '1', '3.50'),
           ('7', '10', '60.00'),
           ('8', '3', '30.00'),
           ('9', '5', '15.00'),
           ('9', '8', '25.00'),
           ('10', '9', '6.00');
