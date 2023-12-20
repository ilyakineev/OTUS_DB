# Лекция #12

## DML: агрегация и сортировка, CTE, аналитические функции

## Цели занятия

* Группировать и сортировать данные и использовать групповые функции.

## Синтаксис GROUP BY:

`GROUP BY` в PostgreSQL используется для группировки строк по значениям в одном или нескольких столбцах. Это позволяет
вам выполнять агрегирующие функции, такие как COUNT, SUM, AVG, MAX, MIN и другие, над данными в каждой группе. Вот
пример синтаксиса `GROUP BY` в PostgreSQL:

```sql
SELECT column1, column2, aggregate_function(column3)
FROM table
GROUP BY column1, column2;
```

Где:

- `column1`, `column2`: Столбцы, по которым вы хотите сгруппировать данные.
- `aggregate_function(column3)`: Агрегирующая функция, которую вы хотите применить к столбцу `column3` внутри каждой
  группы.
- `table`: Таблица, из которой вы выбираете данные.

Пример:

Предположим, у вас есть таблица `orders` с колонками `customer_id`, `product_id` и `quantity`. Если вы хотите узнать
общее количество продуктов, заказанных каждым клиентом, вы можете использовать `GROUP BY` следующим образом:

```sql
SELECT customer_id, SUM(quantity) as total_quantity
FROM orders
GROUP BY customer_id;
```

Этот запрос сгруппирует заказы по `customer_id` и подсчитает сумму количества (`quantity`) для каждого клиента.

Важные моменты:

1. Столбцы в выборке должны быть либо в списке `GROUP BY`, либо аргументами агрегирующих функций. В примере
   выше `customer_id` находится и в `GROUP BY`, и в списке выборки.

2. Вы можете группировать по нескольким столбцам, указав их через запятую в списке `GROUP BY`.

3. Если вы используете агрегирующие функции, но не указали `GROUP BY`, то все строки будут рассматриваться как одна
   группа.

4. Порядок столбцов в списке `GROUP BY` важен. Результаты будут сгруппированы в соответствии с порядком, в котором
   столбцы перечислены в списке.

Это общий синтаксис `GROUP BY` в PostgreSQL, который позволяет вам эффективно анализировать данные, сгруппированные по
определенным критериям.

## ROLLUP

В PostgreSQL оператор `ROLLUP` используется для создания итоговых строк, представляющих общие итоги для групп данных, а
также итогов для частичных подгрупп данных. Оператор `ROLLUP` может быть полезен, когда вам нужно вычислить
агрегированные значения не только для каждой группы, но и для их комбинаций.

Вот базовый синтаксис использования `ROLLUP` в PostgreSQL:

```sql
SELECT column1, column2, aggregate_function(column3)
FROM table
GROUP BY ROLLUP (column1, column2);
```

Где:

- `column1`, `column2`: Столбцы, по которым вы хотите сгруппировать данные.
- `aggregate_function(column3)`: Агрегирующая функция, которую вы хотите применить к столбцу `column3` внутри каждой
  группы.
- `table`: Таблица, из которой вы выбираете данные.

Пример:

Предположим, у вас есть таблица `sales` с колонками `region`, `quarter` и `revenue`. Если вы хотите получить общий доход
для каждого квартала и общий доход для каждого региона, а также общий доход без разбиения по регионам и кварталам, вы
можете использовать `ROLLUP` следующим образом:

```sql
SELECT region, quarter, SUM(revenue) as total_revenue
FROM sales
GROUP BY ROLLUP (region, quarter);
```

Этот запрос создаст общий итог для каждого региона, каждого квартала и общий итог для всей таблицы. Результаты будут
включать строки с NULL в столбцах `region` и/или `quarter`, представляя общие итоги.

Важные моменты:

1. `ROLLUP` генерирует итоги в порядке, определенном в списке `GROUP BY`. В данном случае, итоги будут созданы сначала
   для `region`, затем для `quarter`, и, наконец, для общего итога без разбиения.

2. Вы можете использовать функции агрегации, такие как `SUM`, `AVG`, `COUNT` и другие, в сочетании с `ROLLUP` для
   вычисления агрегированных значений.

3. `ROLLUP` можно применять к нескольким столбцам в списке `GROUP BY`, что создаст множество уровней итогов.

Используя `ROLLUP`, вы можете легко анализировать итоговые значения для различных уровней группировки в ваших данных в
PostgreSQL.

## CUBE;

В PostgreSQL оператор `CUBE` используется для создания итоговых строк, представляющих общие итоги для всех возможных
комбинаций групп данных. Это предоставляет более полный обзор данных, чем `ROLLUP`, так как `CUBE` включает в себя все
возможные комбинации группировки, в то время как `ROLLUP` создает итоги только для иерархических уровней.

Вот базовый синтаксис использования `CUBE` в PostgreSQL:

```sql
SELECT column1, column2, aggregate_function(column3)
FROM table
GROUP BY CUBE (column1, column2);
```

