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