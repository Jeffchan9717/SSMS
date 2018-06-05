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

-- 假设上面课程的cID分别为 1 ～ 6；
INSERT INTO SC VALUES(3, 1, 94);
INSERT INTO SC VALUES(3, 2, 52);
INSERT INTO SC VALUES(3, 3, 66);
INSERT INTO SC VALUES(3, 6, 81);
INSERT INTO SC VALUES(4, 1, 88);
INSERT INTO SC VALUES(4, 3, 99);
INSERT INTO SC VALUES(4, 5, 78);
INSERT INTO SC VALUES(5, 1, 60);
INSERT INTO SC VALUES(5, 5, 72);
INSERT INTO SC VALUES(6, 4, 74);
INSERT INTO SC VALUES(6, 6, 91);

INSERT INTO TC VALUES(4, 1);
INSERT INTO TC VALUES(4, 2);
INSERT INTO TC VALUES(4, 3);
INSERT INTO TC VALUES(5, 1);
INSERT INTO TC VALUES(5, 4);
INSERT INTO TC VALUES(5, 5);
INSERT INTO TC VALUES(6, 2);
INSERT INTO TC VALUES(6, 4);
INSERT INTO TC VALUES(6, 6);

-- #专业表没用上
