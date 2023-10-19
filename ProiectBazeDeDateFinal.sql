CREATE DATABASE IF NOT EXISTS college_database;
USE college_database;

CREATE TABLE IF NOT EXISTS ADDRESS(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
address VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS DEPARTAMENT(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
genre VARCHAR(50) NOT NULL,
location VARCHAR(50) NOT NULL 
   
);

CREATE TABLE IF NOT EXISTS INSTRUCTOR(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birth_date DATE,
hire_date DATE,
email varchar(100) NOT NULL,
id_departament INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_DEPARTAMENT) references DEPARTAMENT(id)
);

CREATE TABLE IF NOT EXISTS COURSE(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(50) NOT NULL,
duration TIME NOT NULL,
id_departament INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_DEPARTAMENT) references DEPARTAMENT(id),
id_instructor INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_INSTRUCTOR) references INSTRUCTOR(id)

);

CREATE TABLE IF NOT EXISTS STUDENT(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birth_date DATE,
enrolling_date DATE,
email varchar(100) NOT NULL,
id_address INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_ADDRESS) references ADDRESS(id)
);

CREATE TABLE IF NOT EXISTS STUDENT_COURSE(
id_student INT UNSIGNED NOT NULL,
FOREIGN KEY(id_STUDENT) references STUDENT(id),
id_course INT UNSIGNED NOT NULL,
FOREIGN KEY(id_COURSE) references COURSE(id)
);

CREATE TABLE IF NOT EXISTS DEPARTAMENT_HEAD(
id_departament INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_DEPARTAMENT) references DEPARTAMENT(id),
id_instructor INT UNSIGNED UNIQUE NOT NULL,
FOREIGN KEY(id_INSTRUCTOR) references INSTRUCTOR(id)
);

ALTER TABLE INSTRUCTOR drop hire_date; 
ALTER TABLE INSTRUCTOR ADD hire_date VARCHAR(100);
ALTER TABLE INSTRUCTOR MODIFY hire_date VARCHAR(100) AFTER birth_date;
ALTER TABLE DEPARTAMENT CHANGE COLUMN genre category VARCHAR(50) NOT NULL;
ALTER TABLE STUDENT MODIFY birth_date VARCHAR(100) AFTER enrolling_date;


SHOW INDEX FROM COURSE;
SHOW CREATE TABLE COURSE;

# Vreau sa renunt la atributul unique al coloanei id_instructor, intrucat un instructor poate preda mai multe cursuri
ALTER TABLE COURSE DROP FOREIGN KEY COURSE_ibfk_1;
#Din greseala am dat drop la foreign key-ul coloanei id_departament, asa ca o sa trebuiasca sa reconstruiesc atat id_departament cat si id_instructor
ALTER TABLE COURSE DROP id_departament;
ALTER TABLE COURSE DROP FOREIGN KEY COURSE_ibfk_2;
ALTER TABLE COURSE DROP id_instructor;

ALTER TABLE COURSE ADD COLUMN id_instructor INT UNSIGNED NOT NULL;
ALTER TABLE COURSE ADD CONSTRAINT FOREIGN KEY(id_INSTRUCTOR) references INSTRUCTOR(id);

ALTER TABLE COURSE ADD COLUMN id_departament INT UNSIGNED NOT NULL;
ALTER TABLE COURSE ADD CONSTRAINT FOREIGN KEY(id_DEPARTAMENT) references DEPARTAMENT(id);

ALTER TABLE INSTRUCTOR DROP FOREIGN KEY INSTRUCTOR_ibfk_1;
ALTER TABLE INSTRUCTOR DROP id_departament;

ALTER TABLE INSTRUCTOR ADD COLUMN id_departament INT UNSIGNED NOT NULL;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE INSTRUCTOR ADD CONSTRAINT FOREIGN KEY(id_DEPARTAMENT) references DEPARTAMENT(id);
SET FOREIGN_KEY_CHECKS=1;



