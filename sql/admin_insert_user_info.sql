DROP PROCEDURE IF EXISTS admin_insert_user_info;
delimiter $$
CREATE PROCEDURE admin_insert_user_info(puID VARCHAR(100), puPassword VARCHAR(100), puIdentity TINYINT)
BEGIN   
 DECLARE `_HOST` CHAR(14) DEFAULT '@\'localhost\'';
 declare tempuID VARCHAR(100);   
 SET tempuID = (SELECT uID FROM user_info WHERE uID=puID);   
 IF tempuID is NULL   
 THEN    
  IF puIdentity=0     
  THEN
   INSERT INTO student_info(uID) VALUES(puID);      
   INSERT INTO user_info VALUES(puID, puPassword, puIdentity, LAST_insert_ID());    
	SET `puID` := CONCAT('\'', REPLACE(TRIM(`puID`), CHAR(39), CONCAT(CHAR(92), CHAR(39))), '\''),
    `puPassword` := CONCAT('\'', REPLACE(`puPassword`, CHAR(39), CONCAT(CHAR(92), CHAR(39))), '\'');
    SET @`sql` := CONCAT('CREATE USER ', `puID`, `_HOST`, ' IDENTIFIED BY ', `puPassword`);
    PREPARE `stmt` FROM @`sql`;
    EXECUTE `stmt`;   
  END IF;    
  IF puIdentity=1     
  THEN      
   INSERT INTO teacher_info(uID) VALUES(puID);      
   INSERT INTO user_info VALUES(puID, puPassword, puIdentity, LAST_insert_ID());    
	SET `puID` := CONCAT('\'', REPLACE(TRIM(`puID`), CHAR(39), CONCAT(CHAR(92), CHAR(39))), '\''),
    `puPassword` := CONCAT('\'', REPLACE(`puPassword`, CHAR(39), CONCAT(CHAR(92), CHAR(39))), '\'');
    SET @`sql` := CONCAT('CREATE USER ', `puID`, `_HOST`, ' IDENTIFIED BY ', `puPassword`);
    PREPARE `stmt` FROM @`sql`;
    EXECUTE `stmt`;
  END IF;   
 END IF; 
END;
$$
delimiter ;
