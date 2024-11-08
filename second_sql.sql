-- 1 - topshiriq

DROP TABLE if EXISTS departments;
DROP TABLE if EXISTS employees;
DROP TABLE if EXISTS projects;
DROP TABLE if EXISTS tasks;

CREATE TABLE IF NOT EXISTS departments(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	location TEXT
);

INSERT INTO departments(name, location) VALUES
('Dasturlash', 'Ferghana'),
('Moliya', 'Tashkent'),
('Tibbiyot', 'Andijan');

CREATE TABLE IF NOT EXISTS employees(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	position TEXT,
	department_id INTEGER REFERENCES departments(id)
);

INSERT INTO employees(name, position, department_id) VALUES
('Toxir', 'Junior Developer', 1),
('Sobir', 'Head Manager', 2),
('Jalil', 'Head Doctor', 3);

CREATE TABLE IF NOT EXISTS projects(
	id SERIAL PRIMARY KEY,
	title TEXT,
	department_id INTEGER REFERENCES departments(id)
);

INSERT INTO projects(title, department_id) VALUES
('Creating telegram bot', 1),
('Spending money on poverty', 2),
('Curing patients', 3);


CREATE TABLE IF NOT EXISTS tasks(
	id SERIAL PRIMARY KEY,
	description TEXT,
	project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
	employee_id INTEGER REFERENCES employees(id) ON DELETE SET NULL
);

INSERT INTO tasks(description, project_id, employee_id) VALUES
('TG Bot is used for making online money transactions', 1, 1),
('You should make documents on the expenditure of money on poverty', 2, 2),
('Patient has head ache so you should give some medicine', 3, 3);

SELECT
	departments.name,
	departments.location,
	employees.name,
	employees.position,
	projects.title,
	tasks.description
FROM
	departments
JOIN 
	employees ON departments.id = employees.department_id
JOIN
	projects ON departments.id = projects.department_id
JOIN
	tasks ON tasks.project_id = projects.id AND tasks.employee_id = employees.id;

-- -------------------------------------------------------------------

-- 2 - topshiriq

ALTER TABLE employees
ADD COLUMN email TEXT DEFAULT 'example@gmail.com';

ALTER TABLE tasks
ALTER COLUMN description TYPE VARCHAR(255);

SELECT * FROM employees;
SELECT * FROM tasks;

-- --------------------------------------------------------------------

-- 3 - topshiriq

UPDATE employees SET position = 'Senior Developer' WHERE id = 1; 
SELECT * FROM employees;

UPDATE projects SET title = 'New Project Title' WHERE id = 2;
SELECT * FROM projects;

-- --------------------------------------------------------------------

-- 4 - topshiriq

-- avval tasksda o'chiramiz so'ng projects da o'chiramiz.

DELETE FROM tasks WHERE project_id = 3;
DELETE FROM projects WHERE id = 3;


-- yoki tasks da foreign key qilib projects ga ulangan qismida avtomatik o'chib ketishi uchun
-- ON DELETE CASCADE kodini qo'shib qo'yamiz.

DELETE FROM projects WHERE id = 3;

SELECT * FROM projects;
SELECT * FROM tasks;

-- 3 ta employee qo'shganim uchun 1 - iddagi employee ma'lumotlarini o'zgartirdim

DELETE FROM employees WHERE id = 1;

SELECT * FROM employees;
SELECT * FROM tasks;