INSERT INTO DEPARTAMENT (category,location) VALUES
('Physics','Physics and Astrophysics building'),
('Mathematics','Research building 4'),
('Astronomy','Physics and Astrophysics building'),
('Biology','Research building 1'),
('Chemistry','Research building 2'),
('History','History and Languages building '),
('Anthropology','Research building 3'),
('Architecture','Architecture building'),
('Arts','Arts Gallery'),
('Law','Law and Economics building'),
('Economics','Law and Economics building'),
('Languages','History and Languages building '),
('Marketing','Law and Economics building'),
('Psysical Education','Dickson Stadium'),
('Psychology','NeuroScience building');







INSERT INTO INSTRUCTOR (first_name, last_name,birth_date, hire_date, email, id_departament) VALUES
('Kyle','Jones','1985-09-08','2020-09-08','','1'),
('Brad','Williams','1955-08-09','2013-04-08','','2'),
('Thomas','Walsh','1987-05-09','2018-11-12','','3'),
('Lauren','Taylor','1965-04-08','2020-12-08','','4'),
('Sophie','Jones','1980-05-20','2013-04-12','','5'),
('Emily','White','1987-08-26','2010-03-02','','6'),
('Austin','Brown','1991-11-12','2006-04-03','','7'),
('Jessica','Smith','1987-02-03','2008-05-06','','8'),
('Sophie','	Evans','1991-08-12','2007-05-02','','9'),
('Lauren','Anderson','1989-09-04','2020-09-10','','10'),
('Marry','Martin','1987-09-26','2020-09-07','','11'),
('Jessica','Wang','1991-11-20','2009-04-05','','12'),
('June','Jones','1986-08-07','2010-03-05','','13'),
('Thomas','Walsh','1992-08-29','2002-04-03','','14'),
('Thomas','Davis','1979-09-08','2020-05-04','','15');

INSERT INTO INSTRUCTOR (first_name, last_name,birth_date, hire_date, email, id_departament) VALUES
('Oliver','Jones','1985-09-08','2020-09-08','','1'),
('Jack','Williams','1955-08-09','2013-04-08','','2'),
('Kyle','Walsh','1987-05-09','2018-11-12','','7'),
('James','Taylor','1965-04-08','2020-12-08','','8'),
('Damian','Jones','1980-05-20','2013-04-12','','9'),
('Thomas','White','1987-08-26','2010-03-02','','10'),
('Elizabeth','Brown','1991-11-12','2006-04-03','','4'),
('Jessica','Smith','1987-02-03','2008-05-06','','12'),
('Sophie','	Evans','1991-08-12','2007-05-02','','13'),
('Lauren','Anderson','1989-09-04','2020-09-10','','5'),
('Isabella','Martin','1987-09-26','2020-09-07','','3'),
('Michelle','Wang','1991-11-20','2009-04-05','','6'),
('Samantha','Jones','1986-08-07','2010-03-05','','14'),
('Emily','Walsh','1992-08-29','2002-04-03','','15'),
('Tracy','Davis','1979-09-08','2020-05-04','','11');

DELETE FROM INSTRUCTOR WHERE id_departament = 0; 
#din cauza stergerii fk si readaugarii dupa operatia de insert, id_departament a devenit by default 0, 
#asa ca am eliminat acele elemente


INSERT INTO ADDRESS (address, city) VALUES
('32 Bury Rd','Hampreston'),
('53 Oxford Rd','Worswell'),
('54 Preston Rd','Morland'),
('82 Ramsgate Rd','Wigtoft'),
(' 32 Helland Bridge','Upper Arley'),
('13 Caerfai Bay Road','Tedstone Delamere'),
('42 Long Street','Milden'),
('81 Ilchester Road','Mungrisdale'),
(' 79 Malcolm Rd',' Llanengan'),
('3 Holburn Lane','Healing'),
('69 Great North Road','Altens'),
('99 Caerfai Bay Road','Thainstone'),
('65 Shannon Way','Chigwell Row'),
('23 Caerfai Bay Road','Tedstone Wafre'),
('54 Caxton Place',' Bushton'),
('76 Lammas Street','Great Canney'),
('12 Crown Street','London'),
('4 Guild Street','London'),
('2 Union Terrace','London'),
('64 Thirsk Road','Blairnairn'),
('32 North Promenade',' Dorridge'),
('64 Thirsk Road','Blairnairn'),
('93 Broad Street','Lower Shelton'),
('19 Manor Close','Dingestow'),
('74 Witney Way','Knockfin');



