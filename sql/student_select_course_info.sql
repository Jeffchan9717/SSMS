DROP PROCEDURE IF EXISTS student_select_course_info;
delimiter $$
	CREATE PROCEDURE student_select_course_info() SELECT * FROM course_info;$$
delimiter ;
