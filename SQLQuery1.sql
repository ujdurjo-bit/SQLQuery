USE master;
GO

-- 1. Set model to single user to kick out background processes
ALTER DATABASE [AdventureWorksOBP] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Change the collation
ALTER DATABASE [AdventureWorksOBP] COLLATE Croatian_CI_AS;
GO

-- 3. Set back to multi user
ALTER DATABASE [AdventureWorksOBP] SET MULTI_USER;
GO