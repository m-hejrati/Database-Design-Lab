
CREATE TABLE student (
	namee varchar(10), 
	student_id bigint primary key,
	grade INT ,

);

INSERT INTO student(Namee, student_id, grade)
VALUES('R1' , 8831047, 12 );
INSERT INTO student(Namee, student_id, grade)
VALUES('R2' , 8831043, 10 );
INSERT INTO student(Namee, student_id, grade)
VALUES('R3' , 8831031, 15 );
INSERT INTO student(Namee, student_id, grade)
VALUES('R4' , 8831051, 16 );
INSERT INTO student(Namee, student_id, grade)
VALUES('R5' , 8831015, 11 );


declare @temp table (
	student_name varchar(10), 
	id_student bigint,
	student_grade_new INT ,
	student_grade_old INT 
);

update student
set grade = grade +2
output inserted.namee , inserted.student_id , inserted.grade , deleted.grade
into @temp
where grade<15;

select * from @temp