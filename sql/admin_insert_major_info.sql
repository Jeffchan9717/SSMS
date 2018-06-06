DROP PROCEDURE IF EXISTS admin_insert_major_info;
delimiter $$
	CREATE PROCEDURE admin_insert_major_info(mID SMALLINT, mName VARCHAR(100)) INSERT INTO major_info VALUES(mID, mName);
$$
delimiter ;
