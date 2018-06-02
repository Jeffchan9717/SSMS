DROP TABLE IF EXISTS TC;
CREATE TABLE TC (
  tID varchar(10) NOT NULL, -- 教师表_教工号
  cID varchar(20) NOT NULL, -- 课程表_课程号
  PRIMARY KEY (tID,cID)
);