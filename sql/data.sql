call admin_insert_user_info('钟巧言', '281767', 0);
call admin_insert_user_info('王栋', '213213', 0);
call admin_insert_user_info('嘉吉', '638585', 0);
call admin_insert_user_info('小梅', '2163232', 0);
call admin_insert_user_info('李玉婷', '901120', 1);
call admin_insert_user_info('赵师师', '312', 1);
call admin_insert_user_info('王思文', '1111', 1);

call admin_insert_course_info('计算机导论', 2, '201801');
call admin_insert_course_info('计算机基础', 1, '201801');
call admin_insert_course_info('高等数学', 6, '201801');
call admin_insert_course_info('线性代数', 4, '201802');
call admin_insert_course_info('离散数学', 5, '201802');
call admin_insert_course_info('C语言', 3, '201801');

假设上面课程的cID分别为 1 ～ 6；
INSERT INTO SC VALUES('钟巧言', 1);
INSERT INTO SC VALUES('钟巧言', 2);
INSERT INTO SC VALUES('钟巧言', 3);
INSERT INTO SC VALUES('钟巧言', 6);
INSERT INTO SC VALUES('王栋', 1);
INSERT INTO SC VALUES('王栋', 3);
INSERT INTO SC VALUES('王栋', 5);
INSERT INTO SC VALUES('嘉吉', 1);
INSERT INTO SC VALUES('嘉吉', 5);
INSERT INTO SC VALUES('小梅', 4);
INSERT INTO SC VALUES('小梅', 6);

INSERT INTO TC VALUES('李玉婷', 1);
INSERT INTO TC VALUES('李玉婷', 2);
INSERT INTO TC VALUES('李玉婷', 3);
INSERT INTO TC VALUES('赵师师', 1);
INSERT INTO TC VALUES('赵师师', 4);
INSERT INTO TC VALUES('赵师师', 5);
INSERT INTO TC VALUES('王思文', 2);
INSERT INTO TC VALUES('王思文', 4);
INSERT INTO TC VALUES('王思文', 6);

#专业表没用上
