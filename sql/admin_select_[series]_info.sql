delimiter $$
	CREATE PROCEDURE admin_select_user_info() BEGIN  SELECT * FROM user_info; END;$$
	CREATE PROCEDURE admin_select_student_info() SELECT * FROM student_info;$$
	CREATE PROCEDURE admin_select_teacher_info() SELECT * FROM student_info;$$
	CREATE PROCEDURE admin_select_course_info() SELECT * FROM course_info;$$
	CREATE PROCEDURE admin_select_major_info() SELECT * FROM major_info;$$
	CREATE PROCEDURE admin_select_SC_info() SELECT * FROM SC;$$
	CREATE PROCEDURE admin_select_TC_info() SELECT * FROM TC;$$
$$
delimiter ;
