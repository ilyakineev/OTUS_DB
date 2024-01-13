# Домашнее задание
Анализ и профилирование запроса
## Цель:

* Проанализировать план выполнения запроса, заценить на чем теряется время

## Описание/Пошаговая инструкция выполнения домашнего задания:

* возьмите сложную выборку из предыдущих ДЗ с несколькими join и подзапросами постройте EXPLAIN в 3 формата
  оцените план прохождения запроса, найдите самые тяжелые места
  Задание со *:
  оптимизировать запрос (можно использовать индексы, хинты, сбор статистики, гистограммы)
  все действия и результаты опишите в README.md

## Критерии оценки:

Выполнение ДЗ: 10 баллов
плюс 2 балла за красивое решение
минус 2 балла за рабочее решение, и недостатки указанные преподавателем не устранены

## Решение:

### [Docker-compose](../docker/mysql/docker-compose.yml)
1. **Получить все детали о номенклатурных позициях и их производителях:**
```sql
SELECT 
    item.id, 
    item.catalogue_number, 
    item.name AS item_name, 
    manufacturer.name AS manufacturer_name
FROM 
    item
JOIN 
    manufacturer ON item.fk_manufacturer = manufacturer.id;
```
Вызываем скрипт с использованием EXPLAIN
```
id|select_type|table       |partitions|type |possible_keys  |key            |key_len|ref                          |rows|filtered|Extra      |
--+-----------+------------+----------+-----+---------------+---------------+-------+-----------------------------+----+--------+-----------+
 1|SIMPLE     |manufacturer|          |index|PRIMARY        |name           |257    |                             |   2|   100.0|Using index|
 1|SIMPLE     |item        |          |ref  |fk_manufacturer|fk_manufacturer|4      |OTUS_DB_MYSQL.manufacturer.id|   1|   100.0|           |
 ```

2. **Получить список номенклатурных позиций с информацией о производителе и статусе:**
```sql
SELECT 
    item.id, 
    item.name AS item_name, 
    manufacturer.name AS manufacturer_name, 
    status.name AS status_name
FROM 
    item
JOIN 
    manufacturer ON item.fk_manufacturer = manufacturer.id
JOIN 
    status ON item.fk_status = status.id;
```
Вызываем скрипт с использованием EXPLAIN
```
id|select_type|table       |partitions|type  |possible_keys            |key            |key_len|ref                          |rows|filtered|Extra      |
--+-----------+------------+----------+------+-------------------------+---------------+-------+-----------------------------+----+--------+-----------+
 1|SIMPLE     |manufacturer|          |index |PRIMARY                  |name           |257    |                             |   2|   100.0|Using index|
 1|SIMPLE     |item        |          |ref   |fk_manufacturer,fk_status|fk_manufacturer|4      |OTUS_DB_MYSQL.manufacturer.id|   1|   100.0|           |
 1|SIMPLE     |status      |          |eq_ref|PRIMARY                  |PRIMARY        |4      |OTUS_DB_MYSQL.item.fk_status |   1|   100.0|           |
```
3. **Получить список номенклатурных позиций с историей изменений:**
```sql
SELECT 
    item.id, 
    item.name AS item_name, 
    operation.name AS operation_name, 
    worker.first_name AS worker_first_name
FROM 
    item
JOIN 
    item_history ON item.id = item_history.fk_item
JOIN 
    operation ON item_history.fk_operation = operation.id
JOIN 
    worker ON item_history.fk_worker = worker.id;
```
Вызываем скрипт с использованием EXPLAIN
```
id|select_type|table       |partitions|type |possible_keys                 |key    |key_len|ref                  |rows|filtered|Extra                                |
--+-----------+------------+----------+-----+------------------------------+-------+-------+---------------------+----+--------+-------------------------------------+
 1|SIMPLE     |operation   |          |index|PRIMARY                       |name   |258    |                     |   1|   100.0|Using index                          |
 1|SIMPLE     |worker      |          |ALL  |PRIMARY                       |       |       |                     |   1|   100.0|Using join buffer (Block Nested Loop)|
 1|SIMPLE     |item        |          |ALL  |PRIMARY                       |       |       |                     | 101|   100.0|Using join buffer (Block Nested Loop)|
 1|SIMPLE     |item_history|          |ref  |fk_operation,fk_item,fk_worker|fk_item|4      |OTUS_DB_MYSQL.item.id|   1|   100.0|Using where                          |
```
4. **Получить список номенклатурных позиций с информацией о поставщике партии:**
```sql
EXPLAIN SELECT
  w.first_name,
  w.middle_name,
  w.last_name,
  o.name AS operation_name,
  s.name AS status_name
FROM
  item AS i
    JOIN
  item_history AS ih ON i.id = ih.fk_item
    JOIN
  operation AS o ON ih.fk_operation = o.id
    JOIN
  worker AS w ON ih.fk_worker = w.id
    JOIN
  status AS s ON i.fk_status = s.id
WHERE
  o.name = 'Accrual' AND s.name = 'storage';
```
Вызываем скрипт с использованием EXPLAIN
```
id|select_type|table|partitions|type  |possible_keys                 |key      |key_len|ref                       |rows|filtered|Extra      |
--+-----------+-----+----------+------+------------------------------+---------+-------+--------------------------+----+--------+-----------+
 1|SIMPLE     |o    |          |const |PRIMARY,name                  |name     |258    |const                     |   1|   100.0|Using index|
 1|SIMPLE     |s    |          |const |PRIMARY,name                  |name     |258    |const                     |   1|   100.0|Using index|
 1|SIMPLE     |i    |          |ref   |PRIMARY,fk_status             |fk_status|4      |const                     |  26|   100.0|Using index|
 1|SIMPLE     |ih   |          |ref   |fk_operation,fk_item,fk_worker|fk_item  |4      |OTUS_DB_MYSQL.i.id        |   1|   100.0|Using where|
 1|SIMPLE     |w    |          |eq_ref|PRIMARY                       |PRIMARY  |4      |OTUS_DB_MYSQL.ih.fk_worker|   1|   100.0|           |
```

