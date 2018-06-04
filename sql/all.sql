source /home/vancir/Documents/code/SSMS/sql/root.sql
source /home/vancir/Documents/code/SSMS/sql/admin.sql
source /home/vancir/Documents/code/SSMS/sql/admin_insert_user_info.sql
source /home/vancir/Documents/code/SSMS/sql/admin_revoke_user_access.sql
source /home/vancir/Documents/code/SSMS/sql/teacher_insert_TC.sql
source /home/vancir/Documents/code/SSMS/sql/admin_delete_course_info.sql
source /home/vancir/Documents/code/SSMS/sql/admin_select_[series]_info.sql
source /home/vancir/Documents/code/SSMS/sql/teacher_select_[series]_info.sql
source /home/vancir/Documents/code/SSMS/sql/admin_delete_student_info.sql
source /home/vancir/Documents/code/SSMS/sql/teacher_select_TC.sql
source /home/vancir/Documents/code/SSMS/sql/admin_delete_teacher_info.sql
source /home/vancir/Documents/code/SSMS/sql/admin_update_course_info.sql
source /home/vancir/Documents/code/SSMS/sql/student_insert_SC.sql
source /home/vancir/Documents/code/SSMS/sql/teacher_update_scScore.sql
source /home/vancir/Documents/code/SSMS/sql/admin_GRANT_user_access.sql
source /home/vancir/Documents/code/SSMS/sql/admin_update_student_info.sql
source /home/vancir/Documents/code/SSMS/sql/student_select_ctermScore.sql
source /home/vancir/Documents/code/SSMS/sql/admin_insert_course_info.sql
source /home/vancir/Documents/code/SSMS/sql/admin_update_teacher_info.sql
source /home/vancir/Documents/code/SSMS/sql/student_select_SC.sql
source /home/vancir/Documents/code/SSMS/sql/admin_insert_major_info.sql
source /home/vancir/Documents/code/SSMS/sql/student_select_[series]_info.sql

CALL admin_insert_major_info(21, '计算机科学与技术');
CALL admin_insert_user_info('刘松', '123456', 0);
CALL admin_insert_user_info('张伟', '123456', 1);
CALL admin_insert_course(544, '计算机导论', 2, '201801');