INSERT INTO COURSE (course_name, id_departament, DURATION_IN_WEEKS, id_instructor) VALUES
('Physics theory',1,'12',36),
('Physics lab',1,'12',51 ),
('Physics applied modules',1,'8',36 ),
('Mathematics 1',2,'16',52 ),
('Mathematics in applied sciences',2,'12',37 ),
('Mathematics 2',2,'10',37 ),
('Astronomy theory',3,'12',38 ),
('Astronomy observations',3,'6',38 ),
('Astronomy history',3,'10', 61),
('Biology theory',4,'12', 39),
('Biology lab',4,'8',39 ),
('Biology in modern medicine',4,'12', 57),
('Chemistry theory',5,'8', 60),
('Applied Chemistry',5,'12',60 ),
('Biomedical Chemistry',5,'10',40 ),
('History of religions',6,'18',41 ),
('History of politics',6,'16',41 ),
('Ancient History',6,'18',62 ),
('Modern Anthropology ',7,'10', 53),
('Anthropology lab',7,'12',42 ),
('History of Anthropology',7,'5',42 ),
('Modern Architecture',8,'12',54 ),
('Principles of Architecture',8,'15',43 ),
('Ancient Architecture',8,'17',43 ),
('Modern Arts', 9,'12',44),
('History of Arts', 9,'12',44 ),
('Galerry Studies', 9,'10', 55),
('Civil Law', 10,'15', 45),
('Economic Law', 10,'16', 45),
('Criminal law', 10,'15', 56),
('Economics in modern society', 11,'7',46 ),
('History of Economics', 11,'8',65 ),
('Economics applied', 11,'6', 46),
('History of languages', 12,'10',47 ),
('Applied Linguistics', 12,'19',47 ),
('Language focus', 12,'9',58 ),
('Marketing', 13,'6', 48),
('Marketing and development', 13,'7',48 ),
('Applied Marketing', 13,'10', 59),
('PE focus', 14,'16', 49),
('PE team', 14,'16', 63),
('PE optional', 14,'16',49 ),
('Priciples of Psychology', 15,'12', 64),
('Modern Psychology', 15,'14',50 ),
('Psychology practice', 15,'14',50 );


DELETE FROM COURSE WHERE id_departament != 0;
#operatia de truncate nu mergea intrucat tabela era refrenced ca foreign key ptr alta tabela, asa ca am sters toate elementele folosind acea conditie


ALTER TABLE COURSE DROP COLUMN DURATION;

ALTER TABLE COURSE ADD DURATION_IN_WEEKS INT NOT NULL;

ALTER TABLE COURSE MODIFY id_instructor INT UNSIGNED NOT NULL AFTER DURATION_IN_WEEKS ;
ALTER TABLE COURSE MODIFY id_departament INT UNSIGNED NOT NULL AFTER course_name;

ALTER TABLE COURSE AUTO_INCREMENT = 1;
 #Am observat ca indexarea val din tabela curs pleaca de la val 91 din cauza valorilor sterse anterior.
#Am incercat sa resetez auto_increment la 1, dar se comporta la fel. Alte solutii nu am gasit. 
#Mai era optiunea de truncate si reinsert, dar cum tabela mea este referentiata ca foreign key nu puteam realiza aceasta operatie.


