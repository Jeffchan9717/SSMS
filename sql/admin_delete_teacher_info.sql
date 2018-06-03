delimiter $$
CREATE PROCEDURE admin_delete_teacher_info(ptID int)
BEGIN
 DECLARE `_HOST` CHAR(14) DEFAULT '@\'localhost\'';
 declare `tempuID` VARCHAR(100);
 SET tempuID=(SELECT uID FROM teacher_info WHERE tID=ptID);
 SET @`sql`:=CONCAT('DROP USER ', `tempuID`, `_HOST`);
 PREPARE `stmt` FROM @`sql`;
 EXECUTE `stmt`;
 DELETE FROM user_info WHERE uID in (SELECT uID FROM teacher_info WHERE tID=ptID);
 DELETE FROM TC WHERE tID=ptID;
 DELETE FROM teacher_info WHERE tID=ptID;
END
$$
delimiter ;
