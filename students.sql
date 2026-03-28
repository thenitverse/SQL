CREATE TABLE students (
id INT PRIMARY KEY,
student_name TEXT NOT NULL,
date_of_birth TEXT NOT NULL,
date_joined TEXT NOT NULL);

INSERT INTO students (id,student_name , date_of_birth , date_joined)
VALUES(1,'Aarav','2012-03-12','2023-06-01');
INSERT INTO students (id,student_name,date_of_birth,date_joined)
VALUES(2,'joy','2011-04-23','2023-05-02');
INSERT INTO students(id ,student_name,date_of_birth,date_joined)
VALUES(3,'jerry','2013-04-14','2023-04-01');

CREATE TABLE attendence (
id INT PRIMARY KEY,roll_no INT NOT NULL,attendence_date TEXT NOT NULL,status TEXT NOT NULL);
INSERT INTO attendence (id,roll_no,attendence_date,status)
VALUES(1,1,'2026-03-22','present');
INSERT INTO attendence (id,roll_no,attendence_date,status)
VALUES(2,1,'2026-03-23','present');
INSERT INTO attendence (id,roll_no,attendence_date,status)
VALUES(3,2,'2026-03-22','present');
INSERT INTO attendence(id,roll_no,attendence_date,status)
VALUES(4,2,'2026-03-23','absent');

SELECT students.id,students.student_name,students.date_of_birth,students.date_joined, COUNT(CASE WHEN attendence.status = 'present' THEN 1 END) AS total_present_days,
COUNT(CASE WHEN attendence.status = 'absent' THEN 1 END) AS total_absent_days,
(SELECT COUNT(*) FROM students) AS total_students,
(SELECT COUNT(DISTINCT roll_no)
FROM attendence WHERE status = 'present') AS student_present_in_class
FROM students 
LEFT JOIN attendence ON students.id = attendence.roll_no
GROUP BY students.id,students.student_name,students.date_of_birth,students.date_joined
ORDER BY students.id ASC ,students.student_name ASC ;