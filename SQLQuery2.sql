DBCC CHECKIDENT ('PolaznikProba', NORESEED)
INSERT INTO PolaznikProba VALUES ('Ivica', 'Kvazic', '20001205' )

DBCC CHECKIDENT ('PolaznikProba', RESEED, 7)

INSERT INTO PolaznikProba VALUES ('Petar', 'Milimetar', '19851012' )

SELECT * FROM PolaznikProba



INSERT INTO 