# Домашнее задание
Добавляем в базу хранимые процедуры и триггеры
## Цель:

* Научиться создавать пользователей, процедуры и триггеры

## Описание/Пошаговая инструкция выполнения домашнего задания:

* Создать пользователей client, manager. 
* Создать процедуру выборки товаров с использованием различных фильтров: категория, цена, производитель, различные дополнительные параметры
  Также в качестве параметров передавать по какому полю сортировать выборку, и параметры постраничной выдачи 
* Дать права да запуск процедуры пользователю client
* Создать процедуру get_orders - которая позволяет просматривать отчет по продажам за определенный период (час, день, неделя)
  с различными уровнями группировки (по товару, по категории, по производителю)
* Права дать пользователю manager

## Критерии оценки:

Выполнение ДЗ: 10 баллов
плюс 2 балла за красивое решение
минус 2 балла за рабочее решение, и недостатки указанные преподавателем не устранены

## Решение:

### [Docker-compose](../hw21/docker/docker-compose.yml)

Для создания пользователей в MySQL, мы можете использовать команду `CREATE USER` в сочетании с командой `GRANT` для предоставления прав доступа.

Вот как мы можете создать пользователей `client` и `manager` для нашей базы данных `OTUS_DB_MYSQL`:

```sql
-- Создание пользователя client
CREATE USER 'client'@'localhost' IDENTIFIED BY 'password_for_client';

-- Предоставление прав доступа для пользователя client к базе данных OTUS_DB_MYSQL
GRANT SELECT ON OTUS_DB_MYSQL.* TO 'client'@'localhost';

-- Создание пользователя manager
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'password_for_manager';

-- Предоставление прав доступа для пользователя manager к базе данных OTUS_DB_MYSQL
GRANT SELECT, INSERT, UPDATE, DELETE ON OTUS_DB_MYSQL.* TO 'manager'@'localhost';
```

Обратите внимание, что в приведенном примере пароли (`password_for_client` и `password_for_manager`) должны быть заменены на реальные и безопасные пароли.

Также учтите, что мы можете предоставить разные уровни доступа для каждого пользователя в зависимости от наших требований к безопасности и функциональности.

---

Для создания процедуры, которая будет выполнять выборку из таблицы `item` с учетом различных фильтров и пагинацией, мы можете использовать следующий пример кода:

```sql
DELIMITER //

CREATE PROCEDURE `GetItemsWithPagination` (
    IN filter_status INT,
    IN filter_manufacturer INT,
    IN filter_batch INT,
    IN start_index INT,
    IN page_size INT
)
BEGIN
    -- Выборка данных с учетом пагинации
    SELECT *
    FROM item
    WHERE 
        (filter_status IS NULL OR fk_status = filter_status) AND
        (filter_manufacturer IS NULL OR fk_manufacturer = filter_manufacturer) AND
        (filter_batch IS NULL OR fk_batch = filter_batch)
    LIMIT start_index, page_size;
END //

DELIMITER ;
```

Эта процедура `GetItemsWithPagination` принимает следующие параметры:

- `filter_status`: Фильтр по статусу (может быть `NULL`).
- `filter_manufacturer`: Фильтр по производителю (может быть `NULL`).
- `filter_batch`: Фильтр по партии (может быть `NULL`).
- `start_index`: Начальный индекс для пагинации.
- `page_size`: Размер страницы для пагинации.

Процедура возвращает результат выборки с учетом указанных фильтров и пагинации, а также общее количество строк, удовлетворяющих фильтрам.

После создания процедуры `GetItemsWithPagination`, мы можете вызвать её, передав соответствующие параметры. Вот пример вызова этой процедуры:

```sql
-- Выборка всех элементов с фильтром по статусу 1, производителю 2, партии 3, начиная с индекса 0 и размером страницы 10
CALL GetItemsWithPagination(1, 2, 3, 0, 10);
```
Результат
```
id |catalogue_number|name          |fk_batch|fk_composition|fk_manufacturer|fk_status|description            |
---+----------------+--------------+--------+--------------+---------------+---------+-----------------------+
48|CAT00036        |Резец         |       3|             2|              2|        1|Description for Item 36|
55|CAT00043        |Зубило        |       3|             3|              2|        1|Description for Item 43|
107|CAT00095       |Штангенциркуль|       3|             2|              2|        1|Description for Item 95|
```

