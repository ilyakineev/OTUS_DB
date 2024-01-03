# Домашнее задание

Создаем отчетную выборку

## Цель:

* Научимся создавать ответную выборку

## Описание/Пошаговая инструкция выполнения домашнего задания:

* Группировки с ипользованием CASE, HAVING, ROLLUP, GROUPING() :
  * Для магазина к предыдущему списку продуктов добавить максимальную и минимальную цену и кол-во предложений
  * Сделать выборку показывающую самый дорогой и самый дешевый товар в каждой категории
  * Сделать rollup с количеством товаров по категориям

## Критерии оценки:

Выполнение ДЗ: 10 баллов
плюс 2 балла за красивое решение
минус 2 балла за рабочее решение, и недостатки указанные преподавателем не устранены

## Решение:

### [Docker-compose](../hw21/docker/docker-compose.yml)

Для отображения SQL-запросов в формате Markdown (MD), вы можете структурировать каждый запрос и добавить форматирование для лучшего восприятия. Ниже представлены ваши SQL-запросы, оформленные в формате Markdown:

---

Допустим, мы хотите выполнить запрос к таблице `item`, чтобы получить информацию о статусе каждого элемента с использованием `CASE` для представления статуса в виде текста. Ниже приведен пример такого запроса:

```sql
SELECT
    id,
    catalogue_number,
    name,
    fk_batch,
    fk_composition,
    fk_manufacturer,
    fk_status,
    description,
    CASE
        WHEN fk_status = 1 THEN 'На складе'
        WHEN fk_status = 2 THEN 'Выдан'
        WHEN fk_status = 3 THEN 'На ремонте'
        WHEN fk_status = 4 THEN 'Утилизирован'
        ELSE 'Неизвестный статус'
    END AS status_description
FROM
    item;
```
Результат:
```
id |catalogue_number|name          |fk_batch|fk_composition|fk_manufacturer|fk_status|description             |status_description|
---+----------------+--------------+--------+--------------+---------------+---------+------------------------+------------------+
  1|00011201        |Резец         |       1|             3|              1|        1|                        |На складе         |
 14|CAT00002        |Зубило        |       3|             1|              2|        4|Description for Item 2  |Утилизирован      |
 15|CAT00003        |Зенкер        |       3|             3|              1|        4|Description for Item 3  |Утилизирован      |
 16|CAT00004        |Зубило        |       2|             3|              2|        3|Description for Item 4  |На ремонте        |
 17|CAT00005        |Резец         |       2|             3|              1|        4|Description for Item 5  |Утилизирован      |
 18|CAT00006        |Сверло        |       3|             3|              2|        2|Description for Item 6  |Выдан             |
 19|CAT00007        |Отвертка      |       3|             2|              1|        2|Description for Item 7  |Выдан             |
 20|CAT00008        |Молоток       |       3|             2|              2|        2|Description for Item 8  |Выдан             |
 21|CAT00009        |Штангенциркуль|       2|             1|              1|        2|Description for Item 9  |Выдан             |
 22|CAT00010        |Линейка       |       2|             2|              1|        2|Description for Item 10 |Выдан             |
 ```

В этом запросе мы выбираем все столбцы из таблицы `item`, а также используем `CASE` для создания нового столбца `status_description`, который будет содержать текстовое представление статуса каждого элемента.

---

Допустим, мы хотите выполнить запрос к таблице `item` и группировать элементы по `fk_status`. Затем мы хотите выбрать только те группы, которые содержат более одного элемента. В этом случае вы можете использовать `HAVING`.

Ниже приведен пример такого запроса:

```sql
SELECT
    fk_status,
    COUNT(*) AS count_of_items
FROM
    item
GROUP BY
    fk_status
HAVING
    COUNT(*) > 1;
```
Результат
```
fk_status|count_of_items|
---------+--------------+
        1|            28|
        2|            22|
        3|            25|
        4|            26|
```

Этот запрос сначала группирует строки из таблицы `item` по `fk_status` с помощью `GROUP BY`. Затем с помощью `HAVING` он фильтрует результаты, оставляя только те группы, в которых количество элементов больше одного.

### SQL-запросы для статистического анализа

---

#### Товары с максимальной ценой по каждому наименованию

```sql
WITH MaxPricePerItem AS (
    SELECT 
        i.name,
        MAX(p.price) AS max_price
    FROM 
        item i
    JOIN 
        price p ON i.id = p.fk_item
    GROUP BY 
        i.name
)

SELECT name, max_price
FROM MaxPricePerItem
ORDER BY max_price DESC
LIMIT 1;
```
Результат
```
name   |max_price|
-------+---------+
Молоток|      973|
```
---

#### Товары с минимальной ценой по каждому наименованию

