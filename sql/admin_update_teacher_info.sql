	CREATE PROCEDURE admin_update_teacher_info(ptID int, pmID SMALLINT, ptName VARCHAR(30), ptSex TINYINT, ptCollege VARCHAR(60))
UPDATE teacher_info SET
	mID=pmID,
	tName=ptName,
	tSex=ptSex,
	tCollege=ptCollege
	WHERE tID=ptID;
