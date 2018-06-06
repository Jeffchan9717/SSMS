DROP PROCEDURE IF EXISTS admin_revoke_user_access;
delimiter $$
CREATE PROCEDURE admin_revoke_user_access(puID VARCHAR(100))
BEGIN
 DECLARE `_HOST` CHAR(14) DEFAULT '@\'localhost\'';
 SET @`sql`:=CONCAT('REVOKE ALL PRIVILEGES on *.* FROM ', `puID`, `_HOST`);
 PREPARE `stmt` FROM @`sql`;
 EXECUTE `stmt`;
END
$$
delimiter ;
