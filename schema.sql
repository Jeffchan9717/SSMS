drop table if exists student;
create table student (
  sID integer primary key autoincrement, -- 学号
  sName string not null, -- 姓名
  sSex string not null, -- 性别
  sBirthday string not null, -- 出生日期
  sBirthPlace string not null, -- 籍贯(出生地)
  sCollege string not null, -- 院系
  sMajor string not null, -- 专业
  sEnroll string not null -- 入学时间
);

drop table if exists teacher;
create table teacher (
  tID integer primary key autoincrement, -- 教工号
  tName string not null, -- 姓名
  tSex string not null, -- 性别
  tCollege string not null, -- 院系
  tMajor string not null, -- 专业
  tTitle string not null -- 职称
);

drop table if exists course;

create table course (
  cID integer primary key autoincrement, -- 课程号
  cName string not null, -- 课程名
  cCredit string not null -- 学分
);