# Домашнее задание
Типы данных

## Цель:
* Научиться джойнить таблицы и использовать условия в SQL выборке

## Описание/Пошаговая инструкция выполнения домашнего задания:
* Напишите запрос по своей базе с inner join
* Напишите запрос по своей базе с left join
* Напишите 5 запросов с WHERE с использованием разных
операторов, опишите для чего вам в проекте нужна такая выборка данных

## Критерии оценки:
Выполнение ДЗ: 10 баллов
плюс 2 балла за красивое решение
минус 2 балла за рабочее решение, и недостатки указанные преподавателем не устранены

## Решение:

DML скрипты для таблицы `manufacturer`.

```sql
-- Получить список номенклатуры от производителя "iscar":
SELECT
    i.id AS Id,
    i.catalogue_number AS Каталожный_номер,
    m.name AS Производитель
FROM 
    item i
JOIN 
    manufacturer m ON m.id = i.fk_manufacturer
WHERE 
    m.name = 'iscar';
```
 Получить список сотрудников, на которых числится выданная номенклатура:
```SQL
SELECT
    i.catalogue_number AS Каталожный_номер,
    i.name AS Наименование,
    s.name AS Статус,
    w.first_name AS Имя,
    w.middle_name AS Отчество,
    w.last_name AS Фамилия
FROM 
    item i
JOIN 
    item_history ih ON ih.fk_item = i.id
JOIN 
    worker w ON w.id = ih.fk_worker
JOIN 
    status s ON s.id = i.fk_status
WHERE 
    s.name = 'repair';
```
Выдать номенклатурную позицию рабочему:
```SQL 
INSERT INTO 
    item_history (fk_operation, fk_item, fk_worker, time) 
VALUES 
    (1, 3, 4, NOW());
```
Изменить статус номенклатурной позиции:
```SQL
UPDATE 
    item 
SET 
    fk_status = 2 
WHERE 
    id = 3;
```
Удаление номенклатуры:
```SQL
DELETE FROM 
    item_history 
WHERE 
    id = 9;
```
Поиск партий, поставляемых из Мытищи:
```SQL
SELECT 
    b.id AS ID, 
    p.name AS Поставщик, 
    p.phone AS Телефон, 
    p.JSON_address AS Адрес 
FROM 
    batch b
JOIN 
    provider p ON b.fk_provider = p.id 
WHERE 
    JSON_EXTRACT(`JSON_address`, '$.city') = 'Мытищи';
```
Показать роли, которые назначены на должности:
```SQL
SELECT 
    r.id AS ID, 
    r.name AS Роль, 
    p.post AS Должность 
FROM 
    role r
INNER JOIN 
    post p ON p.fk_role = r.id;
```
Показать все роли и связанные с ними должности:
```SQL
SELECT 
    r.id AS ID, 
    r.name AS Роль, 
    p.post AS Должность 
FROM 
    role r
LEFT JOIN 
    post p ON p.fk_role = r.id;
```

### [Docker-compose](../hw21/docker/docker-compose.yml)

