DROP PROCEDURE IF EXISTS teacher_select_teacher_info;
delimiter $$
	CREATE PROCEDURE teacher_select_teacher_info() SELECT * FROM teacher_info WHERE replace(user(), '@localhost', '')=uID;$$
$$
delimiter ;
