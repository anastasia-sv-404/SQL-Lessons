USE study;

/*
Создайте процедуру, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

##Вариант 1: CASE и временные переменные, использование FLOOR

delimiter //
CREATE PROCEDURE proc(sec INT)
BEGIN
DECLARE min INT DEFAULT FLOOR(sec/60);
DECLARE hours INT DEFAULT FLOOR(min/60);
DECLARE days INT DEFAULT FLOOR(hours/24);

DECLARE temp_sec INT DEFAULT sec - min * 60;
DECLARE temp_min INT DEFAULT FLOOR((sec - hours * 3600)/60);
DECLARE temp_hours INT DEFAULT FLOOR((sec - days*24*60*60)/3600);

DECLARE result VARCHAR(128);
	CASE
		WHEN sec BETWEEN 0 AND 59 THEN
        SET result = CONCAT(sec, ' ', 'second(s)');
        SELECT result;
		WHEN sec BETWEEN 60 AND 3599 THEN
        SET result = CONCAT(min, ' ', 'minute(s)', ' ', temp_sec, ' ', 'second(s)');
        SELECT result;
 		WHEN sec BETWEEN 3600 AND 86399 THEN
        SET result = CONCAT(hours, ' ', 'hour(s)', ' ', temp_min, ' ', 'minute(s)',' ', temp_sec, ' ', 'second(s)');
        SELECT result;
        WHEN sec >= 86400 THEN
        SET result = CONCAT(days, ' ', 'day(s)', ' ', temp_hours, ' ', 'hour(s)', ' ', temp_min, ' ', 'minute(s)',' ', temp_sec, ' ', 'second(s)');        
        SELECT result;
        END CASE;
END //
delimiter ;

DROP PROCEDURE IF EXISTS proc;

CALL proc(123456);


##Вариант 2: без CASE, использование DIV и %

delimiter //
CREATE PROCEDURE proc2(sec INT)
BEGIN
    DECLARE min INT DEFAULT sec DIV 60;
    DECLARE hours INT DEFAULT min DIV 60;
    DECLARE days INT DEFAULT hours DIV 24;
    DECLARE result VARCHAR(128);
    SET min = min % 60;
    SET hours = hours % 24;
    SET sec = sec % 60;

    SET result = CONCAT(days, ' day(s) ', hours, ' hour(s) ', min, ' minute(s) ', sec, ' second(s)');
    SELECT result;
END //
delimiter ;

DROP PROCEDURE IF EXISTS proc2;

CALL proc2(86400);


/*
Создайте функцию, которая  выводит только четные числа от 1 до 10 включительно.
Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
*/

delimiter //
CREATE FUNCTION even_num()
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
DECLARE num1 INT DEFAULT 1;
DECLARE num2 INT DEFAULT 10;
DECLARE result VARCHAR(50) DEFAULT '';

WHILE num1 <= num2 DO
	IF num1 % 2 = 0 THEN
    SET result = CONCAT(result, ' ', num1);
    END IF;
	SET num1 = num1 + 1;
END WHILE;

RETURN result;
END //
delimiter ;

DROP FUNCTION IF EXISTS even_num;

SELECT even_num();