Где:

- `column1`, `column2`: Столбцы, по которым вы хотите сгруппировать данные.
- `aggregate_function(column3)`: Агрегирующая функция, которую вы хотите применить к столбцу `column3` внутри каждой
  группы.
- `table`: Таблица, из которой вы выбираете данные.

Пример:

Предположим, у вас есть таблица `sales` с колонками `region`, `quarter` и `revenue`. Если вы хотите получить общий доход
для каждого квартала, для каждого региона и для всех возможных комбинаций регионов и кварталов, вы можете
использовать `CUBE` следующим образом:

```sql
SELECT region, quarter, SUM(revenue) as total_revenue
FROM sales
GROUP BY CUBE (region, quarter);
```

Этот запрос создаст общий итог для каждого региона, каждого квартала и для всех возможных комбинаций регионов и
кварталов. Результаты будут включать строки с NULL в столбцах `region` и/или `quarter`, представляя общие итоги.

Важные моменты:

1. `CUBE` создает все возможные комбинации группировки, что может привести к значительному увеличению числа строк в
   результирующем наборе данных.

2. Подобно `ROLLUP`, `CUBE` также генерирует итоги в порядке, определенном в списке `GROUP BY`.

3. Вы можете использовать функции агрегации, такие как `SUM`, `AVG`, `COUNT` и другие, в сочетании с `CUBE` для
   вычисления агрегированных значений.

4. `CUBE` можно применять к нескольким столбцам в списке `GROUP BY`, что создаст все возможные комбинации для указанных
   столбцов.

Используя `CUBE`, вы можете получить более обширную картину данных, включая все возможные комбинации группировки, что
может быть полезным в анализе данных в PostgreSQL.

## GROUPING;

`GROUPING` - это функция в PostgreSQL, которая используется для определения, было ли значение возвращено в
результирующем наборе данных как часть операции группировки с использованием `GROUP BY`, `ROLLUP` или `CUBE`.
Функция `GROUPING` возвращает 1, если значение представляет итоговую (агрегированную) строку по соответствующему столбцу
группировки, и 0 в противном случае.

Вот пример использования `GROUPING`:

```sql
SELECT
  region,
  quarter,
  GROUPING(region) AS grouping_region,
  GROUPING(quarter) AS grouping_quarter,
  SUM(revenue) AS total_revenue
FROM sales
GROUP BY ROLLUP (region, quarter);
```

В этом запросе используется `ROLLUP` для создания итогов по регионам и кварталам. `GROUPING(region)`
и `GROUPING(quarter)` возвращают 1, если соответствующее значение в текущей строке является общим итогом, и 0, если это
значение не входит в итог.

Пример результата:

```
 region | quarter | grouping_region | grouping_quarter | total_revenue
--------+---------+------------------+-------------------+---------------
 East   | Q1      |                0 |                 0 | 10000
 East   | Q2      |                0 |                 0 | 12000
 East   | Q3      |                0 |                 0 | 15000
 East   | Q4      |                0 |                 0 | 13000
 East   | NULL    |                1 |                 0 | 50000
 NULL   | NULL    |                1 |                 1 | 50000
```

Здесь строки с `grouping_region = 1` представляют итоги по регионам, строки с `grouping_quarter = 1` представляют итоги
по кварталам, строки с `grouping_region = 1` и `grouping_quarter = 1` представляют общие итоги.

`GROUPING` полезна, когда вам нужно различать значения в итогах от значений в обычных строках результата запроса.

## Функции агрегации;

Функции агрегации в PostgreSQL позволяют выполнять вычисления на группах строк, таких как суммирование, подсчет,
нахождение среднего значения, нахождение минимального и максимального значений и другие агрегирующие операции. Вот
несколько часто используемых агрегатных функций в PostgreSQL:

1. **SUM(column):** Вычисляет сумму значений в столбце.

   ```sql
   SELECT SUM(salary) FROM employees;
   ```

2. **AVG(column):** Находит среднее значение числовых значений в столбце.

   ```sql
   SELECT AVG(age) FROM persons;
   ```

3. **COUNT(column):** Подсчитывает количество строк в столбце или количество непустых значений в столбце.

   ```sql
   SELECT COUNT(*) FROM orders;
   ```

4. **MIN(column):** Находит минимальное значение в столбце.

   ```sql
   SELECT MIN(price) FROM products;
   ```

5. **MAX(column):** Находит максимальное значение в столбце.

   ```sql
   SELECT MAX(population) FROM countries;
   ```

6. **GROUP_CONCAT(column):** Эта функция не встроена в PostgreSQL, но ее можно эмулировать с
   использованием `STRING_AGG()`.

   ```sql
   SELECT department, STRING_AGG(employee_name, ', ') FROM employees GROUP BY department;
   ```

7. **ARRAY_AGG(column):** Создает массив значений из столбца.

   ```sql
   SELECT department, ARRAY_AGG(employee_name) FROM employees GROUP BY department;
   ```

