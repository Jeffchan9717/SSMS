DROP PROCEDURE IF EXISTS admin_update_student_info;
delimiter $$
	CREATE PROCEDURE admin_update_student_info(psID int, pmID SMALLINT, psName VARCHAR(30), psSex TINYINT, psBirthday date, psBirthplace VARCHAR(50), psCollege VARCHAR(60), psClass TINYINT)
UPDATE student_info SET
	mID=pmID,
	sName=psName,
	sSex=psSex,
	sBirthday=psBirthday,
	sBirthplace=psBirthplace,
	sCollege=psCollege,
	sClass=psClass
	WHERE sID=psID;
$$
delimiter ;
