select now();

-- OTUS_DB_MYSQL.composition определение

CREATE TABLE `composition`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `address`     varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text COLLATE utf8mb4_unicode_ci         NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.manufacturer определение

CREATE TABLE `manufacturer`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `phone`        varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `description`  text COLLATE utf8mb4_unicode_ci         NOT NULL,
    `JSON_address` json                                    NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`),
    UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.operation определение

CREATE TABLE `operation`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.provider определение

CREATE TABLE `provider`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `phone`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description`  text COLLATE utf8mb4_unicode_ci,
    `JSON_address` json NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`),
    UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.`role` определение

CREATE TABLE `role`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.status определение

CREATE TABLE `status`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.batch определение

CREATE TABLE `batch`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `fk_provider` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY           `fk_provider` (`fk_provider`),
    CONSTRAINT `batch_ibfk_1` FOREIGN KEY (`fk_provider`) REFERENCES `provider` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.item определение

CREATE TABLE `item`
(
    `id`               int(11) NOT NULL AUTO_INCREMENT,
    `catalogue_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `name`             varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `fk_batch`         int(11) NOT NULL,
    `fk_composition`   int(11) NOT NULL,
    `fk_manufacturer`  int(11) NOT NULL,
    `fk_status`        int(11) NOT NULL,
    `description`      text COLLATE utf8mb4_unicode_ci         NOT NULL,
    PRIMARY KEY (`id`),
    KEY                `fk_batch` (`fk_batch`),
    KEY                `fk_composition` (`fk_composition`),
    KEY                `fk_manufacturer` (`fk_manufacturer`),
    KEY                `fk_status` (`fk_status`),
    KEY                `item_idx` (`catalogue_number`),
    CONSTRAINT `item_ibfk_1` FOREIGN KEY (`fk_batch`) REFERENCES `batch` (`id`),
    CONSTRAINT `item_ibfk_2` FOREIGN KEY (`fk_composition`) REFERENCES `composition` (`id`),
    CONSTRAINT `item_ibfk_3` FOREIGN KEY (`fk_manufacturer`) REFERENCES `manufacturer` (`id`),
    CONSTRAINT `item_ibfk_4` FOREIGN KEY (`fk_status`) REFERENCES `status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.post определение

CREATE TABLE `post`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `post`        varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `fk_role`     int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY           `fk_role` (`fk_role`),
    CONSTRAINT `post_ibfk_1` FOREIGN KEY (`fk_role`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.price определение

CREATE TABLE `price`
(
    `fk_item` int(11) NOT NULL,
    `price`   DECIMAL NOT NULL,
    KEY       `fk_item` (`fk_item`),
    CONSTRAINT `price_ibfk_1` FOREIGN KEY (`fk_item`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.worker определение

CREATE TABLE `worker`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `first_name`  varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `last_name`   varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `phone`       varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `fk_post`     int(11) NOT NULL,
    `description` text COLLATE utf8mb4_unicode_ci         NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `phone` (`phone`),
    KEY           `worker_idx` (`fk_post`),
    CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`fk_post`) REFERENCES `post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- OTUS_DB_MYSQL.item_history определение

