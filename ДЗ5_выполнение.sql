USE study;

CREATE TABLE IF NOT EXISTS cars
(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(45),
cost INT
);

INSERT cars
VALUES
(1, "Audi", 52642),
(2, "Mercedes", 57127 ),
(3, "Skoda", 9000 ),
(4, "Volvo", 29000),
(5, "Bentley", 350000),
(6, "Citroen ", 21000 ), 
(7, "Hummer", 41400), 
(8, "Volkswagen ", 21600);
    
SELECT * FROM cars;

/*
1. Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

Примечание: будем считать "до" как невключительно
*/

CREATE OR REPLACE VIEW cars_view AS
SELECT *
FROM cars
WHERE cost < 25000;

SELECT * FROM cars_view;


/*
2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

Примечание: будем считать "до" как невключительно
*/

ALTER VIEW cars_view AS
SELECT *
FROM cars
WHERE cost < 30000;

/*
3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
*/

CREATE OR REPLACE VIEW cars_view_2 AS
SELECT *
FROM cars
WHERE name IN ("Audi", "Skoda");

SELECT * FROM cars_view_2;

/*
4* Получить ранжированный список автомобилей по цене в порядке возрастания.
*/

SELECT *,
DENSE_RANK() OVER (ORDER BY cost) AS `rank`
FROM cars;

/*
5* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
*/

SELECT *,
SUM(cost) OVER() AS `sum`
FROM(
SELECT *,
DENSE_RANK() OVER (ORDER BY cost DESC) AS `rank`
FROM cars
) AS `rank_cost_ASC_table`
WHERE `rank` <=3;

/*
6* Получить список автомобилей, у которых цена больше предыдущей цены 

Примечание: в данном случае из задания не совсем понятно, что значит "предыдущей цены", поэтому считаем, что "больше цены предыдущей в таблице машины".
*/

# Таблица для проверки
SELECT *,
LAG(cost) OVER() AS `lag`
FROM cars;

# Итог выполнения задания
SELECT *
FROM(
SELECT *,
LAG(cost) OVER() AS `lag`
FROM cars) AS `lag_table`
WHERE `lag` IS NOT NULL AND `cost` > `lag`;

/*
7* Получить список автомобилей, у которых цена меньше следующей цены 

Примечание: в данном случае из задания не совсем понятно, что значит "следующей цены", поэтому считаем, что "меньше цены следующей в таблице машины".
*/

# Таблица для проверки
SELECT *,
LEAD(cost) OVER() AS `lead`
FROM cars;

# Итог выполнения задания
SELECT *
FROM(
SELECT *,
LEAD(cost) OVER() AS `lead`
FROM cars) AS `lead_table`
WHERE `lead` IS NOT NULL AND `cost` < `lead`;


/*
8* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля 
*/

#Вариант 1 через вью
CREATE VIEW cars_cost AS
SELECT *
FROM cars 
ORDER BY cost;

SELECT * 
FROM cars_cost;

SELECT *,
`cost` - `lead` AS `price_difference`
FROM(
SELECT *,
LEAD(cost) OVER() AS `lead`
FROM cars_cost) AS `lead_table`
WHERE `lead` IS NOT NULL
;

#Вариант 2 - 2 вложенных запроса (но первый ваариант видится лучше, т.к. прозрачнее)
SELECT *,
`cost` - `lead` AS `price_difference`
FROM(
SELECT *,
LEAD(cost) OVER() AS `lead`
FROM 
	(SELECT *
	FROM cars 
	ORDER BY cost) AS `order_table`
    ) AS `lead_table`
WHERE `lead` IS NOT NULL
;

