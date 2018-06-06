DROP PROCEDURE IF EXISTS teacher_select_SC_info;
delimiter $$
	CREATE PROCEDURE teacher_select_SC_info() SELECT * FROM SC;$$
delimiter ;
