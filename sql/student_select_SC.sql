DROP PROCEDURE IF EXISTS student_select_SC;
delimiter $$
CREATE PROCEDURE student_select_SC()
	SELECT SC.sID, SC.cID, SC.scScore, cCredit FROM SC, user_info, student_info, course_info  WHERE
	replace(user(), '@localhost', '')=user_info.uID
	and SC.sID=student_info.sID
	and student_info.uID=user_info.uID
	and course_info.cID=SC.cID;
$$
delimiter ;
