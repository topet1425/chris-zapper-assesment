USE zapperdb
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customers]') AND type = N'U')
BEGIN
	CREATE TABLE Customers (
		Id INT PRIMARY KEY IDENTITY(1,1),
		FirstName VARCHAR(50) NOT NULL,
		LastName VARCHAR(50) NOT NULL,
		Email VARCHAR(100) UNIQUE NOT NULL,
		PhoneNumber VARCHAR(20),
		CreatedAt DATETIME DEFAULT GETDATE()
	)
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Merchants]') AND type = N'U')
BEGIN
	CREATE TABLE Merchants (
		Id INT PRIMARY KEY IDENTITY(1,1),
		MerchantName VARCHAR(100) NOT NULL,
		ContactEmail VARCHAR(100) UNIQUE NOT NULL,
		PhoneNumber VARCHAR(20),
		Address VARCHAR(255),
		CreatedAt DATETIME DEFAULT GETDATE()
	);
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type = N'U')
BEGIN
	CREATE TABLE Transactions (
		Id INT PRIMARY KEY IDENTITY(1,1),
		CustomerId INT NOT NULL,
		MerchantId INT NOT NULL,
		Amount DECIMAL(18, 2) NOT NULL,
		CreatedAt DATETIME DEFAULT GETDATE(),
		PaymentMethod VARCHAR(50) NOT NULL,
		Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
		FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
		FOREIGN KEY (MerchantId) REFERENCES Merchants(Id)
	);
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionItems]') AND type = N'U')
BEGIN
	CREATE TABLE TransactionItems (
		Id INT PRIMARY KEY IDENTITY(1,1),
		TransactionId INT NOT NULL,
		ItemDescription VARCHAR(255) NOT NULL,
		Quantity INT NOT NULL,
		UnitPrice DECIMAL(18, 2) NOT NULL,
		FOREIGN KEY (TransactionId) REFERENCES Transactions(Id)
	);
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Payments]') AND type = N'U')
BEGIN
	CREATE TABLE Payments (
		Id INT PRIMARY KEY IDENTITY(1,1),
		TransactionId INT NOT NULL,
		PaymentAmount DECIMAL(18, 2) NOT NULL,
		PaymentDate DATETIME DEFAULT GETDATE(),
		PaymentStatus VARCHAR(20) NOT NULL CHECK (PaymentStatus IN ('Paid', 'Unpaid', 'Refunded')),
		ApprovalCode VARCHAR(10) NULL
		FOREIGN KEY (TransactionId) REFERENCES Transactions(Id)
	);
END