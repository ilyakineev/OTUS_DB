# Лекция #2

## Компоненты современной СУБД

## Цели занятия

* Использовать в работе компоненты и возможности СУБД;
* Проектировать и создавать индексы;
* Устанавливать ограничения на поля и целые таблицы;

## Пользователи и роли в PostgreSQL

В PostgreSQL пользователи и роли играют важную роль в управлении доступом к базам данных и выполнении операций.
PostgreSQL предоставляет гибкую систему аутентификации и авторизации через пользователей и роли. Вот основные аспекты:

### Пользователи (Users):

1. Создание пользователя:
   Новый пользователь создается с использованием команды CREATE USER.

`CREATE USER username WITH PASSWORD 'password';`

2. Аутентификация:
   Пользователь может быть аутентифицирован с использованием пароля, сертификата, или других методов в зависимости от
   настроек безопасности.
3. Изменение пароля:
   Пароль пользователя может быть изменен с помощью команды ALTER USER.

`ALTER USER username WITH PASSWORD 'newpassword';`

4. Удаление пользователя:
   Удаление пользователя выполняется командой DROP USER.

`DROP USER username;`

### Роли (Roles):

1. Создание роли:
   Роли представляют собой обобщение пользователей и групп пользователей. Создание роли выполняется с использованием
   команды CREATE ROLE.

`CREATE ROLE rolename;`

2. Назначение привилегий:
   Ролям можно назначать различные привилегии на объекты базы данных (таблицы, представления, схемы и т.д.).

`GRANT SELECT ON TABLE tablename TO rolename;`

3. Назначение ролей пользователям:
   Роли могут быть присвоены пользователям. Пользователи, являющиеся членами роли, наследуют её привилегии.

`GRANT rolename TO username;`

4. Назначение ролей другим ролям:
   Роли могут также быть назначены другим ролям, что позволяет создавать иерархию ролей.

`GRANT subrole TO parentrole;`

5. Изменение роли:
   Роли могут быть изменены с использованием команды ALTER ROLE.

`ALTER ROLE rolename WITH LOGIN;`

6. Удаление роли:
   Удаление роли выполняется командой DROP ROLE.

`DROP ROLE rolename;`

#### Примеры использования:

1. Создание пользователя и назначение ролей:

`CREATE USER alice WITH PASSWORD 'password';
CREATE ROLE sales;
GRANT sales TO alice;`

2. Создание роли с привилегиями:

`CREATE ROLE analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analyst;`

3. Назначение ролей пользователям:

`GRANT analyst TO bob;`

4. Изменение привилегий:

`REVOKE SELECT ON TABLE sensitive_table FROM analyst;
GRANT INSERT, UPDATE ON TABLE sensitive_table TO analyst;`

5. Создание иерархии ролей:

`CREATE ROLE manager;
GRANT sales TO manager;`

В PostgreSQL управление пользователями и ролями предоставляет множество возможностей для тщательной настройки
безопасности и управления доступом к данным. С помощью ролей можно организовать гибкую и эффективную систему управления
пользователями и их привилегиями.

## Схемы в PostgreSQL

В PostgreSQL, схемы представляют собой способ организации объектов базы данных и их пространств имен. Схемы позволяют
логически группировать объекты базы данных, такие как таблицы, представления, индексы и т.д., что упрощает управление и
структурирование базы данных. Вот основные аспекты использования схем в PostgreSQL:

1. Создание схемы:
   Схема создается с использованием команды CREATE SCHEMA.

`CREATE SCHEMA schema_name;`

2. Создание объектов в схеме:
   При создании объекта, такого как таблицы, можно указать схему, в которой он должен быть размещен.

`CREATE TABLE schema_name.table_name (...);`

3. Выбор схемы по умолчанию:
   Для удобства, можно установить схему по умолчанию для текущего сеанса, используя команду SET search_path.

`SET search_path TO schema_name;`

4. Просмотр схем:
   Информацию о схемах можно получить из системной таблицы pg_namespace.

`SELECT * FROM pg_namespace;`

5. Использование объектов в схеме:
   Обращение к объектам в схеме выполняется с использованием синтаксиса <schema_name>.<object_name>.

`SELECT * FROM schema_name.table_name;`

6. Перемещение объектов между схемами:
   Объекты могут быть перемещены из одной схемы в другую с использованием команды ALTER TABLE.

`ALTER TABLE schema1.table_name SET SCHEMA schema2;`

### Пример использования схем:

1. Создание схемы:

`CREATE SCHEMA sales;`

2. Создание таблицы в схеме:

`CREATE TABLE sales.orders (
order_id serial PRIMARY KEY,
customer_name VARCHAR(100),
order_date DATE
);`

