drop table if exists ssms_user;

create table ssms_user (
    user_username VARCHAR(20),
    user_password VARCHAR(512)
)

drop PROCEDURE if exists sp_createUser;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(512)
)
BEGIN
    if ( select exists (select 1 from ssms_user where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into ssms_user
        (
            user_username,
            user_password
        )
        values
        (
            p_username,
            p_password
        );
     
    END IF;
END$$
DELIMITER ;