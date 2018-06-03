root
	CREATE user 'admin'@localhost IDENTIFIED by '123456';
	GRANT ALL on *.* to 'admin'@localhost with GRANT OPTION;

