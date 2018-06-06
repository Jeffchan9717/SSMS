DROP PROCEDURE IF EXISTS sp_createUser;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_id VARCHAR(100), 
    IN p_password VARCHAR(100), 
    IN p_identity TINYINT, 
    IN p_number int
)
BEGIN
    if ( select exists (select 1 from user_info where uID = p_id) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into user_info
        (
            uID, 
            uPassword,
            uIdentity,
            uNumber
        )
        values
        (
            p_id,
            p_password,
            p_identity,
            p_number
        );
     
    END IF;
END$$
DELIMITER ;