```sql
WITH MinPricePerItem AS (
    SELECT 
        i.name,
        MIN(p.price) AS min_price
    FROM 
        item i
    JOIN 
        price p ON i.id = p.fk_item
    GROUP BY 
        i.name
)

SELECT name, min_price
FROM MinPricePerItem
ORDER BY min_price ASC
LIMIT 1;
```
```
name   |min_price|
-------+---------+
Молоток|      112|
```
---

#### Количество товаров по каждому наименованию

```sql
SELECT 
    COALESCE(i.name, 'Всего наименований') AS item_name,
    COUNT(*) AS count
FROM 
    item i
GROUP BY 
    i.name WITH ROLLUP;
```
```
item_name         |count|
------------------+-----+
Гаечный ключ      |   11|
Зенкер            |   11|
Зенковка          |    9|
Зубило            |   12|
Линейка           |    5|
Метчик            |    5|
Молоток           |    8|
Отвертка          |    5|
Резец             |    8|
Сверло            |   10|
Фрез              |    7|
Штангенциркуль    |   10|
Всего наименований|  101|
```
---

#### Количество товаров по каждой партии и поставщику

```sql
SELECT 
    COALESCE(b.id, 'Всего наименований') AS '№ Партия',
    COALESCE(p.name, '-/--/-') AS 'Поставщик',
    COUNT(*) AS count
FROM 
    item i
LEFT JOIN 
    batch b ON i.fk_batch = b.id
LEFT JOIN 
    provider p ON b.fk_provider = p.id
GROUP BY 
    b.id WITH ROLLUP;
```

---

#### Количество товаров по каждому складу

```sql
SELECT 
    COALESCE(c.id, 'Всего наименований') AS '№ Склад',
    COALESCE(c.name, '-/--/-') AS 'Склад',
    COUNT(*) AS 'Количество'
FROM 
    item i
LEFT JOIN 
    composition c ON i.fk_composition = c.id
GROUP BY 
    c.id WITH ROLLUP;
```
```
№ Партия          |Поставщик|count|
------------------+---------+-----+
1                 |iscar    |   31|
2                 |iscar    |   22|
3                 |sandvik  |   21|
4                 |ИНТЕХНИКА|   27|
Всего наименований|         |  101|
```
---

#### Количество товаров по каждому производителю

```sql
SELECT 
    COALESCE(m.id, 'Всего по производителям') AS '№ Производителя',
    COALESCE(m.name, '-/--/-') AS 'Производитель',
    COUNT(*) AS 'Количество'
FROM 
    item i
LEFT JOIN 
    manufacturer m ON i.fk_manufacturer = m.id
GROUP BY 
    m.id WITH ROLLUP;
```
```
№ Производителя        |Производитель|Количество|
-----------------------+-------------+----------+
1                      |iscar        |        47|
2                      |sandvik      |        54|
Всего по производителям|             |       101|
```
---

#### Количество товаров по каждому статусу

```sql
SELECT 
    COALESCE(s.id, 'Всего по статусам') AS '№ позиций со статусом',
    CASE 
        WHEN s.name = 'storage' THEN 'Храниться на складе'
        WHEN s.name = 'issued' THEN 'Выдана'
        WHEN s.name = 'repair' THEN 'На ремонте'
        WHEN s.name = 'disposed_of' THEN 'Утилизирован'
        ELSE COALESCE(s.name, '-/--/-')
    END AS 'Статус',
    COUNT(*) AS 'Количество'
FROM 
    item i
LEFT JOIN 
    status s ON i.fk_status = s.id
GROUP BY 
    s.id WITH ROLLUP;
```
```
№ позиций со статусом|Статус             |Количество|
---------------------+-------------------+----------+
1                    |Храниться на складе|        28|
2                    |Выдана             |        22|
3                    |На ремонте         |        25|
4                    |Утилизирован       |        26|
Всего по статусам    |                   |       101|
```
---

#### Количество рабочих по каждой должности

```sql
SELECT 
    COALESCE(p.id, 'Всего рабочих') AS '№ должности',
    COALESCE(p.post, '-/--/-') AS 'Должность',
    COUNT(*) AS 'Количество'
FROM 
    worker w
LEFT JOIN 
    post p ON w.fk_post = p.id
GROUP BY 
    p.id WITH ROLLUP;
```
```
№ должности  |Должность           |Количество|
-------------+--------------------+----------+
1            |Оператор станка     |         2|
2            |Ученик оператора    |         1|
3            |Руководитель участка|         2|
5            |Заведующий склада   |         1|
7            |Кладовщик           |         1|
8            |Бухгалтер           |         1|
11           |Завхоз              |         1|
Всего рабочих|                    |         9|
```
---

Таким образом, каждый запрос теперь представлен в виде блока кода с языком SQL и имеет соответствующее форматирование для отображения в Markdown.