ALTER TABLE STUDENT DROP COLUMN enrolling_date;
INSERT INTO STUDENT(first_name, last_name, enrolling_date, birth_date,email, id_address) VALUES
('Jane','Morgan','13-08-2020','20-02-2000','','1'),
('Robert','Wilshire','14-04-2019','12-03-2001','','2'),
('Andrew','Morgan','12-03-2018','23-09-2002','','3'),
('Michael','Johnson','20-02-2020','22-11-2003','','4'),
('Michelle','McCrammer','12-03-2018','23-09-2002','','5'),
('Logan','Paul','14-04-2019','24-01-2002','','6'),
('Austin','McBrew','20-02-2000','21-03-2000','','7'),
('Lara','Anderson','12-03-2018','27-01-2002','','8'),
('Elizabeth','Peterson','14-04-2019','23-09-2002','','9'),
('Rey','Walker','20-02-2020','24-04-2000','','10'),
('John','Deer','12-03-2018','23-09-2001','','11'),
('Melissa','Anderson','14-04-2019','24-05-2004','','12'),
('Kevin','Paul','12-03-2017','22-12-2002','','13'),
('Emily','Street','13-05-2018','23-09-2002','','14'),
('Diana','Steal','14-04-2019','23-04-2001','','15'),
('Morgan','Freeman','12-03-2017','09-08-2001','','16'),
('Alice','Parker','13-05-2018','01-02-2002','','17'),
('Will','Johnson','14-04-2019','01-03-2002','','18'),
('Marry','Poppins','12-03-2017','08-01-2003','','19'),
('William','Parker','13-05-2018','12-12-2003','','20'),
('Stella','Laurens','14-04-2019','13-01-2002','','21'),
('Andrew','Mayers','12-03-2017','14-01-2001','','22'),
('Stephen','Smith','13-05-2018','12-02-2002','','23'),
('Eve','Parker','12-03-2017','13-03-2006','','24'),
('Eve','Laurens','12-03-2017','12-01-2004','','25');






INSERT INTO STUDENT_COURSE(id_student, id_course) VALUES
(1,91),
(1,135),
(1,95),
(1,98),
(2,120),
(2,121),
(2,122),
(3,129),
(3,131),
(3,97),
(3,98),
(3,92),
(4,135),
(4,92),
(4,93),
(4,110),
(5,111),
(6 ,112 ),
(6 ,113 ),
(6 ,117 ),
(7 ,119 ),
(7 ,116 ),
(7 ,105 ),
(8 ,104 ),
(8 ,103 ),
(8 ,102 ),
(9 ,100 ),
(9 ,93 ),
(9 ,94 ),
(10 ,102 ),
(10 ,110 ),
(10 ,118 ),
(11 ,111 ),
(11 ,110 ),
(11 ,108 ),
( 12,132 ),
( 12,131 ),
(12 ,134 ),
(13 ,132 ),
(13 ,127 ),
(13 , 99),
(14 ,100 ),
(14 ,101 ),
(14 ,103 ),
(15 ,106 ),
(15 ,119 ),
(15 ,121 ),
(16 ,92 ),
(16 ,93 ),
(16 ,133 ),
(17 ,132 ),
(17 ,131 ),
( 17,130 ),
(18,123 ),
(18 ,121 ),
(18 ,124 ),
(19 ,121 ),
(19 ,130 ),
(19 , 98),
(20 , 99),
(20 ,97 ),
(20 ,96 ),
(21 , 121),
(21 ,122 ),
(21 ,123 ),
(22 ,131 ),
(22 ,132 ),
(22 ,125 ),
(23 ,121 ),
(23 ,106 ),
(23 ,105 ),
( 24,132 ),
(24 ,134 ),
(24 ,133 ),
( 25, 91),
( 25,92 ),
( 25,93 ),
(20 , 117),
(20,118 ),
(21 , 93),
(21 ,94 )
;


INSERT INTO DEPARTAMENT_HEAD (id_departament, id_instructor) VALUES
(1,36),
(2,52),
(3,38),
(4,57),
(5,60),
(6,62),
(7,53),
(8,54),
(9,44),
(10,56),
(11,65),
(12,58),
(13,59),
(14,63),
(15,64);


SET sql_safe_updates = 0;

#Cream email de forma firstname+lastname@collegedomain.com
UPDATE INSTRUCTOR SET email = CONCAT(first_name, '-', last_name, '@collegedomain.com') WHERE email ='';

#Ptr un aspect mai frumos transformam toate caracterele in litere mici
UPDATE INSTRUCTOR SET email = LOWER(email) WHERE email LIKE '%@collegedomain.com';

