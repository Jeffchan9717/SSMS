DROP PROCEDURE IF EXISTS admin_delete_student_info;
delimiter $$
CREATE PROCEDURE admin_delete_student_info(psID int)
BEGIN
 DECLARE `_HOST` CHAR(14) DEFAULT '@\'localhost\'';
 declare `tempuID` VARCHAR(100);
 SET tempuID=(SELECT uID FROM student_info WHERE sID=psID);
 SET @`sql`:=CONCAT('DROP USER ', `tempuID`, `_HOST`);
 PREPARE `stmt` FROM @`sql`;
 EXECUTE `stmt`;
 DELETE FROM user_info WHERE uID in (SELECT uID FROM student_info WHERE sID=psID);
 DELETE FROM SC WHERE sID=psID;
 DELETE FROM student_info WHERE sID=psID;
END
$$
delimiter ;
