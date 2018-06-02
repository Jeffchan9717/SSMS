DROP TABLE IF EXISTS major_info;
CREATE TABLE major_info (
  mID smallint(6) NOT NULL,         -- 专业号
  mName varchar(100) DEFAULT NULL,  -- 专业名称
  PRIMARY KEY (mID)
);