3. Установка схемы по умолчанию для сеанса:

`SET search_path TO sales;`

4. Добавление данных в таблицу в текущей схеме:

`INSERT INTO orders (customer_name, order_date) VALUES ('Alice', '2023-01-01');`

5. Выбор данных из таблицы в текущей схеме:

`SELECT * FROM orders;`

6. Перемещение таблицы в другую схему:

`ALTER TABLE sales.orders SET SCHEMA archive;`

7. Выбор данных из таблицы в новой схеме:

`SELECT * FROM archive.orders;`

С использованием схем в PostgreSQL можно эффективно организовывать и структурировать объекты базы данных, что облегчает
управление и поддержку системы. Схемы также полезны при работе с несколькими пользователями, поскольку позволяют им
создавать объекты в собственных пространствах имен без конфликтов с объектами других пользователей.

## Индексы в PostgreSQL

Индексы в PostgreSQL являются мощным механизмом для оптимизации производительности запросов к базе данных. Индексы
представляют собой структуры данных, создаваемые на основе значений в одном или нескольких столбцах таблицы, чтобы
ускорить операции поиска и сортировки. Вот основные аспекты использования индексов в PostgreSQL:

1. Создание индекса:
   Индекс создается с использованием команды CREATE INDEX.

`CREATE INDEX index_name ON table_name (column1, column2, ...);`

2. Типы индексов:
   PostgreSQL поддерживает различные типы индексов, включая B-дерево (по умолчанию), хеш-индексы, GIN (Generalized
   Inverted Index), GiST (Generalized Search Tree), SP-GiST (Space-Partitioned Generalized Search Tree), и другие.
3. Выбор столбцов для индексации:
   Обычно индексы создаются на столбцах, которые часто используются в условиях WHERE, JOIN и ORDER BY. Однако, создание
   слишком многих индексов может снизить производительность при вставке и обновлении данных.
4. Уникальные индексы:
   Индексы могут быть уникальными, что гарантирует уникальность значений в индексируемых столбцах.

`CREATE UNIQUE INDEX index_name ON table_name (column1, column2, ...);`

5. Индексация текстовых данных:
   Для текстовых данных можно использовать индексы с поддержкой поиска по шаблонам (например, GIN или GiST) для
   улучшения производительности операций поиска с использованием операторов LIKE или полнотекстового поиска.
6. Удаление индекса:
   Индекс можно удалить с использованием команды DROP INDEX.

`DROP INDEX index_name;`

7. Автоматическое создание индексов:
   PostgreSQL может автоматически создавать некоторые индексы, например, для поддержки уникальности первичных ключей.
8. План выполнения запроса (Query Execution Plan):
   PostgreSQL использует план выполнения запроса для выбора наилучшего способа выполнения запроса, который может
   включать использование индексов.

### Примеры использования:

1. Создание индекса на столбце:

`CREATE INDEX idx_customer_name ON orders (customer_name);`

2. Создание уникального индекса:

CREATE UNIQUE INDEX idx_email ON users (email);

3. Создание индекса с использованием более чем одного столбца:

`CREATE INDEX idx_last_name_first_name ON employees (last_name, first_name);`

4. Удаление индекса:

`DROP INDEX idx_customer_name;`

Индексы в PostgreSQL существенно улучшают производительность запросов, особенно при работе с большими объемами данных.
Однако, при использовании индексов, важно соблюдать баланс между производительностью запросов и издержками на обновление
данных, так как индексы также влияют на операции вставки, обновления и удаления.

## Ограничения в PostgreSQL

Ограничения в PostgreSQL представляют собой правила, определенные на уровне таблицы, которые ограничивают типы данных,
значения и отношения между данными в таблице. Ограничения играют важную роль в обеспечении целостности данных и
предотвращении ошибок ввода. Вот основные виды ограничений в PostgreSQL:

1. Ограничение уникальности (UNIQUE Constraint):
   Гарантирует уникальность значений в указанных столбцах.

`CREATE TABLE example (
column1 INT,
column2 VARCHAR(50),
UNIQUE (column1, column2)
);`

2. Ограничение первичного ключа (Primary Key Constraint):
   Определяет столбец или группу столбцов, которые уникальны для каждой строки в таблице.

`CREATE TABLE example (
id SERIAL PRIMARY KEY,
name VARCHAR(50)
);`

3. Ограничение внешнего ключа (Foreign Key Constraint):
   Связывает значения в одной таблице с значениями в другой таблице, обеспечивая ссылочную целостность.

`CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id),
order_date DATE
);`

4. Ограничение CHECK (CHECK Constraint):
   Определяет условие, которое значения в столбце должны соответствовать.

