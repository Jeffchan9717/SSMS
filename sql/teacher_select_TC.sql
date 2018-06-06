DROP PROCEDURE IF EXISTS teacher_select_TC;
delimiter $$
CREATE PROCEDURE teacher_select_TC()
	SELECT TC.tID, TC.cID, cTerm FROM TC, user_info, teacher_info, course_info  WHERE
	replace(user(), '@localhost', '')=user_info.uID
	and TC.tID=teacher_info.tID
	and teacher_info.uID=user_info.uID
	and course_info.cID=TC.cID;
$$
delimiter ;
