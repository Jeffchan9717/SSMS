delimiter $$
CREATE PROCEDURE student_select_ctermScore(pcTerm VARCHAR(10))
	SELECT cTerm, course_info.cID, SC.scSCore FROM SC, course_info, student_info
	WHERE
	replace(user(), '@localhost', '')=student_info.uID
	and student_info.sID=SC.sID
	and course_info.cTerm=pcTerm
	and course_info.cID=SC.cID;
$$
delimiter ;
