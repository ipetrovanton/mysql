drop TABLE if EXISTS staff, temp, employees, positions, salary, subordinates;
use workers;
CREATE TABLE IF NOT EXISTS employees (
	id INT not null AUTO_INCREMENT primary key,
    first_name VARCHAR(30) not null,
    last_name VARCHAR(30) not null
);
INSERT INTO employees(first_name, last_name) 
VALUES
('Ivan', 'Pupkin'),
('Ilya', 'Alekseev'),
('Vadim', 'Udalov'),
('Oleg', 'Tinkov'),
('Natalya', 'Udalova'),
('Igor', 'Perlman'),
('Maxim', 'Dudaev'),
('Gosha', 'Kucenko'),
('Galina', 'Ivanova'),
('Dmitry', 'Romanov'),
('Vasiliy', 'Temny'),
('Ivan', 'Grozny'),
('Snezhanna', 'Misko'),
('Ivan', 'Abramov');

create table IF NOT EXISTS positions (
	id int not null AUTO_INCREMENT PRIMARY key,
    position char(30) not null
);
insert into positions (position) 
values
('Boss'),
('Manager'),
('Coder'),
('Tester'),
('Cleaner');

create table IF not EXISTS salary(
	id int not null AUTO_INCREMENT PRIMARY key,
    salary INT not null
);
insert into salary (salary)
values
(25000),
(45000),
(60000),
(80000),
(100000);

CREATE TABLE IF not EXISTS staff(
	id int not null AUTO_INCREMENT PRIMARY KEY,
    first_name int not null,
    second_name int not null,
    position int not null,
    salary int not null,
    FOREIGN KEY (first_name) REFERENCES employees (id),
    FOREIGN KEY (second_name) REFERENCES employees (id),
    FOREIGN KEY (position) REFERENCES positions (id),
    FOREIGN KEY (salary) REFERENCES salary (id),
    UNIQUE(first_name, second_name)
);
INSERT staff(first_name, second_name, position, salary) VALUES
(1, 1, 1, 5),
(2, 2, 2, 4),
(3, 3, 2, 4),
(4, 4, 2, 4),
(5, 5, 3, 3),
(6, 6, 3, 3),
(7, 7, 3, 2),
(8, 8, 3, 3),
(9, 9, 4, 3),
(10, 10, 4, 2),
(11, 11, 4, 2),
(12, 12, 3, 2),
(13, 13, 5, 1),
(14, 14, 5, 1);

SELECT staff.id, employees.first_name, employees.last_name, positions.position, salary.salary
FROM staff
join employees on employees.id = staff.first_name
join positions on positions.id = staff.position
join salary on salary.id = staff.salary
ORDER BY staff.id;

CREATE TABLE if not EXISTS subordinates (
    id INT AUTO_INCREMENT PRIMARY key,
    boss INT not null,
    submissive int not null,
    FOREIGN KEY (boss) REFERENCES positions (id),
    FOREIGN KEY (submissive) REFERENCES positions (id)
);
INSERT into subordinates(boss, submissive) VALUES
(1,2),
(1,5),
(2,3),
(2,4),
(4,3),
(5,2),
(5,3),
(5,4);

select DISTINCT staff.position from staff WHERE staff.position > 3;


CREATE table if not exists temp(
	id int not null PRIMARY KEY,
    first_name int not null,
    second_name int not null,
    position int not null,
    salary int not null,
    FOREIGN KEY (first_name) REFERENCES employees (id),
    FOREIGN KEY (second_name) REFERENCES employees (id),
    FOREIGN KEY (position) REFERENCES positions (id),
    FOREIGN KEY (salary) REFERENCES salary (id),
    UNIQUE(first_name, second_name)
);

INSERT INTO `temp`
SELECT * 
from staff where staff.position in (
	select submissive from subordinates where boss in 
    (select position from staff where id = 1)
);

SELECT temp.id, employees.first_name, employees.last_name, positions.position, salary.salary
FROM temp
join employees on employees.id = temp.first_name
join positions on positions.id = temp.position
join salary on salary.id = temp.salary;
