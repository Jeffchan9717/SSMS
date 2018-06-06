DROP PROCEDURE IF EXISTS admin_update_course_info;
delimiter $$
	CREATE PROCEDURE admin_update_course_info(pcID int, pcName VARCHAR(100), pcCredit TINYINT, pcTerm VARCHAR(10))
UPDATE course_info SET
	cName=pcName,
	cCredit=pcCredit,
	cTerm=pcTerm
	WHERE cID=pcID;
$$
delimiter ;
