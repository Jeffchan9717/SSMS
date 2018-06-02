DROP TABLE IF EXISTS teacher_info;

CREATE TABLE teacher_info (
  tID varchar(10) NOT NULL,           -- 教工号
  mID smallint(6) DEFAULT NULL,       -- 专业号
  tName varchar(30) DEFAULT NULL,     -- 姓名
  tSex tinyint(4) DEFAULT NULL,       -- 性别
  tCollege varchar(60) DEFAULT NULL,  -- 院系
  PRIMARY KEY (tID)
);