8. **JSON_AGG(column):** Создает JSON-массив из значений столбца.

   ```sql
   SELECT department, JSON_AGG(employee_name) FROM employees GROUP BY department;
   ```

9. **PERCENTILE_CONT:** Вычисляет континуальный перцентиль в группе значений.

   ```sql
   SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY column) FROM table;
   ```

10. **BIT_AND и BIT_OR:** Побитовое И и Побитовое ИЛИ для группы значений.

    ```sql
    SELECT BIT_AND(flag) FROM flags;
    ```

    ```sql
    SELECT BIT_OR(flag) FROM flags;
    ```

Это лишь несколько примеров агрегатных функций в PostgreSQL. PostgreSQL предоставляет множество других агрегатных
функций, и вы также можете создавать свои собственные с помощью пользовательских агрегатов. Функции агрегации позволяют
вам суммировать и анализировать данные на уровне групп, делая их мощным инструментом при анализе больших наборов данных.

## Фильтр HAVING;

`HAVING` является частью оператора `GROUP BY` в SQL, и используется для фильтрации результатов группировки. Он
предоставляет возможность применять условия к результирующим группам после выполнения агрегатных функций, таких
как `SUM`, `AVG`, `COUNT`, и т.д. В отличие от `WHERE`, который фильтрует строки перед группировкой, `HAVING` фильтрует
группы после группировки.

Вот пример использования `HAVING`:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

В этом запросе мы группируем сотрудников по отделам и вычисляем среднюю зарплату (`AVG(salary)`) для каждого отдела.
Затем, с помощью `HAVING`, мы фильтруем только те группы, в которых средняя зарплата больше 50000.

Важные моменты:

1. `HAVING` следует сразу за блоком `GROUP BY` в запросе.
2. В условиях `HAVING` вы можете использовать агрегатные функции, такие как `SUM`, `AVG`, `COUNT`, а также другие
   столбцы, указанные в `GROUP BY`.
3. Вы можете использовать различные операторы сравнения, такие как `=`, `>`, `<`, `>=`, `<=`, `!=`, чтобы определить
   условия в `HAVING`.
4. Если вы не используете `GROUP BY`, то `HAVING` будет вести себя аналогично `WHERE`, фильтруя строки перед
   группировкой.

Пример без `GROUP BY`:

```sql
SELECT department, AVG(salary) as avg_salary
FROM employees
HAVING AVG(salary) > 50000;
```

В этом случае, `HAVING` фактически фильтрует строки, так как нет группировки по `department`. Это полезно, если вы
хотите применить фильтр к результатам агрегации без группировки по какому-либо столбцу.

## Сортировка ORDER BY;

Команда `ORDER BY` в PostgreSQL используется для сортировки результатов запроса в определенном порядке. Эта команда
может применяться к одному или нескольким столбцам и выполнять сортировку как по возрастанию (ASC), так и по убыванию (
DESC). Вот базовый синтаксис использования `ORDER BY`:

```sql
SELECT column1, column2, ...
FROM table
ORDER BY column1 [ASC | DESC], column2 [ASC | DESC], ...;
```

Где:

- `column1`, `column2`, ...: Столбцы, по которым вы хотите выполнить сортировку.
- `table`: Таблица, из которой вы выбираете данные.
- `ASC`: По умолчанию сортировка осуществляется по возрастанию. Это можно явно указать с помощью `ASC`.
- `DESC`: Сортировка по убыванию.

Примеры:

1. **Сортировка по одному столбцу:**

   ```sql
   SELECT product_name, price
   FROM products
   ORDER BY price DESC;
   ```

   В этом примере строки будут отсортированы по убыванию цены.

2. **Сортировка по нескольким столбцам:**

   ```sql
   SELECT product_name, category, price
   FROM products
   ORDER BY category ASC, price DESC;
   ```

   Здесь сначала строки сортируются по возрастанию категории, а затем внутри каждой категории по убыванию цены.

3. **Сортировка с использованием номеров столбцов:**

   ```sql
   SELECT product_name, category, price
   FROM products
   ORDER BY 2 ASC, 3 DESC;
   ```

   В этом примере сортировка осуществляется по второму столбцу (category) по возрастанию, а затем по третьему столбцу (
   price) по убыванию.

4. **Сортировка с NULL значениями:**

   ```sql
   SELECT product_name, category, price
   FROM products
   ORDER BY price NULLS LAST;
   ```

   В этом примере NULL значения будут считаться наименьшими, и они будут расположены в конце результата.

5. **Сортировка текста с учетом регистра:**

   ```sql
   SELECT product_name
   FROM products
   ORDER BY product_name COLLATE "C";
   ```

   Здесь используется `COLLATE "C"`, чтобы сортировка происходила без учета регистра.

`ORDER BY` - мощный инструмент для управления порядком вывода данных в результатах запроса, и он может быть адаптирован
для различных потребностей с использованием различных опций и дополнительных функций.