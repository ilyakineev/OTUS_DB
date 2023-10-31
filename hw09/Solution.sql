-- 1. Написать запрос с конструкциями SELECT, JOIN

    -- 1.1 Получить список номенклатуры от производителя "iscar":
        select
                i.id as Id,
                i.catalogue_number as Каталожный_номер,
                m.name as Производитель
        from irk_.item i, irk_.manufacturer m
        where m.id = i.fk_manufacturer and m."name" = 'iscar';

    -- 1.2 Получить список сотрудников на которых числится выданная номенклатура:
        select
                i.catalogue_number as Каталожный_номер,
                i."name" as Наименование,
                s."name" as Статус,
                w.first_name as Имя,
                w.middle_name as Отчество,
                w."last name" as Фамилия
        from irk_.item i
            join irk_.item_history ih on ih.fk_item = i.id
            join irk_.worker w on w.id = ih.fk_worker
            join irk_.status s on s.id =  i.fk_status
        where s."name" = 'issued';

-- 2. Написать запрос с добавлением данных INSERT INTO

    -- 2.1 Выдать номенклатурную позицию рабочему:
        insert into irk_.item_history (fk_operation, fk_item, fk_worker, "time") values(1, 3, 4, current_time);

-- 3. Написать запрос с обновлением данных с UPDATE FROM
    -- 3.1 Изменить статус номенклатурной позиции:
        update irk_.item set fk_status=2 where id=3;

-- 4. Использовать using для оператора DELETE (В текущем проекте не удаляются данные, скрипт ниже только ради примера):

    -- 4.1 Удаление номенклатуры:
        delete from irk_.item_history where id=9;

-- 5. Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
    -- 5.1 Поиск партий поставляемых из Мытищи
        select b.id as ID, p."name" as Поставщик, p.phone as Телефон, p.address as Адрес from irk_.batch b, irk_.provider p
        where b.fk_provider = p.id and p.address like '%Мытищи%';

-- 6. Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?
    -- 6.1 Показать роли Которые назначены на должности должности
        select r.id as ID, r."name" as Роль, p."position" as Должность from irk_."role" r
        inner join irk_."position" p on p.fk_role = r.id;
    -- 6.2 Показать все роли и связанными с ними должности
        select r.id as ID, r."name" as Роль, p."position" as Должность from irk_."role" r
        left join irk_."position" p on p.fk_role = r.id;

-- 7. Напишите запрос на добавление данных с выводом информации о добавленных строках.
    insert into irk_.manufacturer ("name", phone, address, description)
    values('МИЗ', '+7(499)369-07-50', '105094, Россия, г. Москва, ул. Большая Cемёновская, 42', 'АО "МИЗ" - одно из ведущих специализированных предприятий Российской Федерации по производству металлообрабатывающего инструмента.')
    returning *;
-- 8. Напишите запрос с обновлением данные используя UPDATE FROM.
    -- 8.1 Сотрудница сменила фамилию
        UPDATE irk_.worker w SET "last name"='Владиславовна' WHERE w.phone like '+7(967)990-12-56';
-- 9. Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
    delete from irk_.worker w using (select * from irk_."position") p where p.id = w.fk_position and p.position = 'Бухгалтер';
-- 10. Задание со *: Приведите пример использования утилиты COPY
    --10.1 Сохранить данные таблицы worker
        copy (select * from irk_.worker) to '/Users/ilyakineev/IdeaProjects/OTUS_DB/hw09/worker.copy';