#Создадим новую базу данных и подключимся к ней.
CREATE DATABASE study;
USE study;


#Создадим новую таблицу в БД.
CREATE TABLE smartphones_200623
(id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(30) NOT NULL,
manufacturer VARCHAR(30) NOT NULL,
product_count INT NOT NULL,
price INT NOT NULL);


#Заполним созданную ранее таблицу в БД.
INSERT INTO smartphones_200623(product_name, manufacturer, product_count, price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);


#Провека корректности заполнения таблицы smartphones
SELECT * FROM smartphones_200623;


#Выведите название, производителя и цену для товаров, количество которых превышает 2 
SELECT product_name, manufacturer, price
FROM smartphones_200623
WHERE product_count > 2;


#Выведите весь ассортимент товаров марки “Samsung”
#V1 - считаем "ассортиментом" только названия товаров указанной марки
SELECT product_name
FROM smartphones_200623
WHERE manufacturer = 'Samsung';

#V2 - выводим всю информацию о товарах указанной марки
SELECT *
FROM smartphones_200623
WHERE manufacturer = 'Samsung';


#Товары, в которых есть упоминание "Iphone". Выводим все столбцы из таблицы
SELECT *
FROM smartphones_200623
WHERE product_name LIKE '%iPhone%';

/* Товары, в которых есть ЦИФРА "8". Так как не указано, в каком столбце должна содержаться 
цифра 8, считаем, что речь идет про название товара.
Выводим все столбцы из таблицы. 
*/
SELECT *
FROM smartphones_200623
WHERE product_name LIKE '%8%';