CREATE TABLE `item_history`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT,
    `fk_operation` int(11) NOT NULL,
    `fk_item`      int(11) NOT NULL,
    `fk_worker`    int(11) NOT NULL,
    `time`         timestamp NOT NULL,
    PRIMARY KEY (`id`),
    KEY            `fk_operation` (`fk_operation`),
    KEY            `fk_item` (`fk_item`),
    KEY            `fk_worker` (`fk_worker`),
    CONSTRAINT `item_history_ibfk_1` FOREIGN KEY (`fk_operation`) REFERENCES `operation` (`id`),
    CONSTRAINT `item_history_ibfk_2` FOREIGN KEY (`fk_item`) REFERENCES `item` (`id`),
    CONSTRAINT `item_history_ibfk_3` FOREIGN KEY (`fk_worker`) REFERENCES `worker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

select now();

-- Тестовые данные

-- OTUS_DB_MYSQL.`role`
INSERT INTO OTUS_DB_MYSQL.`role` (id, name) VALUES (1, 'worker');
INSERT INTO OTUS_DB_MYSQL.`role` (id, name) VALUES (2, 'Supervisor');
INSERT INTO OTUS_DB_MYSQL.`role` (id, name) VALUES (3, 'Engineer');
INSERT INTO OTUS_DB_MYSQL.`role` (id, name) VALUES (4, 'Warehouse employee');

-- OTUS_DB_MYSQL.status

INSERT INTO OTUS_DB_MYSQL.status
    (id, name, description)
VALUES (1, 'storage', 'Номенклатурная позиция хранится на складе.');
INSERT INTO OTUS_DB_MYSQL.status
    (id, name, description)
VALUES (2, 'issued', 'Номенклатурная позиция выдана рабочему.');
INSERT INTO OTUS_DB_MYSQL.status
    (id, name, description)
VALUES (3, 'repair', 'Номенклатурная позиция на ремонте.');
INSERT INTO OTUS_DB_MYSQL.status
    (id, name, description)
VALUES (4, 'disposed_of', 'Номенклатурная позиция утилизирована.');

-- OTUS_DB_MYSQL.provider

INSERT INTO OTUS_DB_MYSQL.provider
    (id, name, phone, description, JSON_address)
VALUES (1, 'iscar', '+7(495)660-91-25', 'Официальный представитель.',
        '{"city": "Мытищи", "region": "Московская область", "street": "Центральная улица", "country": "Россия", "postal_code": "141014", "building_name": "БЦ ''Квадрум''", "building_number": "20Б"}');
INSERT INTO OTUS_DB_MYSQL.provider
    (id, name, phone, description, JSON_address)
VALUES (2, 'sandvik', '+7(495)916-71-91', 'Официальный представитель.',
        '{"city": "Москва", "office": "офис Д08", "street": "4-й Добрынинский переулок", "country": "Россия", "postal_code": "119049", "building_number": "8"}');
INSERT INTO OTUS_DB_MYSQL.provider
    (id, name, phone, description, JSON_address)
VALUES (3, 'ИНТЕХНИКА', '+7(495)560-48-88', 'Официальный представитель.',
        '{"city": "Москва", "street": "улица Годовикова", "country": "Россия", "postal_code": "129085", "building_number": "9", "building_section": "строение 25"}');

-- OTUS_DB_MYSQL.batch

INSERT INTO OTUS_DB_MYSQL.batch
    (id, fk_provider)
VALUES (1, 1);
INSERT INTO OTUS_DB_MYSQL.batch
    (id, fk_provider)
VALUES (2, 1);
INSERT INTO OTUS_DB_MYSQL.batch
    (id, fk_provider)
VALUES (3, 2);
INSERT INTO OTUS_DB_MYSQL.batch
    (id, fk_provider)
VALUES (4, 3);

-- OTUS_DB_MYSQL.composition

INSERT INTO OTUS_DB_MYSQL.composition
    (id, name, address, description)
VALUES (1, 'Центральный склад', 'ул. Центральная д1',
        'Центральный склад на котором храниться поступаемая номенклатура.');
INSERT INTO OTUS_DB_MYSQL.composition
    (id, name, address, description)
VALUES (2, 'Склад цеха №1', 'ул. Центральная д3', 'ИРК цеха №1.');
INSERT INTO OTUS_DB_MYSQL.composition
    (id, name, address, description)
VALUES (3, 'Ремонтно механический участок', 'Помещение 3', 'Склад ремонтно механического участочка');

-- OTUS_DB_MYSQL.manufacturer

INSERT INTO OTUS_DB_MYSQL.manufacturer
    (id, name, phone, description, JSON_address)
VALUES (1, 'iscar', '+7(495)660-91-25',
        'ISCAR Ltd. — израильская компания-производитель металлорежущего инструмента, входящая в состав одного из крупнейших в мире металлообрабатывающих конгломератов IMC',
        '{"city": "Москва", "floor": "5", "region": "Московская область", "street": "Примерная улица", "country": "Россия", "district": "Центральный административный округ", "postal_code": "123456", "building_name": "Офисный центр ''Звезда''", "additional_info": "Вход со двора, звонить по телефону", "building_number": "12", "apartment_number": "45"}');
INSERT INTO OTUS_DB_MYSQL.manufacturer
    (id, name, phone, description, JSON_address)
VALUES (2, 'sandvik', '+7(495)916-71-91',
        'Сандвик — международная компания, основанная в 1862 году Ёраном Фредриком Ёранссоном в Сандвикен, Швеция.',
        '{"city": "Москва", "office": "офис Д08", "street": "4-й Добрынинский переулок", "country": "Россия", "postal_code": "119049", "building_number": "8"}');

-- OTUS_DB_MYSQL.operation

INSERT INTO OTUS_DB_MYSQL.operation
    (id, name, description)
VALUES (1, 'Issue', 'Выдача работнику');
INSERT INTO OTUS_DB_MYSQL.operation
    (id, name, description)
VALUES (2, 'Write-off', 'Списание');
INSERT INTO OTUS_DB_MYSQL.operation
    (id, name, description)
VALUES (3, 'Accrual', 'Начисление');
INSERT INTO OTUS_DB_MYSQL.operation
    (id, name, description)
VALUES (4, 'Return to storage', 'Возврат на хранение');

-- OTUS_DB_MYSQL.post

INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (1, 'Оператор станка', 'Основной работниц цеха.', 1);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (2, 'Ученик оператора', 'Учение оператора станка.', 1);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (3, 'Руководитель участка', 'Руководитель участка.', 1);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (4, 'Руководитель участка', 'Руководитель участка.', 2);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (5, 'Заведующий склада', 'Материально ответственный за приписанную номенклатуру к складу.',
        2);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (6, 'Заведующий склада', 'Материально ответственный за приписанную номенклатуру к складу.',
        4);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (7, 'Кладовщик', 'Основной работник склада.', 4);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (8, 'Бухгалтер', 'Бухгалтер завода', 2);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (9, 'Бухгалтер', 'Бухгалтер завода', 4);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (10, 'Завхоз', 'Материально ответственный за приписанную номенклатуру на заводе.',
        2);
INSERT INTO OTUS_DB_MYSQL.post
    (id, post, description, fk_role)
VALUES (11, 'Завхоз', 'Материально ответственный за приписанную номенклатуру на заводе.',
        4);

-- OTUS_DB_MYSQL.worker

INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (1, 'Сергеев', 'Прохор', 'Артёмович', '+7(967)746-60-46', 1, '1');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (2, 'Шубин', 'Варлам', 'Семёнович', '+7(967)309-20-14', 1, '1');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (3, 'Кузнецов', 'Остап', 'Миронович', '+7(967)343-97-95', 3, '3');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (4, 'Пономарёв', 'Егор', 'Федотович', '+7(967)176-69-80', 2, '2');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (5, 'Елисеев', 'Авраам', 'Валерьянович', '+7(967)263-21-00', 5, '5');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (6, 'Ефимов', 'Владлен', 'Иванович', '+7(967)006-01-12', 3, '7');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (7, 'Баранова', 'Татьяна', 'Юлиановна', '+7(967)655-35-00', 7, '7');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (8, 'Ефремова', 'Габриэлла', 'Дмитрьевна', '+7(967)872-85-25', 8, '8');
INSERT INTO OTUS_DB_MYSQL.worker
    (id, first_name, middle_name, last_name, phone, fk_post, description)
VALUES (9, 'Дьячкова', 'Жюли', 'Мэлоровна', '+7(967)990-09-15', 11, '11');

-- OTUS_DB_MYSQL.item

INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (1, '00011201', 'Резец', 1, 3, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (2, '00011301', 'Сверло', 1, 2, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (3, '00301101', 'Фреза', 1, 2, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (4, '00011601', 'Кондуктор', 1, 2, 2, 3, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (5, '00013101', 'Ключ', 2, 2, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (6, '00051101', 'Плита', 2, 3, 2, 2, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (7, '00011091', 'Линейка', 3, 2, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (8, '00011081', 'Штангенциркуль', 3, 2, 2, 2, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (9, '00017101', 'Метчик', 3, 2, 2, 3, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (10, '00601101', 'Сверло', 3, 1, 2, 3, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (11, '00011501', 'Сборная фреза', 4, 1, 2, 2, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (12, '00301101', 'Зенкер', 4, 1, 1, 1, '');
INSERT INTO OTUS_DB_MYSQL.item
(id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
VALUES (13, '00011041', 'Сверло', 4, 1, 1, 1, '');


-- OTUS_DB_MYSQL.item_history

INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (1, 3, 1, 1, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (2, 3, 3, 2, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (3, 3, 2, 3, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (4, 1, 4, 4, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (5, 3, 5, 2, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (6, 2, 1, 3, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (7, 1, 2, 5, '2023-12-24 08:20:03');
INSERT INTO OTUS_DB_MYSQL.item_history
    (id, fk_operation, fk_item, fk_worker, `time`)
VALUES (8, 1, 3, 1, '2023-12-24 08:20:03');

-- OTUS_DB_MYSQL.price

INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (1, 1000);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (2, 1500);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (3, 800);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (4, 700);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (5, 5000);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (6, 1234);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (7, 432);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (8, 7654);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (9, 5412);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (10, 123);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (11, 132);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (12, 987);
INSERT INTO OTUS_DB_MYSQL.price
    (fk_item, price)
VALUES (13, 765);