Для оптимизации данного запроса можно предпринять следующие шаги:

1. **Индексы на колонках в условиях JOIN:**
   Создайте индексы на колонках, по которым происходит объединение таблиц (в условиях JOIN). В данном случае это `id` в таблицах `item`, `item_history`, `operation`, `worker`, и `status`.

```sql
CREATE INDEX idx_item_id ON item (id);
CREATE INDEX idx_item_history_fk_item ON item_history (fk_item);
CREATE INDEX idx_operation_id ON operation (id);
CREATE INDEX idx_worker_id ON worker (id);
CREATE INDEX idx_status_id ON status (id);
```

2. **Индексы на колонках в условиях WHERE:**
   Создайте индексы на колонках, которые используются в условиях WHERE. В данном случае это `name` в таблицах `operation` и `status`.

```sql
CREATE INDEX idx_operation_name ON operation (name);
CREATE INDEX idx_status_name ON status (name);
```

3. **Использование индексов в JOIN:**
   Используйте индексы в операторах JOIN, как в вашем запросе. Убедитесь, что у нас есть индексы, которые указаны в операторах JOIN.

4. **Оптимизация порядка объединения таблиц:**
   Измените порядок объединения таблиц, чтобы сначала происходили объединения с таблицами, у которых меньше записей. Это может уменьшить количество строк, которые нужно объединять на более поздних этапах.

```sql
EXPLAIN SELECT w.first_name,
       w.middle_name,
       w.last_name,
       o.name AS operation_name,
       s.name AS status_name
FROM operation AS o USE INDEX (name)
       JOIN
     item_history AS ih USE INDEX (fk_operation)
     ON o.id = ih.fk_operation
       JOIN
     item AS i USE INDEX (idx_item_id)
     ON ih.fk_item = i.id
       JOIN
     status AS s USE INDEX (idx_status_id)
     ON i.fk_status = s.id
       JOIN
     worker AS w USE INDEX (idx_worker_id)
     ON ih.fk_worker = w.id
WHERE o.name = 'Issue'
  AND s.name = 'storage';
```

Результат
```
id|select_type|table|partitions|type |possible_keys|key          |key_len|ref                       |rows|filtered|Extra      |
--+-----------+-----+----------+-----+-------------+-------------+-------+--------------------------+----+--------+-----------+
 1|SIMPLE     |o    |          |const|name         |name         |258    |const                     |   1|   100.0|Using index|
 1|SIMPLE     |ih   |          |ref  |fk_operation |fk_operation |4      |const                     |   1|   100.0|           |
 1|SIMPLE     |w    |          |ref  |idx_worker_id|idx_worker_id|4      |OTUS_DB_MYSQL.ih.fk_worker|   1|   100.0|           |
 1|SIMPLE     |i    |          |ref  |idx_item_id  |idx_item_id  |4      |OTUS_DB_MYSQL.ih.fk_item  |   1|   100.0|           |
 1|SIMPLE     |s    |          |ref  |idx_status_id|idx_status_id|4      |OTUS_DB_MYSQL.i.fk_status |   1|    25.0|Using where|
```

Сбор статистики в базе данных играет ключевую роль в оптимизации производительности запросов. Статистика позволяет оптимизатору запросов принимать более обоснованные решения о том, как выполнить запросы, основываясь на ожидаемом количестве строк, которые будут обработаны.

В MySQL сбор статистики можно выполнить с помощью команды `ANALYZE TABLE`. Эта команда пересчитывает статистику для таблицы, что позволяет оптимизатору запросов лучше планировать выполнение запросов.

Для нашего запроса, сбор статистики может быть особенно полезным, так как запрос использует несколько таблиц и соединений. Вот как мы можем выполнить сбор статистики для всех таблиц, которые используются в запросе:

```sql
ANALYZE TABLE item;
ANALYZE TABLE item_history;
ANALYZE TABLE operation;
ANALYZE TABLE worker;
ANALYZE TABLE status;
```

Результат 
```
Table               |Op     |Msg_type|Msg_text|
--------------------+-------+--------+--------+
OTUS_DB_MYSQL.status|analyze|status  |OK      |
```

Также рекомендуется регулярно собирать статистику для всех таблиц в нашей базе данных, чтобы обеспечить оптимальную производительность запросов. Это можно автоматизировать, выполняя сбор статистики с определенной периодичностью или при определенных событиях, таких как большие изменения данных или структуры таблиц.

Важно помнить, что сбор статистики может быть времязатратным процессом, особенно для больших таблиц, поэтому рекомендуется выполнять его в периоды минимальной активности системы или с использованием ресурсов для сбора статистики, которые не влияют на производительность основных операций.