drop PROCEDURE if exists sp_validateLogin;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateLogin`(
IN p_id VARCHAR(20)
)
BEGIN
    select * from user_info where uID = p_id;
END$$
DELIMITER ;