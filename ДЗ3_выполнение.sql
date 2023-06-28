USE study;

-- Создание и заполнение таблицы для работы
CREATE TABLE IF NOT EXISTS `staff_28062023`
(`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(45) NOT NULL,
`lastname` VARCHAR(45) NOT NULL,
`post` VARCHAR(45) NOT NULL,
`seniority` INT NOT NULL,
`salary` INT NOT NULL,
`age` INT NOT NULL);

INSERT INTO `staff_28062023` (`firstname`, `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
('Вася', 'Васькин', 'Начальник', 40, 100000, 60), 
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

/* 
Задание 1: 
Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания 
*/

SELECT * FROM `staff_28062023`
ORDER BY `salary` DESC;

SELECT * FROM `staff_28062023`
ORDER BY `salary`;

/* 
Задание 2: 
Выведите 5 максимальных заработных плат (salary)
*/

SELECT * FROM `staff_28062023`
ORDER BY `salary` DESC
LIMIT 5;

/* 
Задание 3: 
Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
*/
 
 SELECT `post`,
 SUM(`salary`) AS `sum_salary`
 FROM `staff_28062023`
 GROUP BY `post`;

/* 
Задание 4: 
Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
*/

SELECT COUNT(id) AS `Количество сотрудников`
FROM `staff_28062023`
WHERE `age` BETWEEN 24 AND 49 AND `post` = 'Рабочий';

/* 
Задание 5: 
Найдите количество специальностей
*/

SELECT COUNT(DISTINCT `post`) AS `Количество специальностей`
FROM `staff_28062023`;

/* 
Задание 6: 
Выведите специальности, у которых средний возраст сотрудников меньше 30 лет включительно
*/

SELECT `post` 
FROM `staff_28062023`
GROUP BY `post`
HAVING AVG(`age`) <= 30;