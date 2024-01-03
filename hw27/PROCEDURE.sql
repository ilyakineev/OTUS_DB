DELIMITER //

-- Генерация тестовых данных для цен
CREATE PROCEDURE GenerateTestPriceData()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE itemId INT;
    DECLARE cur CURSOR FOR SELECT id FROM item;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop:
    LOOP
        FETCH cur INTO itemId;

        IF done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO price (fk_item, price)
        VALUES (itemId, 100 + RAND() * 900);

    END LOOP;

    CLOSE cur;
END //

-- Генерация тестовых данных для товаров
CREATE PROCEDURE GenerateTestItemData(IN numItems INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE maxId INT DEFAULT 1000;

    SELECT MAX(id) INTO maxId FROM item;

    WHILE i <= numItems
        DO
            INSERT INTO item (catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description)
            SELECT CONCAT('CAT', LPAD(maxId + i, 5, '0')),
                   nameId.name,
                   batchId.id,
                   compositionId.id,
                   manufacturerId.id,
                   statusId.id,
                   CONCAT('Description for Item ', maxId + i)
            FROM (SELECT FLOOR(1 + RAND() * maxId) AS id) AS item
                     CROSS JOIN
                     (SELECT id FROM batch ORDER BY RAND() LIMIT 1) AS batchId
                     CROSS JOIN
                     (SELECT id FROM composition ORDER BY RAND() LIMIT 1) AS compositionId
                     CROSS JOIN
                     (SELECT id FROM manufacturer ORDER BY RAND() LIMIT 1) AS manufacturerId
                     CROSS JOIN
                     (SELECT id FROM status ORDER BY RAND() LIMIT 1) AS statusId
                     CROSS JOIN
                     (SELECT name FROM sample_data ORDER BY RAND() LIMIT 1) AS nameId;

            SET i = i + 1;
        END WHILE;
END //

-- Заполнение истории товаров
CREATE PROCEDURE FillItemHistory()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE itemId INT;
    DECLARE cur CURSOR FOR SELECT id FROM item;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop:
    LOOP
        FETCH cur INTO itemId;

        IF done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO OTUS_DB_MYSQL.item_history
            (fk_operation, fk_item, fk_worker, `time`)
        VALUES (3, itemId, 2, NOW());

    END LOOP;

    CLOSE cur;
END //

-- Обертка для вызова всех процедур
CREATE PROCEDURE CallBothProcedures()
BEGIN
    -- Создание временной таблицы с данными для теста
    CREATE TEMPORARY TABLE IF NOT EXISTS sample_data
    (
        id   INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255)
    );
    INSERT INTO sample_data (name)
    VALUES ('Резец'),
           ('Сверло'),
           ('Фрез'),
           ('Отвертка'),
           ('Молоток'),
           ('Зубило'),
           ('Гаечный ключ'),
           ('Штангенциркуль'),
           ('Линейка'),
           ('Зенкер'),
           ('Метчик'),
           ('Зенковка');

    -- Вызов процедур для генерации данных
    CALL GenerateTestItemData(100);
    CALL GenerateTestPriceData();
    CALL FillItemHistory();

    -- Удаление временной таблицы после использования
    DROP TEMPORARY TABLE IF EXISTS sample_data;
END //

DELIMITER ;

-- Запуск обертывающей процедуры
CALL CallBothProcedures();
