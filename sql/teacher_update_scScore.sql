DROP PROCEDURE IF EXISTS teacher_update_scScore;
delimiter $$
CREATE PROCEDURE teacher_update_scScore(psID int, pcID int, pscScore TINYINT)
BEGIN
	declare temptID int;
	SET temptID=(SELECT teacher_info.tID FROM TC, teacher_info WHERE replace(user(), '@localhost', '')=teacher_info.uID and TC.tID=teacher_info.tID);
	IF temptID is not NULL
	THEN
	UPDATE SC SET
	scScore=pscScore
	WHERE sID=psID and cID=pcID;
	END IF;
END
$$
delimiter ;
