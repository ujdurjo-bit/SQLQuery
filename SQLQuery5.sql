UPDATE PolaznikProba SET Ime = 'Markić' WHERE IDPolaznikProba = 1

SELECT * FROM PolaznikProba

USE master;
GO

-- 1. Set model to single user to kick out background processes
ALTER DATABASE [model] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Change the collation
ALTER DATABASE [model] COLLATE Croatian_CI_AS;
GO

-- 3. Set back to multi user
ALTER DATABASE [model] SET MULTI_USER;
GO