`CREATE TABLE employees (
employee_id SERIAL PRIMARY KEY,
salary INT CHECK (salary > 0),
hire_date DATE CHECK (hire_date >= '2000-01-01')
);`

5. Ограничение NOT NULL:
   Гарантирует, что значения в указанных столбцах не могут быть NULL.

`CREATE TABLE example (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);`

6. Ограничение уникальности для внешнего ключа (Unique Foreign Key Constraint):
   Ограничивает значения в столбце, связанном с внешним ключом, чтобы они были уникальными.

`CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
UNIQUE (customer_id)
);`

`CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
name VARCHAR(50)
);`

7. Ограничение чека для внешнего ключа (Check Foreign Key Constraint):
   Определяет дополнительное условие для внешнего ключа.

`CREATE TABLE employees (
employee_id SERIAL PRIMARY KEY,
manager_id INT,
CONSTRAINT check_manager CHECK (manager_id <> employee_id),
FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);`

### Примеры использования:

1. Ограничение уникальности:

`CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(50) UNIQUE,
price DECIMAL(10, 2)
);`

2. Ограничение первичного ключа:

`CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(50)
);`

3. Ограничение внешнего ключа:

`CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id),
order_date DATE
);`

4. Ограничение CHECK:

`CREATE TABLE employees (
employee_id SERIAL PRIMARY KEY,
salary INT CHECK (salary > 0),
hire_date DATE CHECK (hire_date >= '2000-01-01')
);`

5. Ограничение NOT NULL:

`CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(50) NOT NULL
);`

Ограничения в PostgreSQL обеспечивают целостность данных и помогают предотвращать ошибки и некорректные данные в базе
данных. Хорошо определенные ограничения способствуют надежности и стабильности базы данных.

## Триггеры и хранимые процедуры в PostgreSQL

Триггеры и хранимые процедуры в PostgreSQL представляют собой мощные инструменты для определения бизнес-логики на уровне
базы данных. Они могут использоваться для автоматизации дополнительных действий при вставке, обновлении или удалении
данных, а также для создания переиспользуемых блоков логики, хранящихся в базе данных. Вот основные аспекты
использования триггеров и хранимых процедур в PostgreSQL:

### Триггеры (Triggers):

1. Создание триггера:
   Триггер создается с использованием команды CREATE TRIGGER.

`CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
EXECUTE FUNCTION trigger_function();`

2. Типы триггеров:

* BEFORE: Действие триггера выполняется перед выполнением операции (например, вставки, обновления).
* AFTER: Действие триггера выполняется после выполнения операции.
* INSTEAD OF: Заменяет выполнение операции своим собственным действием.

3. События триггера:

Триггеры могут быть связаны с различными событиями, такими как INSERT, UPDATE, DELETE, или комбинацией этих событий.

4. Триггерные функции:

Триггерные функции содержат логику, которая будет выполнена при срабатывании триггера.

5. Переменные в триггере:

В триггере можно использовать переменные, предоставляющие доступ к значениям, связанным с операцией.

### Пример триггера:

`CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
total_amount DECIMAL(10, 2),
discount DECIMAL(5, 2),
final_amount DECIMAL(10, 2)
);`

`CREATE OR REPLACE FUNCTION calculate_final_amount()
RETURNS TRIGGER AS $$
BEGIN
NEW.final_amount := NEW.total_amount - NEW.discount;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;`

`CREATE TRIGGER calculate_final_amount_trigger
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_final_amount();`

В данном примере триггер calculate_final_amount_trigger срабатывает перед операциями вставки или обновления в таблице
orders. Триггер вызывает функцию calculate_final_amount(), которая вычисляет значение final_amount на основе
total_amount и discount.

### Хранимые процедуры (Stored Procedures):

1. Создание хранимой процедуры:

Хранимая процедура создается с использованием команды CREATE PROCEDURE.

`CREATE OR REPLACE PROCEDURE procedure_name(parameter1 type, parameter2 type)
LANGUAGE plpgsql
AS $$
-- Тело процедуры
BEGIN
-- Логика процедуры
END;
$$;`

2. Параметры процедуры:

Хранимая процедура может принимать параметры, которые используются внутри тела процедуры.

3. Использование процедуры:

Процедуры могут быть вызваны из SQL-запроса или из других процедур и триггеров.

CALL procedure_name(parameter1_value, parameter2_value);

4. OUT-параметры:

Процедура может иметь OUT-параметры, через которые возвращаются значения.

`CREATE OR REPLACE PROCEDURE get_employee_name(employee_id INT, OUT name VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
SELECT employee_name INTO name FROM employees WHERE id = employee_id;
END;
$$;`

