DROP PROCEDURE IF EXISTS admin_select_SC_info;
delimiter $$
	CREATE PROCEDURE admin_select_SC_info() SELECT * FROM SC;$$
delimiter ;
