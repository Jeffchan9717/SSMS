DROP PROCEDURE IF EXISTS teacher_insert_TC;
delimiter $$
CREATE PROCEDURE teacher_insert_TC(pcID int)
BEGIN
	declare temptID int;
	SET temptID=(SELECT tID FROM teacher_info WHERE replace(user(), '@localhost', '')=uID);
	INSERT INTO TC VALUES(temptID, pcID);
END
$$
delimiter ;
