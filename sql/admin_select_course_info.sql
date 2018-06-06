DROP PROCEDURE IF EXISTS admin_select_course_info;
delimiter $$
	CREATE PROCEDURE admin_select_course_info() SELECT * FROM course_info;$$
delimiter ;
