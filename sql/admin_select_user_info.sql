DROP PROCEDURE IF EXISTS admin_select_user_info;
delimiter $$
	CREATE PROCEDURE admin_select_user_info() BEGIN  SELECT * FROM user_info; END;$$
delimiter ;
