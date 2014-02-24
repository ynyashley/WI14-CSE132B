CREATE TABLE "Probation" (
probation_id SERIAL PRIMARY KEY,
reason varchar(255) NOT NULL
);

CREATE TABLE "College" (
college_id SERIAL PRIMARY KEY,
name varchar(255) NOT NULL
);

CREATE TABLE "Residency" (
residency_id SERIAL PRIMARY KEY,
type varchar(255) NOT NULL
);

CREATE TABLE "Graduate_Program" (
gp_id SERIAL PRIMARY KEY,
program varchar(255) NOT NULL
);

CREATE TABLE "Candidacy" (
candidacy_id SERIAL PRIMARY KEY,
candidacy varchar(255) NOT NULL
);

CREATE TABLE "Grade_Option" (
go_id SERIAL PRIMARY KEY,
option varchar(255) NOT NULL
);

CREATE TABLE "Waitlist" (
waitlist_id SERIAL PRIMARY KEY
);

CREATE TABLE "Faculty" (
faculty_id SERIAL PRIMARY KEY,
department_id int REFERENCES "Department"(department_id),
name varchar(255) NOT NULL,
title varchar(255) NOT NULL
);

CREATE TABLE "Club" (
club_id SERIAL PRIMARY KEY,
name varchar(255) NOT NULL,
type varchar(255) NOT NULL,
year_of_establishment int NOT NULL
);

CREATE TABLE "Grade" (
grade_id SERIAL PRIMARY KEY,
grade varchar(1) NOT NULL
);

CREATE TABLE "Department" (
department_id SERIAL PRIMARY KEY,
name varchar(255) NOT NULL
);

CREATE TABLE "Concentration" (
concentration_id SERIAL PRIMARY KEY,
name varchar(255) NOT NULL
);

CREATE TABLE "Degree" (
degree_id SERIAL PRIMARY KEY,
type varchar(255) NOT NULL,
concentration_id int REFERENCES "Concentration"(concentration_id)
);

CREATE TABLE "Required_Unit" (
ru_id SERIAL PRIMARY KEY,
type varchar(255) NOT NULL,
unit int NOT NULL
);

CREATE TABLE "Degree_RU" (
dr_id SERIAL PRIMARY KEY,
degree_id int REFERENCES "Degree"(degree_id) NOT NULL,
ru_id int REFERENCES "Required_Unit"(ru_id) NOT NULL
);

CREATE TABLE "Course" (
--course_id is equivalent to course number (e.g. CSE 132A)
course_id varchar(255) PRIMARY KEY,
go_id int REFERENCES "Grade_Option"(go_id) NOT NULL,
max_unit int NOT NULL,
min_unit int NOT NULL,
lab_work boolean NOT NULL
);

CREATE TABLE "Department_Course" (
dc_id SERIAL PRIMARY KEY,
department_id int REFERENCES "Department"(department_id) NOT NULL,
course_id varchar(255) REFERENCES "Course"(course_id) NOT NULL
);

CREATE TABLE "Concentration_Course" (
cc_id SERIAL PRIMARY KEY,
concentration_id int REFERENCES "Concentration"(concentration_id) NOT NULL,
course_id varchar(255) REFERENCES "Course"(course_id) NOT NULL
);

CREATE TABLE "Thesis_Committee" (
tc_id SERIAL PRIMARY KEY
);

CREATE TABLE "Tc_Faculty" (
tf_id SERIAL PRIMARY KEY,
tc_id int REFERENCES "Thesis_Committee"(tc_id) NOT NULL,
faculty_id int REFERENCES "Faculty"(faculty_id) NOT NULL
);

CREATE TABLE "Meeting" (
meeting_id SERIAL PRIMARY KEY,
mandatory_discussion boolean NOT NULL,
date date NOT NULL,
time time NOT NULL,
weekly boolean NOT NULL,
type varchar(255) NOT NULL
);

CREATE TABLE "Section" (
section_id SERIAL PRIMARY KEY,
faculty_id int REFERENCES "Faculty"(faculty_id) NOT NULL,
waitlist_id int REFERENCES "Waitlist"(waitlist_id),
enrollment_limit int NOT NULL
);

