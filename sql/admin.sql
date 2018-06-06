DROP DATABASE if exists school;
CREATE database school;
	ALTER DATABASE school CHARACTER SET utf8 COLLATE utf8_general_ci;
	USE school;

CREATE table major_info(mID SMALLINT PRIMARY KEY, mName VARCHAR(100));
	CREATE table student_info(sID int auto_increment, mID SMALLINT, sName VARCHAR(30), sSex TINYINT, sBirthday date, sBirthplace VARCHAR(50), sCollege VARCHAR(60), sClass TINYINT, PRIMARY KEY(sID), foreign KEY(mID) references  major_info(mID));
	ALTER table student_info add column uID VARCHAR(100) unique;
	CREATE table teacher_info(tID int auto_increment, mID SMALLINT, tName VARCHAR(30), tSex TINYINT, tCollege VARCHAR(60), PRIMARY KEY (tID), foreign KEY(mID) references major_info(mID));
	ALTER table teacher_info add column uID VARCHAR(100);
	CREATE table course_info(cID int auto_increment PRIMARY KEY, cName VARCHAR(100) not null, cCredit TINYINT, cTerm VARCHAR(10));
	CREATE table user_info(uID VARCHAR(100) PRIMARY KEY, uPassword VARCHAR(100), uIdentity TINYINT, uNumber int);
	CREATE table SC(sID int, cID int, scScore TINYINT, foreign KEY(sID) references student_info(sID), foreign KEY(cID) references course_info(cID), PRIMARY KEY(sID, cID));
	CREATE table TC(tID int, cID int, foreign KEY(tID) references teacher_info(tID), foreign KEY(cID) references course_info(cID));