### Пример хранимой процедуры:

`CREATE OR REPLACE PROCEDURE update_order_status(order_id INT, new_status VARCHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE orders SET status = new_status WHERE order_id = order_id;
END;
$$;`

В данном примере создается хранимая процедура update_order_status, которая принимает order_id и новый статус new_status,
и обновляет соответствующую запись в таблице orders.

Использование триггеров и хранимых процедур в PostgreSQL может значительно упростить управление бизнес-логикой на уровне
базы данных, сделать код более переиспользуемым и обеспечить более высокую степень абстракции при работе с данными.

## Последовательность и очереди PostgreSQL

В PostgreSQL, последовательность (sequence) и очередь (queue) - это два разных концепта.

### Последовательность (Sequence):

Последовательность - это объект базы данных, предназначенный для генерации уникальных чисел. Обычно они используются для
создания автоинкрементных столбцов в таблицах. Вот основные характеристики последовательности:

1. Создание последовательности:

CREATE SEQUENCE sequence_name START WITH 1 INCREMENT BY 1;
Использование в таблице:

`CREATE TABLE example (
id INT DEFAULT nextval('sequence_name'),
name VARCHAR(50)
);`

Получение следующего значения:

`SELECT nextval('sequence_name');`

2. Спецификация значений:

Можно указать начальное значение (START WITH), шаг инкремента (INCREMENT BY), максимальное и минимальное значения и
другие параметры.
Очередь (Queue):
Очередь - это абстрактная структура данных, которая хранит элементы в определенном порядке и предоставляет возможности
для добавления и извлечения элементов. В PostgreSQL, создание очереди обычно выполняется с использованием таблицы, в
которой хранятся элементы, и соответствующих операций добавления и извлечения. Пример простой очереди:

`CREATE TABLE queue (
id SERIAL PRIMARY KEY,
data VARCHAR(255)
);`

-- Добавление элемента в очередь
`INSERT INTO queue (data) VALUES ('element1');`

-- Извлечение элемента из очереди
`DELETE FROM queue WHERE id = (SELECT min(id) FROM queue) RETURNING data;`

Очереди в PostgreSQL могут быть реализованы различными способами в зависимости от конкретных требований приложения.
Обычно, они используются для обработки задач в асинхронном режиме, например, для реализации систем обработки сообщений (
message queues) или асинхронных задач.

Обратите внимание, что в контексте PostgreSQL обычно используются обычные таблицы и последовательности для реализации
подобных задач, а сам термин "очередь" может относиться к концепции управления заданиями или сообщениями в системе.

## Представления в PostgreSQL

Представление (View) в PostgreSQL представляет собой виртуальную таблицу, основанную на результатах выполнения запроса к
одной или нескольким таблицам в базе данных. Представление не хранит собственных данных, а предоставляет удобный
интерфейс для просмотра и обработки данных, сформированных на основе одного или нескольких запросов. Вот основные
аспекты использования представлений в PostgreSQL:

1. Создание представления:
   Представление создается с использованием команды CREATE VIEW:

`CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table1
WHERE condition;`

Пример:

`CREATE VIEW active_customers AS
SELECT customer_id, customer_name
FROM customers
WHERE status = 'active';`

2. Использование представления:
   После создания представления, вы можете использовать его в SQL-запросах так, как если бы это была обычная таблица:

`SELECT * FROM active_customers;`

3. Обновление представления:
   Представление можно обновить с использованием команды CREATE OR REPLACE VIEW:

`CREATE OR REPLACE VIEW active_customers AS
SELECT customer_id, customer_name
FROM customers
WHERE status = 'active' AND total_purchases > 1000;`

4. Удаление представления:

`DROP VIEW view_name;`

5. Преимущества представлений:

* Упрощение запросов: Представления позволяют абстрагироваться от сложных SQL-запросов и предоставляют простой интерфейс
  для конечных пользователей.
* Безопасность: Представления могут использоваться для ограничения доступа к определенным данным, позволяя пользователям
  видеть только необходимую информацию.
* Повторное использование логики: Представления могут использоваться для повторного использования часто используемых
  запросов, что способствует поддерживаемости и ясности кода.

6. Пример использования представления:
   Предположим, у вас есть таблица с заказами и вам часто нужно видеть только активные заказы с определенными
   параметрами:

`CREATE VIEW active_orders AS
SELECT order_id, order_date, total_amount
FROM orders
WHERE status = 'active' AND total_amount > 100;`

Теперь вы можете просто использовать это представление в ваших запросах:

`SELECT * FROM active_orders;`

Представления в PostgreSQL предоставляют механизм для упрощения работы с данными, а также повышают безопасность и
удобство использования при работе с базой данных.