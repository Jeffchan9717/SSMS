# SSMS

## 目录结构

```
├── cmds.txt    - 数据库操作命令
├── main.py     - flask应用脚本
├── pdm.png     - 物理数据模型图(Physical Data Model, PDM)
├── README.md   - 仓库说明
├── sql
│   ├── all_table.sql       - 用于导入所有的表信息(是以下PDM中相应表的整合)
│   ├── alldb.sql           - 
│   ├── course_info.sql     - 课程表
│   ├── example.sql         - 添加基本的表信息
│   ├── major_info.sql      - 专业表
│   ├── school.sql          - 
│   ├── sc.sql              - 学生课程表
│   ├── sp_createUser.sql       - 创建存储过程sp_createUser, 该过程用于注册账号时存储信息
│   ├── sp_validateLogin.sql    - 创建存储过程sp_validateLogin, 该过程用于登录验证
│   ├── student_info.sql    - 学生表
│   ├── tc.sql              - 教师课程表
│   ├── teacher_info.sql    - 教师表
│   └── user_info.sql       - 用户表
├── er.pdf  - 数据库ER图
├── static/     - 一些UI设计文件
└── templates   - 模板文件
    ├── add.html    - 添加学生/教师信息页面
    ├── delete.html - 删除学生/教师信息页面
    ├── home.html   - 主页
    ├── layout.html - 基本页面
    ├── login.html  - 登录用页面
    ├── search.html - 搜索信息页面
    ├── signup.html - 注册用页面
    ├── update.html - 修改学生/教师信息页面
    └── view.html   - 查看学生/教师信息页面
```

## 更新MySQL至8.0版本

``` bash
cd /tmp/ && wget https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb
# 弹出mysql的apt设置, 选择MySQL Server & Cluster, 在其中选定mysql-8.0后选择OK返回
sudo apt update
sudo apt install mysql-server mysql-client
```

升级后报错

```
ERROR 1449 (HY000): The user specified as a definer ('mysql.infoschema'@'localhost') does not exist
```

解决方案

```
mysql_upgrade -u ${your_username} -p ${your_password}
```
