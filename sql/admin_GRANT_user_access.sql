delimiter $$
CREATE PROCEDURE admin_GRANT_user_access(puID VARCHAR(100))
BEGIN
 DECLARE `_HOST` CHAR(14) DEFAULT '@\'localhost\'';
 SET @`sql`:=CONCAT('GRANT ALL PRIVILEGES on *.* to ', `puID`, `_HOST`);
 PREPARE `stmt` FROM @`sql`;
 EXECUTE `stmt`;
END
$$
#CALL admin_GRANT_user_access('刘松') ;
$$
delimiter ;
