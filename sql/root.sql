DROP USER IF EXISTS 'admin'@localhost;
DROP USER IF EXISTS 'vancir'@localhost;

INSERT INTO user_info VALUES('admin', '2Htz$6PLmV0x54xa', 2, 0);
CREATE user 'admin'@localhost IDENTIFIED by '2Htz$6PLmV0x54xa';
GRANT ALL on *.* to 'admin'@localhost with GRANT OPTION;

INSERT INTO user_info VALUES('vancir', '06sQ6b@P@du4rEab', 2, 1);
create user 'vancir'@'localhost' identified by '06sQ6b@P@du4rEab';
GRANT ALL on *.* to 'vancir'@localhost with GRANT OPTION;
