CREATE DATABASE IF NOT EXISTS staff;
USE staff;

CREATE TABLE IF NOT EXISTS positions(
pos_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
pos_name VARCHAR(10) NOT NULL
);
INSERT INTO positions VALUES(NULL, "clerk");
INSERT INTO positions VALUES(NULL, "programmer");
INSERT INTO positions VALUES(NULL, "teamlead");
INSERT INTO positions VALUES(NULL, "tester");
SELECT * FROM positions;

CREATE TABLE IF NOT EXISTS workers(
worker_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
worker_name VARCHAR(10) NOT NULL,
worker_surname VARCHAR(20) NOT NULL,
worker_position INT UNSIGNED NOT NULL,
worker_salary INT UNSIGNED NOT NULL,
FOREIGN KEY (worker_position) REFERENCES positions(pos_id)
);


INSERT INTO workers VALUE(NULL, "Сергей", "Иванов", 1, 25000);
INSERT INTO workers VALUE(NULL, "Мамай", "Мамонов", 3, 60000);
INSERT INTO workers VALUE(NULL, "Киса", "Воробьянинов", 4, 40000);
INSERT INTO workers VALUE(NULL, "Артур", "Добролюбов", 2, 45000);
INSERT INTO workers VALUE(NULL, "Анжела", "Доступая", 4, 50000);
INSERT INTO workers VALUE(NULL, "Валерий", "Неприятный", 1, 20000);

SELECT * FROM workers WHERE worker_salary < 30000 ORDER BY worker_salary;
SELECT workers.worker_name, workers.worker_surname, positions.pos_name
	FROM workers INNER JOIN positions
    WHERE (workers.worker_salary < 30000 AND positions.pos_name = "clerk");

CREATE TABLE IF NOT EXISTS subordination(
	head INT UNSIGNED NOT NULL,
    subordinate INT UNSIGNED NOT NULL,
    PRIMARY KEY (head, subordinate),
    FOREIGN KEY (head) REFERENCES workers (worker_id),
    FOREIGN KEY (subordinate) REFERENCES workers (worker_id)
);

SELECT * FROM workers;

INSERT INTO subordination VALUES (2, 3);
INSERT INTO subordination VALUES (2, 4);
INSERT INTO subordination VALUES (2, 5);
INSERT INTO subordination VALUES (2, 6);
INSERT INTO subordination VALUES (4, 1);
INSERT INTO subordination VALUES (4, 6);

SELECT workers.worker_name, workers.worker_surname, workers.worker_position
	FROM workers LEFT JOIN subordination
    ON subordination.head = 2 WHERE subordination.subordinate = workers.worker_id;







