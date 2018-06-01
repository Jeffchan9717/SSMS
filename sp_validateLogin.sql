drop PROCEDURE if exists sp_validateLogin;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateLogin`(
IN p_username VARCHAR(20)
)
BEGIN
    select * from ssms_user where user_username = p_username;
END$$
DELIMITER ;