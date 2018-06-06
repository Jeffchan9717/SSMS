DROP PROCEDURE IF EXISTS admin_select_teacher_info;
delimiter $$
	CREATE PROCEDURE admin_select_teacher_info() SELECT * FROM teacher_info;$$
delimiter ;
