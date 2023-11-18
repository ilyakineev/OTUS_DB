# Лекция #9

## DML: вставка, обновление, удаление, выборка данных

## Цели занятия

* Создавать различные типы связей между таблицами;
* Добавлять и обновлять данные со сложными выборками;
* Удалять данные с подзапросами;

## SELECT в PostgreSQL

SELECT - это SQL-команда, используемая для извлечения данных из одной или нескольких таблиц в базе данных. В PostgreSQL
SELECT используется для выполнения запросов к базе данных и выборки данных.

Основной синтаксис команды SELECT выглядит следующим образом:

```sql 
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

Где:

column1, column2, ...: Список столбцов, которые вы хотите выбрать.
table_name: Имя таблицы, из которой вы хотите извлечь данные.
WHERE condition: Условие, которое определяет, какие строки из таблицы будут выбраны. Эта часть является необязательной.
Примеры использования:

1. Простой запрос на выборку всех данных из таблицы:

```sql
 SELECT * FROM employees;
 ```

Этот запрос выберет все столбцы из таблицы employees.

2. Выборка определенных столбцов:

```sql
 SELECT first_name, last_name FROM employees;
 ```

Этот запрос выберет только столбцы first_name и last_name из таблицы employees.

3. Использование условия WHERE:

```sql
 SELECT * FROM employees WHERE department = 'IT';
 ```

Этот запрос выберет все столбцы из таблицы employees, где значение в столбце department равно 'IT'.

4. Использование функций:

```sql
 SELECT AVG(salary) FROM employees;
 ```

Этот запрос вычислит среднюю зарплату (с использованием функции AVG) из таблицы employees.

5. Сортировка результатов:

```sql 
SELECT * FROM employees ORDER BY last_name ASC;
```

Этот запрос выберет все столбцы из таблицы employees и упорядочит результаты по столбцу last_name в порядке
возрастания (ASC).

6. Ограничение количества строк:

```sql 
SELECT * FROM employees LIMIT 10;
```

Этот запрос выберет только первые 10 строк из таблицы employees.

Это лишь базовые примеры использования команды SELECT в PostgreSQL. Она также поддерживает множество других
возможностей, таких как объединение таблиц, использование подзапросов, группировка данных и т. д.

## Различный варианты JOIN в PostgreSQL

В PostgreSQL, как и в других реляционных базах данных, существует несколько видов операторов `JOIN` для объединения
данных из различных таблиц. Они позволяют комбинировать строки из двух или более таблиц в зависимости от определенных
условий. Вот некоторые основные виды `JOIN`:

1. INNER JOIN:
    - `INNER JOIN` возвращает строки, для которых есть соответствующие значения в обеих таблицах.
    - Пример:

    ```sql
    SELECT orders.order_id, customers.customer_name
    FROM orders
    INNER JOIN customers ON orders.customer_id = customers.customer_id;
    ```

   В этом запросе мы выбираем `order_id` из таблицы `orders` и `customer_name` из таблицы `customers`, объединяя их по
   значению `customer_id`. Только те строки, где есть соответствие, будут включены в результат.

2. LEFT JOIN (или LEFT OUTER JOIN):
    - `LEFT JOIN` возвращает все строки из левой таблицы и соответствующие строки из правой таблицы. Если в правой
      таблице нет соответствия, то возвращается NULL.
    - Пример:

    ```sql
    SELECT employees.employee_id, employees.employee_name, departments.department_name
    FROM employees
    LEFT JOIN departments ON employees.department_id = departments.department_id;
    ```

   Этот запрос вернет все строки из таблицы `employees` и соответствующие строки из таблицы `departments`, но если
   соответствия нет, то значения из `departments` будут NULL.

3. RIGHT JOIN (или RIGHT OUTER JOIN):
    - `RIGHT JOIN` возвращает все строки из правой таблицы и соответствующие строки из левой таблицы. Если в левой
      таблице нет соответствия, то возвращается NULL.
    - Пример:

    ```sql
    SELECT employees.employee_id, employees.employee_name, departments.department_name
    FROM employees
    RIGHT JOIN departments ON employees.department_id = departments.department_id;
    ```

   Этот запрос вернет все строки из таблицы `departments` и соответствующие строки из таблицы `employees`, но если
   соответствия нет, то значения из `employees` будут NULL.

4. FULL JOIN (или FULL OUTER JOIN):
    - `FULL JOIN` возвращает все строки, где есть соответствие в левой или правой таблице. Если нет соответствия, то
      возвращаются NULL.
    - Пример:

    ```sql
    SELECT employees.employee_id, employees.employee_name, departments.department_name
    FROM employees
    FULL JOIN departments ON employees.department_id = departments.department_id;
    ```

   Этот запрос вернет все строки из обеих таблиц, соответствующие строки будут объединены, а если соответствия нет, то
   значения будут NULL.

Это основные виды `JOIN` в PostgreSQL. Они позволяют эффективно объединять данные из различных таблиц в соответствии с
определенными условиями.

## Условия WHERE в PostgreSQL

Условие `WHERE` в PostgreSQL используется для фильтрации строк в результирующем наборе, возвращаемом запросом `SELECT`.
Это позволяет выбирать только те строки, которые соответствуют определенным критериям. Вот несколько примеров
использования условия `WHERE`:

1. **Простой пример:**

   ```sql
   SELECT * FROM employees
   WHERE department_id = 1;
   ```

   В этом запросе будут выбраны все строки из таблицы `employees`, где значение столбца `department_id` равно 1.

2. **Использование операторов сравнения:**

   ```sql
   SELECT * FROM products
   WHERE price > 100;
   ```

   Этот запрос выберет все продукты с ценой выше 100.

3. **Использование логических операторов:**

   ```sql
   SELECT * FROM orders
   WHERE order_date >= '2023-01-01' AND order_date < '2024-01-01';
   ```

   В этом запросе будут выбраны все заказы, сделанные в течение 2023 года.

4. **Использование оператора `IN`:**

   ```sql
   SELECT * FROM customers
   WHERE country IN ('USA', 'Canada', 'Mexico');
   ```

   Этот запрос вернет все строки из таблицы `customers`, где значение столбца `country` находится в списке ('USA', '
   Canada', 'Mexico').

5. **Использование оператора `LIKE` для поиска по шаблону:**

   ```sql
   SELECT * FROM employees
   WHERE last_name LIKE 'Smith%';
   ```

   Этот запрос выберет все строки из таблицы `employees`, где значение столбца `last_name` начинается с "Smith".

6. **Использование оператора `BETWEEN`:**

   ```sql
   SELECT * FROM orders
   WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';
   ```

   Этот запрос вернет все заказы, сделанные в течение 2023 года, включая даты 1 января и 31 декабря.

Условие `WHERE` может также комбинироваться с различными операторами, функциями и подзапросами для создания более
сложных и гибких запросов в зависимости от конкретных требований вашего приложения.