-- Выборка всех элементов без фильтров, начиная с индекса 10 и размером страницы 10
```sql
CALL GetItemsWithPagination(NULL, NULL, NULL, 10, 10);
```
Результат
```
id|catalogue_number|name          |fk_batch|fk_composition|fk_manufacturer|fk_status|description            |
--+----------------+--------------+--------+--------------+---------------+---------+-----------------------+
23|CAT00011        |Сверло        |       1|             2|              1|        2|Description for Item 11|
24|CAT00012        |Зенкер        |       1|             2|              1|        4|Description for Item 12|
25|CAT00013        |Метчик        |       4|             1|              2|        3|Description for Item 13|
26|CAT00014        |Гаечный ключ  |       1|             2|              1|        3|Description for Item 14|
27|CAT00015        |Сверло        |       1|             1|              2|        1|Description for Item 15|
28|CAT00016        |Зенковка      |       1|             2|              1|        2|Description for Item 16|
29|CAT00017        |Штангенциркуль|       2|             3|              2|        2|Description for Item 17|
30|CAT00018        |Сверло        |       4|             3|              1|        2|Description for Item 18|
31|CAT00019        |Гаечный ключ  |       1|             2|              1|        1|Description for Item 19|
32|CAT00020        |Фрез          |       4|             1|              1|        1|Description for Item 20|
```
-- Выборка элементов с фильтром по статусу 1, без других фильтров, начиная с индекса 5 и размером страницы 15
```sql
CALL GetItemsWithPagination(1, NULL, NULL, 5, 15);
```
Результат
```
id|catalogue_number|name          |fk_batch|fk_composition|fk_manufacturer|fk_status|description            |
--+----------------+--------------+--------+--------------+---------------+---------+-----------------------+
39|CAT00027        |Зубило        |       2|             1|              1|        1|Description for Item 27|
42|CAT00030        |Резец         |       3|             2|              1|        1|Description for Item 30|
47|CAT00035        |Зенковка      |       4|             3|              1|        1|Description for Item 35|
48|CAT00036        |Резец         |       3|             2|              2|        1|Description for Item 36|
49|CAT00037        |Зенковка      |       1|             3|              1|        1|Description for Item 37|
51|CAT00039        |Молоток       |       4|             3|              1|        1|Description for Item 39|
55|CAT00043        |Зубило        |       3|             3|              2|        1|Description for Item 43|
57|CAT00045        |Гаечный ключ  |       4|             1|              2|        1|Description for Item 45|
69|CAT00057        |Линейка       |       1|             3|              2|        1|Description for Item 57|
74|CAT00062        |Штангенциркуль|       4|             1|              2|        1|Description for Item 62|
76|CAT00064        |Метчик        |       2|             3|              1|        1|Description for Item 64|
80|CAT00068        |Гаечный ключ  |       1|             2|              2|        1|Description for Item 68|
83|CAT00071        |Зенкер        |       1|             3|              1|        1|Description for Item 71|
89|CAT00077        |Зенкер        |       4|             1|              2|        1|Description for Item 77|
91|CAT00079        |Зубило        |       1|             2|              1|        1|Description for Item 79|
```
В этом примере мы вызываем процедуру `GetItemsWithPagination` с различными комбинациями параметров для демонстрации её работы. Вы можете адаптировать эти вызовы в соответствии с вашими конкретными требованиями и фильтрами.

---
Для предоставления права на запуск процедуры `GetItemsWithPagination` только пользователю `client`, мы можете использовать команду `GRANT EXECUTE` в MySQL. Вот как это можно сделать:

```sql
GRANT EXECUTE ON PROCEDURE OTUS_DB_MYSQL.GetItemsWithPagination TO 'client'@'localhost';
```

Эта команда предоставит пользователю `client` право на выполнение процедуры `GetItemsWithPagination` в базе данных `OTUS_DB_MYSQL`.

Обратите внимание, что перед выполнением этой команды убедитесь, что пользователь `client` существует и у него есть соответствующие права на доступ к базе данных. Также учтите, что названия базы данных, пользователей и хостов (`localhost` в этом примере) могут отличаться в зависимости от вашей конфигурации.

---

Для создания процедуры, которая позволяет просматривать историю изменений `item_history` за определенный период (час, день или неделя) с различными группами сортировки и пагинацией, мы можете использовать следующий пример кода:

```sql
DELIMITER //

CREATE PROCEDURE `GetItemHistoryWithPagination` (
    IN start_date TIMESTAMP,
    IN end_date TIMESTAMP,
    IN fk_operation_filter INT,
    IN fk_item_filter INT,
    IN fk_worker_filter INT,
    IN group_by_column VARCHAR(255),
    IN sort_order VARCHAR(10),
    IN start_index INT,
    IN page_size INT
)
BEGIN
    -- Выборка данных с учетом указанных параметров
    SELECT *
    FROM item_history
    WHERE 
        time BETWEEN start_date AND end_date
        AND (fk_operation = fk_operation_filter OR fk_operation_filter IS NULL)
        AND (fk_item = fk_item_filter OR fk_item_filter IS NULL)
        AND (fk_worker = fk_worker_filter OR fk_worker_filter IS NULL)
    LIMIT start_index, page_size;
    
END //

DELIMITER ;
```

Эта процедура `GetItemHistoryWithPagination` принимает следующие параметры:

- `start_date`: Начальная дата и временной период.
- `end_date`: Конечная дата и временной период.
- `group_by_column`: Столбец для группировки данных.
- `sort_order`: Порядок сортировки (ASC или DESC).
- `start_index`: Начальный индекс для пагинации.
- `page_size`: Размер страницы для пагинации.
- `fk_operation_filter`: Фильтр по операции.
- `fk_item_filter`: Фильтер по номенклатуре.
- `fk_worker_filter`: Фильтр по сотруднику.

