USE study;

#Задание 1 Используя операторы языка SQL, создайте таблицу “sales”. Заполните ее данными.
CREATE TABLE sales_23062023
(id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL DEFAULT 0
);

INSERT INTO sales_23062023(order_date, count_product)
VALUES
(DATE('2022-01-01'), 156),
(DATE('2022-01-02'), 180),
(DATE('2022-01-03'), 21),
(DATE('2022-01-04'), 124),
(DATE('2022-01-05'), 341);


/*
Задание 2
Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва: 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/
SELECT id,
	CASE
		WHEN count_product < 100 THEN 'Маленький заказ'
		WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
		ELSE 'Большой заказ'
	END AS 'Тип заказа'
FROM sales_23062023;

SELECT id,
IF(count_product < 100, 'Маленький заказ',
	IF(count_product BETWEEN 100 AND 300, 'Средний заказ', 'Большой заказ'))
AS 'Тип заказа'
FROM sales_23062023;


#3.1 Создайте таблицу “orders”, заполните ее значениями
CREATE TABLE orders_23062023
(id INT PRIMARY KEY AUTO_INCREMENT,
employee_id VARCHAR(4) NOT NULL UNIQUE,
amount DECIMAL(4,2) NOT NULL,
order_status VARCHAR(10) NOT NULL
);

-- Тренировка применения модификации типа данных в столбце таблицы.
ALTER TABLE orders_23062023
MODIFY COLUMN amount DECIMAL(5,2);

INSERT INTO orders_23062023(employee_id, amount, order_status)
VALUES
('e03', 15, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');


/*
3.2 Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/
SELECT *,
	CASE
		WHEN order_status = 'OPEN' THEN 'Order is in open state'
		WHEN order_status = 'CLOSED' THEN 'Order is closed'
		ELSE 'Order is cancelled'
	END AS 'full_order_status'
FROM orders_23062023;

SELECT *,
IF(order_status = 'OPEN', 'Order is in open state',
	IF(order_status = 'CLOSED', 'Order is closed', 'Order is cancelled'))
AS 'full_order_status'
FROM orders_23062023;


#4. Чем 0 отличается от NULL?
/*
0 (ноль) является конкретным числовым значением и представляет ноль или отсутствие значения. 
NULL (пустое значение) обозначает отсутствие значения или неопределенное значение.
*/


#Команды в помощь
SELECT * FROM orders_23062023;
SELECT * FROM sales_23062023;
TRUNCATE orders_23062023;
DROP TABLE orders_23062023;

