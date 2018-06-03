delimiter $$
	CREATE PROCEDURE teacher_select_student_info() SELECT * FROM student_info;$$
	CREATE PROCEDURE teacher_select_SC_info() SELECT * FROM SC;$$
	CREATE PROCEDURE teacher_select_teacher_info() SELECT * FROM teacher_info WHERE replace(user(), '@localhost', '')=uID;$$
$$
delimiter ;
