--- Добавить строки в таблицу composition - "Склад"

INSERT INTO irk_.composition ("name", address, description) VALUES('Центральный склад', 'ул. Центральная д1', 'Центральный склад на котором храниться поступаемая номенклатура.');
INSERT INTO irk_.composition ("name", address, description) VALUES('Склад цеха №1', 'ул. Центральная д3', 'ИРК цеха №1.');
INSERT INTO irk_.composition ("name", address, description) VALUES('Ремонтно механический участок', 'Помещение 3', 'Склад ремонтно механического участочка');

--- Добавить строки в таблицу status - "Статус номенклатурной позиции"

INSERT INTO irk_.status ("name", description) VALUES('storage', 'Номенклатурная позиция хранится на складе.');
INSERT INTO irk_.status ("name", description) VALUES('issued', 'Номенклатурная позиция выдана рабочему.');
INSERT INTO irk_.status ("name", description) VALUES('repair', 'Номенклатурная позиция на ремонте.');
INSERT INTO irk_.status ("name", description) VALUES('disposed_of', 'Номенклатурная позиция утилизирована.');

--- Добавить строки в таблицу manufacturer - "Производитель"

INSERT INTO irk_.manufacturer ("name", phone, address, description) VALUES('iscar', '+7(495)660-91-25', '141014, Мытищи, ул. Центральная, 20Б, БЦ "Квадрум"', 'ISCAR Ltd. — израильская компания-производитель металлорежущего инструмента, входящая в состав одного из крупнейших в мире металлообрабатывающих конгломератов IMC');
INSERT INTO irk_.manufacturer ("name", phone, address, description) VALUES('sandvik', '+7(495)916-71-91', '119049, Россия, г. Москва, 4-й Добрынинский пер., д. 8, офис Д08.', 'Сандвик — международная компания, основанная в 1862 году Ёраном Фредриком Ёранссоном в Сандвикен, Швеция.');

--- Добавить строки в таблицу provider - "Поставщик"

INSERT INTO irk_.provider ("name", phone, address, description) VALUES('iscar', '+7(495)660-91-25', '141014, Мытищи, ул. Центральная, 20Б, БЦ "Квадрум"', 'Официальный представитель.');
INSERT INTO irk_.provider ("name", phone, address, description) VALUES('sandvik', '+7(495)916-71-91', '119049, Россия, г. Москва, 4-й Добрынинский пер., д. 8, офис Д08.', 'Официальный представитель.');
INSERT INTO irk_.provider ("name", phone, address, description) VALUES('Интехника', '+7(495)560-48-88', '129085, Москва, ул. Годовикова, д. 9, стр. 25', 'Официальный представитель.');

--- Добавить строки в таблицу role - "Роли"

INSERT INTO irk_."role" ("name") VALUES('worker');
INSERT INTO irk_."role" ("name") VALUES('Supervisor');
INSERT INTO irk_."role" ("name") VALUES('Engineer');
INSERT INTO irk_."role" ("name") VALUES('Warehouse employee');

--- Добавить строки в таблицу position - "Должности"

INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Оператор станка', 'Основной работниц цеха.', 1);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Ученик оператора', 'Учение оператора станка.', 1);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Руководитель участка', 'Руководитель участка.', 1);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Руководитель участка', 'Руководитель участка.', 2);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Заведующий склада', 'Материально ответственный за приписанную номенклатуру к складу.', 2);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Заведующий склада', 'Материально ответственный за приписанную номенклатуру к складу.', 4);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Кладовщик', 'Основной работник склада.', 4);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Бухгалтер', 'Бухгалтер завода', 2);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Бухгалтер', 'Бухгалтер завода', 4);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Завхоз', 'Материально ответственный за приписанную номенклатуру на заводе.', 2);
INSERT INTO irk_."position" ("position", description, fk_role) VALUES('Завхоз', 'Материально ответственный за приписанную номенклатуру на заводе.', 4);

--- Добавить строки в таблицу worker - "Работник"

INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Сергеев', 'Прохор', 'Артёмович', '+7(967)746-60-46', 1, '1');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Шубин', 'Варлам', 'Семёнович', '+7(967)309-20-14', 1, '1');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Кузнецов', 'Остап', 'Миронович', '+7(967)343-97-95', 3, '3');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Пономарёв', 'Егор', 'Федотович', '+7(967)176-69-80', 2, '2');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Елисеев', 'Авраам', 'Валерьянович', '+7(967)263-21-00', 5, '5');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Ефимов', 'Владлен', 'Иванович', '+7(967)006-01-12', 3, '7');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Баранова', 'Татьяна', 'Юлиановна', '+7(967)655-35-00', 7, '7');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) values('Ефремова', 'Габриэлла', 'Дмитрьевна', '+7(967)872-85-25', 8, '8');
INSERT INTO irk_.worker (first_name, middle_name, "last name", phone, fk_position, description) VALUES('Дьячкова', 'Жюли', 'Мэлоровна', '+7(967)990-09-15', 11, '11');

--- Добавить строки в таблицу operation - "Операций с номенклатурной позицией"

INSERT INTO irk_.operation ("name", description) VALUES('Issue', 'Выдача работнику');
INSERT INTO irk_.operation ("name", description) VALUES('Write-off', 'Списание');
INSERT INTO irk_.operation ("name", description) VALUES('Accrual', 'Начисление');
INSERT INTO irk_.operation ("name", description) VALUES('Return to storage', 'Возврат на хранение');

--- Добавить строки в таблицу batch - "Партия"

INSERT INTO irk_.batch (fk_provider) VALUES(1);
INSERT INTO irk_.batch (fk_provider) VALUES(1);
INSERT INTO irk_.batch (fk_provider) VALUES(2);
INSERT INTO irk_.batch (fk_provider) VALUES(3);

--- Добавить строки в таблицу item - "Номенклатурная позиция"

INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011201', 'Резец', 1, 3, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011301', 'Сверло', 1, 2, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00301101', 'Фреза', 1, 2, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011601', 'Кондуктор', 1, 2, 2, 3, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00013101', 'Ключ', 2, 2, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00051101', 'Плита', 2, 3, 2, 2, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011091', 'Линейка', 3, 2, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011081', 'Штангенциркуль',3, 2, 2, 2, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00017101', 'Метчик', 3, 2, 2, 3, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00601101', 'Сверло', 3, 1, 2, 3, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011501', 'Сборная фреза', 4, 1, 2, 2, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00301101', 'Зенкер', 4, 1, 1, 1, '');
INSERT INTO irk_.item (catalogue_number, "name", fk_batch, fk_composition, fk_manufacturer, fk_status, description) VALUES('00011041', 'Сверло', 4, 1, 1, 1, '');

--- Добавить строки в таблицу price - "Цена"

INSERT INTO irk_.price (fk_item, price) VALUES(1, 1000);
INSERT INTO irk_.price (fk_item, price) VALUES(2, 1500);
INSERT INTO irk_.price (fk_item, price) VALUES(3, 800);
INSERT INTO irk_.price (fk_item, price) VALUES(4, 700);
INSERT INTO irk_.price (fk_item, price) VALUES(5, 5000);
INSERT INTO irk_.price (fk_item, price) VALUES(6, 1234);
INSERT INTO irk_.price (fk_item, price) VALUES(7, 432);INSERT INTO irk_.price (fk_item, price) VALUES(8, 7654);
INSERT INTO irk_.price (fk_item, price) VALUES(9, 5412);
INSERT INTO irk_.price (fk_item, price) VALUES(10, 123);
INSERT INTO irk_.price (fk_item, price) VALUES(11, 132);
INSERT INTO irk_.price (fk_item, price) VALUES(12, 987);
INSERT INTO irk_.price (fk_item, price) VALUES(13, 765);

--- Добавить строки в таблицу item_history - "История изменения номенклатуры"

INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(3, 1, 1, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(3, 3, 2, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(3, 2, 3, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(1, 4, 4, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(3, 5, 2, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(2, 1, 3, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(1, 2, 5, '2001-02-16 20:38:40');
INSERT INTO irk_.item_history (fk_operation, fk_item, fk_worker, "time") VALUES(1, 3, 1, '2001-02-16 20:38:40');
