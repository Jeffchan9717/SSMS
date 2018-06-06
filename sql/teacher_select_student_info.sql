DROP PROCEDURE IF EXISTS teacher_select_student_info;
delimiter $$
	CREATE PROCEDURE teacher_select_student_info() SELECT * FROM student_info;$$
delimiter ;
