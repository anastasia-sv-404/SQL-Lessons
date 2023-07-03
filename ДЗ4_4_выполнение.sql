-- Последнее задание, таблица:
USE study;

DROP TABLE IF EXISTS Analysis;
CREATE TABLE Analysis
(
	an_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	an_name varchar(50),
	an_cost INT,
	an_price INT,
	an_group INT
);

INSERT INTO analysis (an_name, an_cost, an_price, an_group)
VALUES 
	('Общий анализ крови', 30, 50, 1),
	('Биохимия крови', 150, 210, 1),
	('Анализ крови на глюкозу', 110, 130, 1),
	('Общий анализ мочи', 25, 40, 2),
	('Общий анализ кала', 35, 50, 2),
	('Общий анализ мочи', 25, 40, 2), #Видится неточность: есть 2 абсолютно одинаковые строки, но с разынми id
	('Тест на COVID-19', 160, 210, 3);

SELECT * FROM analysis;


DROP TABLE IF EXISTS GroupsAn;
CREATE TABLE GroupsAn
(
	gr_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	gr_name varchar(50),
	gr_temp FLOAT(5,1),
	FOREIGN KEY (gr_id) REFERENCES Analysis (an_id) ON DELETE CASCADE ON UPDATE CASCADE
);  
#Видится, что вот здесь в таблице закралась неточность: id анализа не может совпадать с id группы анализа. Видимо, связка должна была идти по полю an_group вместо an_id

INSERT INTO groupsan (gr_name, gr_temp)
VALUES 
	('Анализы крови', -12.2),
	('Общие анализы', -20.0),
	('ПЦР-диагностика', -20.5);

SELECT * FROM groupsan;


DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	ord_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ord_datetime DATETIME,	-- 'YYYY-MM-DD hh:mm:ss'
	ord_an INT,
	FOREIGN KEY (ord_an) REFERENCES Analysis (an_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (ord_datetime, ord_an)
VALUES 
	('2020-02-04 07:15:25', 1),
	('2020-02-04 07:20:50', 2),
	('2020-02-04 07:30:04', 1),
	('2020-02-04 07:40:57', 1),
	('2020-02-05 07:05:14', 1),
	('2020-02-05 07:15:15', 3),
	('2020-02-05 07:30:49', 3),
	('2020-02-06 07:10:10', 2),
	('2020-02-06 07:20:38', 2),
	('2020-02-07 07:05:09', 1),
	('2020-02-07 07:10:54', 1),
	('2020-02-07 07:15:25', 1),
	('2020-02-08 07:05:44', 1),
	('2020-02-08 07:10:39', 2),
	('2020-02-08 07:20:36', 1),
	('2020-02-08 07:25:26', 3),
	('2020-02-09 07:05:06', 1),
	('2020-02-09 07:10:34', 1),
	('2020-02-09 07:20:19', 2),
	('2020-02-10 07:05:55', 3),
	('2020-02-10 07:15:08', 3),
	('2020-02-10 07:25:07', 1),
	('2020-02-11 07:05:33', 1),
	('2020-02-11 07:10:32', 2),
	('2020-02-11 07:20:17', 3),
	('2020-02-12 07:05:36', 1),
	('2020-02-12 07:10:54', 2),
	('2020-02-12 07:20:19', 3),
	('2020-02-12 07:35:38', 1);



/*
Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
С семинара: до 12 февраля включительно.
*/

#Проверочная (промежуточная) таблица
SELECT A.an_name, A.an_price, O.ord_datetime
FROM Analysis AS A
JOIN Orders AS O
ON A.an_id = O.ord_an
WHERE O.ord_datetime BETWEEN '2020-02-05 00:00:00' AND '2020-02-12 23:59:59'
ORDER BY O.ord_datetime;

#Итог выполнения
SELECT A.an_name, A.an_price
FROM Analysis AS A
JOIN Orders AS O
ON A.an_id = O.ord_an
WHERE O.ord_datetime BETWEEN '2020-02-05 00:00:00' AND '2020-02-12 23:59:59';


#Итог выполнения + дополнительная группировка по имени анализа и суммарная стоимость всех анализова с данным именем за весь анализируемый период.
SELECT temp.an_name, SUM(temp.an_price) AS sum_price
FROM 
(SELECT A.an_name, A.an_price
FROM Analysis AS A
JOIN Orders AS O
ON A.an_id = O.ord_an
WHERE O.ord_datetime BETWEEN '2020-02-05 00:00:00' AND '2020-02-12 23:59:59') AS temp
GROUP BY temp.an_name;