CREATE TABLE "Section_Meeting" (
sm_id SERIAL PRIMARY KEY,
section_id int REFERENCES "Section"(section_id) NOT NULL,
meeting_id int REFERENCES "Meeting"(meeting_id) NOT NULL
);

CREATE TABLE "Class" (
class_id SERIAL PRIMARY KEY,
title varchar(255) NOT NULL,
year int NOT NULL,
quarter varchar(255) NOT NULL
);

CREATE TABLE "Class_Section" (
cs_id SERIAL PRIMARY KEY,
class_id int REFERENCES "Class"(class_id) NOT NULL,
section_id int REFERENCES "Section"(section_id) NOT NULL
);

CREATE TABLE "Course_Prereq" (
cr_id SERIAL PRIMARY KEY,
course_id varchar(255) REFERENCES "Course"(course_id) NOT NULL,
prereq_id varchar(255) REFERENCES "Course"(course_id) NOT NULL
);

CREATE TABLE "Course_Class" (
cc_id SERIAL PRIMARY KEY,
course_id varchar(255) REFERENCES "Course"(course_id) NOT NULL,
class_id int REFERENCES "Class"(class_id) NOT NULL
);

CREATE TABLE "Student" (
student_id varchar(255) PRIMARY KEY,
residency_id int REFERENCES "Residency"(residency_id) NOT NULL,
first_name varchar(255) NOT NULL,
middle_name varchar(255) NOT NULL,
last_name varchar(255) NOT NULL,
social_security varchar(255) NOT NULL,
start_date date NOT NULL,
end_date date NOT NULL,
enrollment_status boolean NOT NULL
);

CREATE TABLE "Undergraduate" (
undergrad_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
college_id int REFERENCES "College"(college_id) NOT NULL,
major varchar(255) NOT NULL,
minor varchar(255)
);

CREATE TABLE "Graduate" (
graduate_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
gp_id int REFERENCES "Graduate_Program"(gp_id) NOT NULL,
department_id int REFERENCES "Department"(department_id) NOT NULL
);

CREATE TABLE "PhD" (
phd_id SERIAL PRIMARY KEY,
graduate_id int REFERENCES "Graduate"(graduate_id) NOT NULL,
candidacy_id int REFERENCES "Candidacy"(candidacy_id) NOT NULL,
tc_id int REFERENCES "Thesis_Committee"(tc_id) NOT NULL,
faculty_id int REFERENCES "Faculty"(faculty_id) NOT NULL
);

CREATE TABLE "Student_Probation" (
sp_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
probation_id int REFERENCES "Probation"(probation_id) NOT NULL
);

CREATE TABLE "Student_Club" (
sc_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
club_id int REFERENCES "Club"(club_id) NOT NULL
);

CREATE TABLE "Student_Degree" (
sd_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
degree_id int REFERENCES "Degree"(degree_id) NOT NULL
);

CREATE TABLE "Student_Section" (
ss_id SERIAL PRIMARY KEY,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL,
section_id int REFERENCES "Section"(section_id) NOT NULL,
grade_id int REFERENCES "Grade"(grade_id),
unit int NOT NULL
);

CREATE TABLE "Waitlist_Student" (
ws_id SERIAL PRIMARY KEY,
waitlist_id int REFERENCES "Waitlist"(waitlist_id) NOT NULL,
student_id varchar(255) REFERENCES "Student"(student_id) NOT NULL
);

--Insert default values
INSERT INTO "Residency"(type)
VALUES ('California Resident'), ('Foreign Student'), ('Non-CA US Student');

INSERT INTO "Grade"(grade)
VALUES ('A'), ('B'), ('C'), ('D'), ('F'), ('S'), ('U');

INSERT INTO "Grade_Option"(option)
VALUES ('Letter Grade Only'), ('Letter Grade or S/U'), ('S/U only');

INSERT INTO "College"(name)
VALUES ('Revelle College'), ('John Muir College'), ('Thurgood Marshall College'), ('Eleanor Roosevelt College'), ('Earl Warren College'), ('Sixth College');

INSERT INTO "Candidacy"(candidacy)
VALUES ('PhD Candidate'), ('PhD Pre-candidate');