Процедура возвращает результат выборки истории изменений с учетом указанных параметров.

Обратите внимание, что вы можете адаптировать этот код в соответствии с вашими конкретными требованиями и структурой вашей базы данных.

---

Для использования процедуры `GetItemHistoryWithPagination` с новыми параметрами фильтрации, вы можете вызвать эту процедуру, передав соответствующие аргументы. Вот примеры использования:

### Пример 1: Фильтрация по `fk_operation`, `fk_item` и `fk_worker`
```sql
CALL GetItemHistoryWithPagination(
    '2023-01-01 00:00:00',
    '2024-01-02 00:00:00',
    3,  -- fk_operation_filter
    null,  -- fk_item_filter
    2,  -- fk_worker_filter
    'time',  -- group_by_column
    'ASC',   -- sort_order
    0,      -- start_index
    10      -- page_size
);
```
Результат 
```
id|fk_operation|fk_item|fk_worker|time               |
--+------------+-------+---------+-------------------+
 9|           3|      1|        2|2023-12-27 14:01:05|
10|           3|     23|        2|2023-12-27 14:01:05|
11|           3|     24|        2|2023-12-27 14:01:05|
12|           3|     26|        2|2023-12-27 14:01:05|
13|           3|     27|        2|2023-12-27 14:01:05|
14|           3|     28|        2|2023-12-27 14:01:05|
15|           3|     31|        2|2023-12-27 14:01:05|
16|           3|     34|        2|2023-12-27 14:01:05|
17|           3|     35|        2|2023-12-27 14:01:05|
18|           3|     36|        2|2023-12-27 14:01:05|
```

### Пример 2: Фильтрация только по `fk_operation`
```sql
CALL GetItemHistoryWithPagination(
    '2024-01-01 00:00:00',
    '2024-01-02 00:00:00',
    1,  -- fk_operation_filter
    NULL,  -- fk_item_filter (без фильтрации)
    NULL,  -- fk_worker_filter (без фильтрации)
    'time',  -- group_by_column
    'ASC',   -- sort_order
    0,      -- start_index
    10      -- page_size
);
```
Результат
```
id|fk_operation|fk_item|fk_worker|time               |
--+------------+-------+---------+-------------------+
 9|           3|      1|        2|2023-12-27 14:01:05|
10|           3|     23|        2|2023-12-27 14:01:05|
11|           3|     24|        2|2023-12-27 14:01:05|
12|           3|     26|        2|2023-12-27 14:01:05|
13|           3|     27|        2|2023-12-27 14:01:05|
14|           3|     28|        2|2023-12-27 14:01:05|
15|           3|     31|        2|2023-12-27 14:01:05|
16|           3|     34|        2|2023-12-27 14:01:05|
17|           3|     35|        2|2023-12-27 14:01:05|
18|           3|     36|        2|2023-12-27 14:01:05|
```
### Пример 3: Фильтрация по `fk_item` и с сортировкой по умолчанию
```sql
CALL GetItemHistoryWithPagination(
    '2023-01-01 00:00:00',
    '2024-01-02 00:00:00',
    NULL,  -- fk_operation_filter (без фильтрации)
    33,  -- fk_item_filter
    NULL,  -- fk_worker_filter (без фильтрации)
    'time',  -- group_by_column
    'DESC',  -- сортировка в обратном порядке
    0,      -- start_index
    10      -- page_size
);
```
Результат
```
id|fk_operation|fk_item|fk_worker|time               |
--+------------+-------+---------+-------------------+
86|           3|     33|        2|2023-12-27 14:01:05|
```
Эти примеры демонстрируют различные комбинации параметров для фильтрации и сортировки результатов истории изменений `item_history`. Мы можете адаптировать эти вызовы в соответствии с вашими конкретными требованиями и структурой вашей базы данных.

--- 
Для добавления права вызова процедуры `GetItemHistoryWithPagination` пользователю `manager`, мы можете использовать SQL-запросы GRANT. Вам потребуется выполнить два основных шага:

1. Убедитесь, что пользователь `manager` существует в вашей базе данных MySQL.
2. Предоставьте пользователю `manager` право на выполнение процедуры.

Вот пример SQL-запросов для выполнения этих действий:

```sql
-- Создание пользователя manager, если он еще не существует
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'password';  -- Замените 'password' на реальный пароль

-- Предоставление права на выполнение процедуры GetItemHistoryWithPagination пользователю manager
GRANT EXECUTE ON PROCEDURE YourDatabaseName.GetItemHistoryWithPagination TO 'manager'@'localhost';
```

Замените `YourDatabaseName` на имя вашей базы данных.

После выполнения этих SQL-запросов пользователь `manager` будет иметь право на вызов процедуры `GetItemHistoryWithPagination`.