CREATE DATABASE IF NOT EXISTS database_week1 ; USE database_week1;

CREATE TABLE STUDENT (
    student_id INT,
    student_name VARCHAR(20),
    student_address VARCHAR(64),
    PRIMARY KEY (student_id)
);

CREATE TABLE SEAT (
    seat_no INT,
    seat_position VARCHAR(20),
    student_id INT,
    PRIMARY KEY (seat_no),
    FOREIGN KEY (student_id)
        REFERENCES STUDENT (student_id)
);

CREATE TABLE INSTRUCTOR (
    instructor_no INT,
    instructor_name VARCHAR(20),
    instructor_faculty VARCHAR(20),
    PRIMARY KEY (instructor_no)
);

CREATE TABLE COURSE (
    course_name VARCHAR(20),
    course_number INT,
    instructor_no INT,
    PRIMARY KEY (course_name , course_number),
    FOREIGN KEY (instructor_no)
        REFERENCES INSTRUCTOR (instructor_no)
);

CREATE TABLE TAKES_STUDENT_COURSE (
    student_id INT,
    course_name VARCHAR(20),
    course_number INT,
    PRIMARY KEY (student_id , course_name , course_number),
    FOREIGN KEY (student_id)
        REFERENCES STUDENT (student_id),
    FOREIGN KEY (course_name, course_number)
        REFERENCES COURSE (course_name, course_number)
);

CREATE TABLE PROFESSOR (
    professor_id INT,
    professor_name VARCHAR(20),
    professor_faculty VARCHAR(20),
    PRIMARY KEY (professor_id)
);

CREATE TABLE SECTION (
    section_number INT,
    professor_id INT,
    PRIMARY KEY (section_number),
    FOREIGN KEY (professor_id)
        REFERENCES PROFESSOR (professor_id)
);

CREATE TABLE CLASS (
    course_name VARCHAR(20),
    section_number INT,
    num_registered INT,
    class_date_time DATETIME,
    PRIMARY KEY (course_name , section_number),
    FOREIGN KEY (course_name)
        REFERENCES COURSE (course_name),
    FOREIGN KEY (section_number)
        REFERENCES SECTION (section_number)
);