#La fel ptr tabela STUDENT
UPDATE STUDENT SET email = CONCAT(first_name, '-', last_name, '@collegedomain.com') WHERE email ='';
UPDATE STUDENT SET email = LOWER(email) WHERE email LIKE '%@collegedomain.com';

#Adaugam 2 sapt. la cursurile atribuite departamentului 1
UPDATE COURSE SET DURATION_IN_WEEKS = DURATION_IN_WEEKS+2 WHERE id_departament=1;


####SUBINTEROGARI TIP SELECT


#ordonat alfabetic tabela STUDENT
SELECT*FROM STUDENT ORDER BY first_name, last_name ASC;

#nr. studenti inscrisi
SELECT count(*) as NR_STUDENTS from STUDENT;

#primii 2 instructori cu last_name Jones
SELECT*FROM INSTRUCTOR ORDER BY first_name, last_name ASC;

SELECT first_name, last_name FROM INSTRUCTOR
WHERE last_name= 'Jones'
LIMIT 2;


#toti instructorii nascuti in luna a8a
SELECT first_name, last_name FROM INSTRUCTOR
WHERE MONTH(birth_date) = 8;


####JOINS 


#JOIN 1
#Toti studentii care studiaza cursul cu id 92
SELECT STUDENT.id, last_name
      FROM STUDENT_COURSE 
INNER JOIN STUDENT ON STUDENT.id = STUDENT_COURSE.id_student
     WHERE STUDENT_COURSE.id_course = 92 ;
     
     
#JOIN 2
#Toate cursurile pentru studentul cu id 3

SELECT COURSE.id, course_name
      FROM STUDENT_COURSE 
INNER JOIN COURSE ON COURSE.id = STUDENT_COURSE.id_course
     WHERE STUDENT_COURSE.id_student= 3;
     
#JOIN 3
#Toate cursurile predata de instructorul cu id 36
SELECT COURSE.id, course_name
      FROM COURSE
INNER JOIN INSTRUCTOR ON COURSE.id_instructor = INSTRUCTOR.id
     WHERE INSTRUCTOR.id = 36;
     
####GROUP BY/HAVING

#Ordonam instructorii dupa data nasterii

SELECT   first_name, last_name, YEAR(birth_date) AS Year 
FROM   INSTRUCTOR
GROUP BY first_name, last_name, YEAR(birth_date)
order by Year(birth_date);


#Afisam toti instructorii nascuti dupa anul 1990 care lucreaza in departamentul 4
SELECT * FROM INSTRUCTOR GROUP BY id_departament, first_name,last_name,email HAVING id_departament = 4 AND YEAR(birth_date)>=1990;

#Afisam toti instructorii care s au angajat dupa anul 2010 si nu lucreaza in departamentul 11
SELECT * FROM INSTRUCTOR GROUP BY id_departament, first_name,last_name,email HAVING YEAR(hire_date)>2010 && id_departament != 11;


##### VIEW URI
#View 1
#Cate cursuri are fiecare student in ordinea descresc a nr de cursuri
CREATE OR REPLACE VIEW numberofcourses AS
SELECT STUDENT_COURSE.id_student,
count(STUDENT_COURSE.id_student) AS nrofcourses
FROM STUDENT_COURSE
	LEFT JOIN STUDENT ON STUDENT_COURSE.id_student = STUDENT.id
GROUP BY STUDENT_COURSE.id_student
ORDER BY nrofcourses DESC;

SELECT * FROM numberofcourses;


#View 2
#view cu first_name,last_name si adresa fiecarui student
CREATE OR REPLACE VIEW student_info AS
SELECT
	STUDENT.first_name AS first_name,
	STUDENT.last_name AS last_name,
	ADDRESS.address AS address,
    ADDRESS.city AS city
FROM STUDENT
	JOIN address
WHERE STUDENT.id_address= ADDRESS.id;
SELECT * FROM student_info;


####FUNCTII

