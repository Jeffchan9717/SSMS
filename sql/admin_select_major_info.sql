DROP PROCEDURE IF EXISTS admin_select_major_info;
delimiter $$
	CREATE PROCEDURE admin_select_major_info() SELECT * FROM major_info;$$
delimiter ;
