DROP TABLE IF EXISTS student_info;
CREATE TABLE student_info (
  sID varchar(20) NOT NULL,         -- 学生号
  mID smallint(6) DEFAULT NULL,     -- 专业号
  sName varchar(30) DEFAULT NULL,   -- 姓名
  sSex varchar(10) DEFAULT NULL,    -- 性别
  sBirthday date DEFAULT NULL,      -- 出生日期
  sBirthplace varchar(50) DEFAULT NULL, -- 籍贯
  sCollege varchar(60) DEFAULT NULL,    -- 院系
  sClass tinyint(4) DEFAULT NULL,       -- 班级
  PRIMARY KEY (`sID`)
);

DROP TABLE IF EXISTS course_info;
CREATE TABLE course_info (
  cID varchar(20) NOT NULL,         -- 课程号
  cName varchar(100) DEFAULT NULL,  -- 课程名
  cCredit tinyint(4) DEFAULT NULL,  -- 课程学分
  cTerm varchar(10) DEFAULT NULL,   -- 课程学期
  PRIMARY KEY (cID)
);

DROP TABLE IF EXISTS teacher_info;
CREATE TABLE teacher_info (
  tID varchar(10) NOT NULL,           -- 教工号
  mID smallint(6) DEFAULT NULL,       -- 专业号
  tName varchar(30) DEFAULT NULL,     -- 姓名
  tSex tinyint(4) DEFAULT NULL,       -- 性别
  tCollege varchar(60) DEFAULT NULL,  -- 院系
  PRIMARY KEY (tID)
);

DROP TABLE IF EXISTS major_info;
CREATE TABLE major_info (
  mID smallint(6) NOT NULL,         -- 专业号
  mName varchar(100) DEFAULT NULL,  -- 专业名称
  PRIMARY KEY (mID)
);

DROP TABLE IF EXISTS SC;
CREATE TABLE SC (
  sID varchar(20) NOT NULL, -- 学生表_学号
  cID varchar(20) NOT NULL, -- 课程表_课程号
  scScore tinyint(4) DEFAULT NULL,  -- 成绩
  PRIMARY KEY (sID,cID)
);

DROP TABLE IF EXISTS TC;
CREATE TABLE TC (
  tID varchar(10) NOT NULL, -- 教师表_教工号
  cID varchar(20) NOT NULL, -- 课程表_课程号
  PRIMARY KEY (tID,cID)
);

drop table if exists user_info;
create table user_info (
    user_username VARCHAR(20),  -- 用户名
    user_password VARCHAR(512)  -- 用户密码
);

