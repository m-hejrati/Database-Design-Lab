INSERT INTO STUDENT (student_id, student_name, student_address)
VALUES (101, "Ali", "Iran");
INSERT INTO STUDENT (student_id, student_name, student_address)
VALUES (102, "Hasan", "Iran");

INSERT INTO SEAT (seat_no, seat_position, student_id)
VALUES (101, "InVar", 101);
INSERT INTO SEAT (seat_no, seat_position, student_id)
VALUES (102, "OonVar", 102);

INSERT INTO INSTRUCTOR (instructor_no, instructor_name, instructor_faculty)
VALUES (101, "Ostad1", "CE");
INSERT INTO INSTRUCTOR (instructor_no, instructor_name, instructor_faculty)
VALUES (102, "Ostad2", "EE");

INSERT INTO COURSE (course_name, course_number, instructor_no)
VALUES ("DB", 101, 101);
INSERT INTO COURSE (course_name, course_number, instructor_no)
VALUES ("AI", 102, 102);

INSERT INTO TAKES_STUDENT_COURSE (student_id, course_name, course_number)
VALUES (101, "DB", 101);
INSERT INTO TAKES_STUDENT_COURSE (student_id, course_name, course_number)
VALUES (102, "AI", 102);

INSERT INTO PROFESSOR (professor_id, professor_name, professor_faculty)
VALUES (101, "Prof1", "CE");
INSERT INTO PROFESSOR (professor_id, professor_name, professor_faculty)
VALUES (102, "Prof2", "EE");

INSERT INTO SECTION (section_number, professor_id)
VALUES (101, 101);
INSERT INTO SECTION (section_number, professor_id)
VALUES (102, 102);

INSERT INTO CLASS (course_name, section_number, num_registered, class_date_time)
VALUES ("DB", 101, 50, '2022-03-27 7:45:00');
INSERT INTO CLASS (course_name, section_number, num_registered, class_date_time)
VALUES ("AI", 102, 40, '2022-03-28 9:15:00');