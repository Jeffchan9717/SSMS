delimiter $$
	CREATE PROCEDURE student_select_student_info() SELECT * FROM student_info WHERE replace(user(), '@localhost', '')=uID;$$
$$
delimiter ;