#Functia 1
#Functie care returneaza vechimea de predare a unui profesor.Daca aceasta este mai mare de 5 ani ac va primi mesajul1, altfel mesajul2
#parametrii intrare first_name si last_name
DELIMITER //
CREATE FUNCTION YearsOfTeaching(firstname VARCHAR(50), lastname VARCHAR(50)) RETURNS varchar(200)
BEGIN 
	DECLARE teachingYears INT;
	DECLARE output VARCHAR(200);

	 SELECT
		TIMESTAMPDIFF(YEAR, INSTRUCTOR.hire_date, curdate())
	 INTO
		teachingYears
	 FROM INSTRUCTOR
	 WHERE INSTRUCTOR.first_name = firstname AND INSTRUCTOR.last_name = lastname;
   
    
    IF(teachingYears >= 5) THEN
		SET output = concat('We are greatful for the amazing teaching experience we encountered in your', teachingYears, ' of activity.
        We are thrilled to announce that you can now participate in the election of the departament headmaster.' );
	ELSE
		SET output = concat('We are greatful for the amazing teaching experience we encountered in your', teachingYears, ' of activity.
        We cannot wait for the new academic year to start.' );
	END IF;
    
    RETURN output;
END;
//
DELIMITER ;

SELECT YearsOfTeaching('Kyle', 'Jones');
SELECT YearsOfTeaching('Brad', 'Williams');

#Functia 2
#afiseaza toti studentii care locuiesc intr-un anumit oras. Functia va primi ca parametru numele orasului.
DELIMITER //
CREATE FUNCTION NumberOfStudentsInACity(cityname VARCHAR(50)) RETURNS varchar(200)
BEGIN 
	DECLARE numberofstudents INT;
	DECLARE output VARCHAR(200);

	 SELECT
		COUNT(ADDRESS.city)
	 INTO
		numberofstudents
	 FROM ADDRESS
	 WHERE ADDRESS.city = cityname;
   
    
    IF(numberofstudents != 0) THEN
		SET output = concat(numberofstudents, ' students live in', cityname);
	ELSE
		SET output = concat('There are not any students living in the', cityname);
	END IF;
    
    RETURN output;
END;
//
DELIMITER ;

SELECT NumberOfStudentsInACity('London');


#Functia 3
#functie care returneaza ce cursuri preda un instructor si numarul acestora. 
#Functia va primi ca parametru first_name si last_name din tabela instructor
DELIMITER //
CREATE FUNCTION InstructorCourses(firstname VARCHAR(50), lastname VARCHAR(50)) RETURNS TEXT
BEGIN
  
    DECLARE numberofcourses INT;
    DECLARE coursenames TEXT;
    DECLARE output TEXT;

	SELECT 
		count(COURSE.id),
		GROUP_CONCAT(COURSE.course_name ORDER BY COURSE.course_name SEPARATOR ', ')
    	INTO
		numberofcourses,
		coursenames
	FROM INSTRUCTOR
    JOIN COURSE ON COURSE.id_instructor = INSTRUCTOR.id
    WHERE INSTRUCTOR.first_name = firstname AND INSTRUCTOR.last_name = lastname ; 
   
    SET output= CONCAT(firstname, ' ',lastname , ': has ', numberofcourses , ' courses named: ', coursenames);
    
  IF(numberofcourses != 0) THEN
		RETURN output;
	ELSE
		RETURN CONCAT('There is no teacher with',firstname, '',lastname ,'in the courses database system.');
	END IF;
 END; 
//
DELIMITER ;

SELECT InstructorCourses('Kyle', 'Jones');



####PROCEDURES

#PROCEDURE1
#procedura care primeste ca parametru id ul unui curs si afiseaza toti stundetii inscrisi la el
DELIMITER //
CREATE PROCEDURE showStudents(IN course_id INT)
BEGIN

     DECLARE Students VARCHAR(200);
     DECLARE StudentsCount INT DEFAULT 0;
     DECLARE output VARCHAR(200);
SELECT
	GROUP_CONCAT(STUDENT.last_name ORDER BY STUDENT.last_name SEPARATOR ','),
	COUNT(STUDENT.last_name)
	
INTO Students, StudentsCount
	FROM STUDENT_COURSE 
INNER JOIN STUDENT ON STUDENT.id = STUDENT_COURSE.id_student
     WHERE STUDENT_COURSE.id_course = course_id;
  IF(StudentsCount != 0) THEN
		SET output = concat('There are ',StudentsCount,'  attending the course with the id  ', course_id,' Their names are: ', Students);
	ELSE
		SET output = concat('There are no students attending the course with the id ', course_id);
	END IF;
    
SELECT Students,StudentsCount, output;
     

END;
//
DELIMITER ;
CALL showStudents(91);

#PROCEDURE2
#procedura care afiseaza toate cursurile studentului cu id ca parametru si cate cursuri are acesta 
DELIMITER //
CREATE PROCEDURE ShowCourses(IN student_id INT)
BEGIN

     DECLARE Courses VARCHAR(200);
     DECLARE CoursesCount INT DEFAULT 0;
     DECLARE output VARCHAR(500);
SELECT
	GROUP_CONCAT(COURSE.course_name ORDER BY COURSE.course_name SEPARATOR ','),
	COUNT(COURSE.course_name)
	
INTO Courses, CoursesCount
      FROM STUDENT_COURSE 
INNER JOIN COURSE ON COURSE.id = STUDENT_COURSE.id_course
     WHERE STUDENT_COURSE.id_student= student_id;
  IF(CoursesCount != 0) THEN
		SET output = concat('The Student with the ',student_id, 'id is enrolled in ', CoursesCount,'courses, those being',Courses);
	ELSE
		SET output = concat('The student with the id',student_id,'is not enrolled in any courses at the moment.');
	END IF;
    
SELECT Courses,CoursesCount, output;
     

END;
//
DELIMITER ;
CALL showCourses(1);


#PROCEDURE3
#Toate cursurile predata de instructorul cu id dat ca parametru. In functie de numarul cursurilor predate, se va face gradarea acestuia.

DELIMITER //
CREATE PROCEDURE ShowInstructorCourses(IN Instructor_id INT)
BEGIN

     DECLARE Courses VARCHAR(200);
     DECLARE CoursesCount INT DEFAULT 0;
     DECLARE output1 VARCHAR(500);
     DECLARE output2 VARCHAR(500);
SELECT
	GROUP_CONCAT(COURSE.course_name ORDER BY COURSE.course_name SEPARATOR ','),
	COUNT(COURSE.course_name)
	
INTO Courses, CoursesCount
       FROM COURSE
INNER JOIN INSTRUCTOR ON COURSE.id_instructor = INSTRUCTOR.id
     WHERE INSTRUCTOR.id = Instructor_id;
     
  IF(CoursesCount != 0) THEN
		SET output1 = concat('The Instructor with the ',Instructor_id, 'id teaches ', CoursesCount,'courses, those being',Courses);
	ELSE
		SET output1 = concat('The Instructor with the id',student_id,'is not teaching any courses at the moment.');
	END IF;

CASE CoursesCount
		WHEN CoursesCount>2 THEN SET output2 = concat('Level 3 Instructor');
		WHEN CoursesCount<=2 AND COURSESCOUNT>0 THEN SET output2 = concat('Level 2 Instructor');
		ELSE SET output2 = concat('Beginner Instructor');
	END CASE;
    
    
SELECT Courses,CoursesCount, output1, output2;
     

END;
//
DELIMITER ;
Call ShowInstructorCourses(36);





####CURSORI

#CURSOR1
##Lista email-uri Instructors
DELIMITER //
CREATE PROCEDURE createEmailList (INOUT emailList varchar(4000))
BEGIN
	DECLARE finished INT DEFAULT 0;
	DECLARE emailAddress VARCHAR(100) DEFAULT "";

	DEClARE curEmail 
		CURSOR FOR 
			SELECT email FROM INSTRUCTOR;

	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curEmail;

	getEmail: LOOP
		FETCH curEmail INTO emailAddress;
		IF finished = 1 THEN 
			LEAVE getEmail;
		END IF;
		SET emailList = CONCAT(emailAddress,";",emailList);
	END LOOP getEmail;
	CLOSE curEmail;

END
//
DELIMITER ;
SET @emailList = ""; 
CALL createEmailList(@emailList); 
SELECT @emailList;

INSERT INTO COURSE(course_name, id_departament,DURATION_IN_WEEKS,id_instructor) value
('Physics 1',1,16,51);
#CURSOR2
#Procedure care afiseaza instructorii care nu au last_name unic
DELIMITER //
CREATE PROCEDURE not_unique_last_name ()
BEGIN
declare list_last_names varchar(200);

    declare v_last_name varchar(20);

    declare v_numbers int;

    declare ok int default 0;

 declare c cursor for select last_name, count(id) from INSTRUCTOR group by last_name;

    declare continue handler for not found 
    begin set ok=1;
    end;

    

    open c;

    LOOPS: loop

 fetch c into v_last_name, v_numbers;

        if ok=1 then leave LOOPS;

        end if;

        if v_numbers>=3 then

 set list_last_names=concat_ws(';',list_last_names,v_last_name);

 end if;

 end loop LOOPS;

    close c;

    select list_last_names;

END
//
DELIMITER ;

CALL not_unique_last_name();
#CURSOR3
#Procedure care afiseaza toate departamentele cu cel putin 3 cursuri
DELIMITER //
create procedure courses_in_departaments()
begin

    declare c_departament varchar(20);
    declare c_numbers int;

    declare outputdepartament varchar(200);

    declare ok int default 0;

	declare c cursor for
		select category as departament,
			count(id_departament) as numbers
		from DEPARTAMENT 
		left join COURSES on DEPARTAMENT.id_client = COURSES.id_client
		group by departament;

	declare continue handler for not found 
	begin
		set ok = 1;
	end;
	open c;
	LOOPS: loop
			fetch c into c_departament, c_numbers;
			if ok=1 then leave LOOPS;
			end if;
			if c_numbers>3 then set outputdepartament=concat_ws(';',outputdepartament,c_departament);
			end if;
	end loop LOOPS;
	close c;
	
	select outputdepartament;
end;
//DELIMITER;
CALL courses_in_departaments();






#####TRIGGERS



#TRIGGER1
#daca un instructor are email field-ul empty, atunci sa se creze un trigger a.î. email format = 'first_name-last_name@collegedomain.com
DELIMITER //
CREATE TRIGGER EmailCorrectionInstructor BEFORE INSERT ON INSTRUCTOR
FOR EACH ROW
BEGIN 
		IF(NEW.email IS NULL) THEN
			SET NEW.email = CONCAT(NEW.first_name, '-', NEW.last_name, '@collegedomain.com');
		END IF;
END;
//
DELIMITER ;
INSERT INTO INSTRUCTOR(first_name, last_name,birth_date,hire_date,email, id_departament) VALUES
	('Laura', 'Millers', '1997-02-03','2021-09-28',NULL, 7);

SELECT*FROM INSTRUCTOR;

#TRIGGER2
#Daca un instructor isi schimba departamentul in care lucreaza, atunci acesta va primi un welcome email
SET @Email = '';
DELIMITER //
CREATE TRIGGER ChangingDepartament AFTER UPDATE ON INSTRUCTOR
FOR EACH ROW
BEGIN
	
    IF(OLD.id_departament!=NEW.id_departament) THEN
	SET @Email = concat('Welcome to our departament.We are glad to have you here');
    END IF;
END;
//
DELIMITER ;


UPDATE INSTRUCTOR SET INSTRUCTOR.id_departament = '4' WHERE first_name='Lauren' AND last_name='Anderson';
SELECT @Email;

#TRIGGER3
#Daca un instructor are hire_date field-ul empty, atunci acesta va fi trecut cu currentdate
DELIMITER //
CREATE TRIGGER HireDateInstructor BEFORE INSERT ON INSTRUCTOR
FOR EACH ROW
BEGIN 
		IF(NEW.hire_date IS NULL) THEN
			SET NEW.hire_date =CURDATE();
		END IF;
END;
//
DELIMITER ;
INSERT INTO INSTRUCTOR(first_name, last_name,birth_date,hire_date,email, id_departament) VALUES
	('Alexia', 'Laurens', '1997-06-03',NULL,NULL, 7);

