USE study;

DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

SELECT * FROM `shops`;

DROP TABLE IF EXISTS `cats`;
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id) REFERENCES `shops` (id)
);

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);

SELECT * FROM `cats`;

/*
Задание 1. Вывести всех котиков по магазинам по id 
(условие соединения shops.id = cats.shops_id)
*/

/* Так как в данном случае условие не совсем понятно:
- нужно вывести только тех котов, которые ЕСТЬ в магазинах - INNER JOIN
- нужно вывести ВСЕХ котов вне зависимости от того, есть ли они в магазинах - LEFT JOIN к cats
реализованы оба запроса.
Учитывая особенности исходных данных, получаем одинаковый результат.
*/

SELECT c.`name`, s.`shopname`
FROM `cats` AS c
JOIN `shops` AS s
ON s.id = c.shops_id;

SELECT c.`name`, s.`shopname` 
FROM `cats` AS c 
LEFT JOIN `shops` AS s
ON s.id = c.shops_id;

/*
Задание 2. Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
*/

SELECT s.`shopname`
FROM `cats` AS c
JOIN `shops` AS s
ON s.id = c.shops_id
WHERE c.`name` = "Murzik";

SELECT s.`shopname`
FROM `cats` AS c
LEFT JOIN `shops` AS s
ON s.id = c.shops_id
WHERE c.`name` = "Murzik";

SELECT s.`shopname`
FROM `shops` AS s
RIGHT JOIN
(SELECT *
FROM `cats`
WHERE `name` = "Murzik") AS `cat_name`
ON s.id = cat_name.shops_id;


/*
Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”
*/

SELECT `shopname`
FROM `shops`
WHERE id NOT IN (
	SELECT `shops`.id
	FROM `shops` 
	JOIN `cats` 
	ON `shops`.id = `cats`.shops_id
	WHERE `cats`.`name` IN ("Murzik", "Zuza"));


SELECT s.`shopname`
FROM `shops` AS s
LEFT JOIN `cats` AS c 
ON s.id = c.shops_id AND c.name IN ("Murzik", "Zuza")
WHERE c.shops_id IS NULL;
