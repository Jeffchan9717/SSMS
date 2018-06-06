DROP PROCEDURE IF EXISTS admin_delete_course_info;
delimiter $$
	CREATE PROCEDURE admin_delete_course_info(pcID int)
	DELETE FROM course_info WHERE cID=pcID;
$$
delimiter ;
