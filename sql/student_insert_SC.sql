DROP PROCEDURE IF EXISTS student_insert_SC;
delimiter $$
CREATE PROCEDURE student_insert_SC(pcID int)
BEGIN
	declare tempsID int;
	SET tempsID=(SELECT sID FROM student_info WHERE replace(user(), '@localhost', '')=uID);
	INSERT INTO SC VALUES(tempsID, pcID, NULL);
END
$$
delimiter ;
