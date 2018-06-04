delimiter $$
	CREATE PROCEDURE admin_insert_course_info(pcName VARCHAR(100), pcCredit TINYINT, pcTerm VARCHAR(10))
INSERT INTO course_info(cName, cCredit, cTerm) VALUES(pcName, pcCredit, pcTerm);
$$
delimiter ;
