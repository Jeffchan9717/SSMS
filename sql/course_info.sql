DROP TABLE IF EXISTS course_info;
CREATE TABLE course_info (
  cID varchar(20) NOT NULL,         -- 课程号
  cName varchar(100) DEFAULT NULL,  -- 课程名
  cCredit tinyint(4) DEFAULT NULL,  -- 课程学分
  cTerm varchar(10) DEFAULT NULL,   -- 课程学期
  PRIMARY KEY (cID)
);