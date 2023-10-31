-- 1. Подготавливаем данные и создаем индекс
-- 1.1 Для наглядности было создано 37908 строк для таблицы item.
        select count(*) from irk_.item; -- 37908
        select pg_size_pretty(pg_total_relation_size('item')); -- 3840 kB
-- 1.2 Наиболее объемной таблицей будет таблица item.
        CREATE INDEX item_idx ON item (name);
-- 2. Выводим результат анализа запроса для разных сценариев. Текстом результат команды explain, в которой используется данный индекс.
-- 2.1 Исходный запрос:
        explain select * from irk_.item i where i.fk_manufacturer = 1 and i.name = 'Метчик';
-- 2.2 Получаем результат в виде плана запроса:
        /*
            Seq Scan on item i  (cost=0.00..937.62 rows=1569 width=45)
            Filter: ((fk_manufacturer = 1) AND ((name)::text = 'Метчик'::text))
        */
-- 2.3 Получаем результат в виде плана запроса:
        /*
            Bitmap Heap Scan on item i  (cost=34.54..447.25 rows=1569 width=45)
            Recheck Cond: ((name)::text = 'Метчик'::text)
            Filter: (fk_manufacturer = 1)
            ->  Bitmap Index Scan on item_idx  (cost=0.00..34.15 rows=2914 width=0)
                Index Cond: ((name)::text = 'Метчик'::text)
        */
-- 2.4 Размер таблицы с индексами:
        select pg_size_pretty(pg_total_relation_size('item')); -- Результат 4120 kB
-- 2.5 Размер таблицы без индексов:
        select pg_size_pretty(pg_table_size('item')); -- 2992 kB
-- 2.6 Анализ сканирования индекса:
	explain (costs, verbose, analyze) select * from irk_.item i order by i.id;
-- 2.7 Получаем результат в виде плана запроса:
	/*
		Index Scan using item_pk on irk_.item i  (cost=0.29..1364.91 rows=37908 width=45) (actual time=0.065..13.239 rows=37908 loops=1)
		Output: id, catalogue_number, name, fk_batch, fk_composition, fk_manufacturer, fk_status, description
		Planning Time: 0.099 ms
		Execution Time: 15.905 ms
	 */
-- 2.8 Анализ использования последовательного сканирования:
	explain (costs off, analyze) select * from irk_.item i order by i.id;
-- 2.9 Получаем результат в виде плана запроса:
	/*
		Index Scan using item_pk on item i (actual time=0.044..12.858 rows=37907 loops=1)
		Index Cond: (id < 37908)
		Planning Time: 0.218 ms
		Execution Time: 15.607 ms
	 */
-- 3. Реализовать индекс для полнотекстового поиска.
-- 3.1 Подготавливаем запрос полнотекстового поиска без установленного индекса:
    explain select * from provider p where to_tsvector(p.address) @@ to_tsquery('Москва');
-- 3.2 Получаем результат в виде плана запроса:
    /*
    	Seq Scan on provider p  (cost=0.00..2.54 rows=1 width=1100)
      	Filter: (to_tsvector(address) @@ to_tsquery('Москва'::text))
    */
-- 3.3 Установка индекса для полнотекстового поиска:
    CREATE INDEX provider_idx ON irk_.provider USING GIN (to_tsvector('russian', address));
-- 3.4 Получаем результат в виде плана запроса:
    /*
    	Seq Scan on provider p  (cost=0.00..2.54 rows=1 width=1100)
    	  Filter: (to_tsvector(address) @@ to_tsquery('Москва'::text))
    */
-- 3.5 Размер таблицы с индексами:
        select pg_size_pretty(pg_total_relation_size('provider')); -- Результат 64 kB
-- 3.6 Размер таблицы без индексов:
        select pg_size_pretty(pg_table_size('provider')); -- 16 kB
-- 4. Реализовываем индекс на часть таблицы или индекс на поле с функцией.
-- 4.1 Создаем индекс на функцию объединяющую два поля first_name и last_name:
    CREATE INDEX FIO_idx ON irk_.worker ((first_name || ' ' || last_name));
-- 4.2 Выполняем запрос с ключевым словом explain:
    explain SELECT * FROM irk_.worker w WHERE (w.first_name || ' ' || w.last_name) = 'Дьячкова Мэлоровна';
-- 4.3 Получаем результат в виде плана запроса:
    /*
        Seq Scan on worker w  (cost=0.00..1.14 rows=1 width=2104)
        Filter: ((((first_name)::text || ' '::text) || (last_name)::text) = 'Дьячкова Мэлоровна'::text)
    */
-- 4.4 Размер таблицы с индексами:
        select pg_size_pretty(pg_total_relation_size('worker')); -- Результат 80 kB
-- 4.5 Размер таблицы без индексов:
        select pg_size_pretty(pg_table_size('worker')); -- 16 kB
-- 5. Создать индекс на несколько полей.
-- 5.1 Запрос:
        explain select * from irk_.item_history ih where ih.fk_operation = 3 and ih.time between date('2009-11-01') and date('2024-11-01');
-- 5.2 Получаем результат в виде плана запроса:
    /*
		Seq Scan on item_history ih  (cost=0.00..37.48 rows=1 width=24)
		Filter: (("time" >= '2009-11-01'::date) AND ("time" <= '2024-11-01'::date) AND (fk_operation = 3))
    */
-- 5.3 Устанавливаем индекс:
        create index history_idx on irk_.item_history (fk_item, time);
-- 5.4 Получаем результат в виде плана запроса:
   	/*
   		Seq Scan on item_history ih  (cost=0.00..1.19 rows=1 width=24)
  		Filter: (("time" >= '2009-11-01'::date) AND ("time" <= '2024-11-01'::date) AND (fk_operation = 3))
    */
-- 5.5 Размер таблицы с индексами:
        select pg_size_pretty(pg_total_relation_size('item_history')); -- Результат 24 kB
-- 5.6 Размер таблицы без индексов:
        select pg_size_pretty(pg_table_size('item_history')); -- 8192 bytes