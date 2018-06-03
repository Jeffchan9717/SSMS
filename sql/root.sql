root
	CREATE user 'admin'@localhost IDENTIFIED by 'password';
	GRANT ALL on *.* to 'admin'@localhost with GRANT OPTION;

