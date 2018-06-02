DROP TABLE IF EXISTS SC;
CREATE TABLE SC (
  sID varchar(20) NOT NULL, -- 学生表_学号
  cID varchar(20) NOT NULL, -- 课程表_课程号
  scScore tinyint(4) DEFAULT NULL,  -- 成绩
  PRIMARY KEY (sID,cID)
);