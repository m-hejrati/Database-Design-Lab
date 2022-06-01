CREATE TABLE Book (
    ID INT IDENTITY(1,1) PRIMARY KEY,
	Bookname varchar (30),
	authorname varchar(40),
	yearpublish int,
	QTY INT,
);

-----------------------------------------
--1

create trigger trigger1 on Book
instead of insert as 
print 'No change was done';

INSERT INTO Book(Bookname,  authorname ,yearpublish, QTY)
VALUES('aliii' , 'all',2000, 40 );

select * from Book

disable trigger trigger1 on Book;

-----------------------------------------
--2
CREATE TABLE Book_audit (
    ID INT IDENTITY(1,1) PRIMARY KEY,
	Bookname varchar (30),
	authorname varchar(40),
	yearpublish int,
	QTY INT,
	Ins_or_del INT,
	);

create trigger triggerr22 on Book
AFTER insert , delete
AS
BEGIN
    DECLARE @insordel INT
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
	BEGIN
	SET @insordel = 0
	INSERT INTO Book_audit
    select deleted.Bookname , deleted.authorname ,deleted.yearpublish,deleted.QTY ,@insordel from deleted 
	END
	IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
	BEGIN
	SET @insordel = 1
	INSERT INTO Book_audit
	select inserted.Bookname , inserted.authorname ,inserted.yearpublish,inserted.QTY, @insordel from inserted 
	END     
END



INSERT INTO Book(Bookname,  authorname ,yearpublish, QTY)
VALUES('aliii' , 'all',2000, 40 );

DELETE FROM Book WHERE Bookname = 'aliii';

select* from Book_audit;
disable trigger triggerr22 on Book;
enable trigger triggerr22 on Book;


--------------------
--3-

CREATE TRIGGER trigger3 ON Book
FOR UPDATE
AS
BEGIN
  IF UPDATE(Bookname)
  BEGIN
    ROLLBACK
    RAISERROR('Changes column name not allowed', 16, 1);
  END
END


UPDATE Book
SET Bookname = 'Ali Agha'
WHERE ID = 1;


--INSERT INTO Book(Bookname,  authorname ,yearpublish, QTY)
--VALUES('book1', 'ali',2000 , 40);
--select * from Book;

disable trigger trigger3 on Book;


----------------
--4
CREATE VIEW view1
AS SELECT Bookname ,authorname,yearpublish, QTY
FROM Book;
----------------
CREATE TRIGGER trigger4 on view1
INSTEAD OF INSERT 
AS
BEGIN 
	DECLARE @QTY2 INT
	select @QTY2 = inserted.QTY from inserted
	If  @QTY2  < 1000 
	BEGIN
		INSERT INTO Book(Bookname,  authorname , yearpublish, QTY)
		SELECT Bookname,  authorname , yearpublish, 1000
		FROM INSERTED
		print('Change QTY to 1000')
	END
	ELSE
	BEGIN
		INSERT INTO Book(Bookname,  authorname , yearpublish, QTY)
		SELECT Bookname,  authorname , yearpublish, QTY
		FROM INSERTED
	END
END
----------------
INSERT INTO view1(Bookname,  authorname , yearpublish, QTY)
VALUES('TEST' , 'MAHDI', 2022, 200);

select * from book;

disable trigger trigger4Example on Book;



---------------------------
--5

CREATE TRIGGER table_del   
ON DATABASE   
FOR DROP_TABLE  
AS   
   PRINT 'It is not possible to delete table'   
   ROLLBACK;


drop table book;
disable trigger table_del on DATABASE;
