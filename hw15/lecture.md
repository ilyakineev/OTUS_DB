# Лекция #15

## Хранимые процедуры и триггеры

## Цели занятия

Использовать хранимые процедуры и функций для оптимизации работы с БД;

## Хранимые процедуры

Хранимые процедуры в PostgreSQL представляют собой набор SQL-запросов, которые могут быть сохранены на сервере и вызваны при необходимости. Они позволяют уменьшить сетевой трафик, так как код выполняется непосредственно на сервере, а не передается клиенту для выполнения. Вот некоторые основные аспекты хранимых процедур в PostgreSQL:

1. **Создание хранимых процедур**:
   ```sql
   CREATE OR REPLACE PROCEDURE procedure_name(arg1 type1, arg2 type2, ...) AS
   LANGUAGE plpgsql
   BEGIN
       -- SQL-код процедуры
   END;
   ```

2. **Языки для создания процедур**:
   В PostgreSQL можно использовать различные языки для написания хранимых процедур, но наиболее распространенными являются `plpgsql`, `sql` и `plperl`.

3. **Вложенные процедуры**:
   Хранимые процедуры могут вызывать другие хранимые процедуры.

4. **Параметры и возвращаемые значения**:
   Процедуры могут принимать параметры и возвращать значения, что позволяет создавать гибкие и многократно используемые решения.

5. **Транзакции**:
   Хранимые процедуры могут использовать транзакции, что позволяет обеспечивать атомарность операций.

6. **Оптимизация производительности**:
   Использование хранимых процедур может улучшить производительность приложения, особенно при выполнении сложных операций на стороне сервера.

7. **Безопасность и права доступа**:
   При создании процедур можно управлять правами доступа, определяя, какие пользователи имеют право выполнять процедуру.

8. **Обработка исключений**:
   Внутри хранимых процедур можно использовать блоки `BEGIN ... EXCEPTION` для обработки исключений и ошибок.

9. **Удаление процедур**:
   Для удаления процедуры используется команда `DROP PROCEDURE`.

Хранимые процедуры предоставляют разработчикам инструмент для создания сложной бизнес-логики на стороне сервера, что может повысить эффективность и безопасность приложений. Однако их использование требует глубокого понимания SQL и специфических особенностей PostgreSQL.

## Функции

В PostgreSQL функции представляют собой набор инструкций, объединенных в один блок, который может принимать аргументы и возвращать значение. Функции используются для инкапсуляции логики и предоставления гибкости в обработке данных. Вот основные аспекты функций в PostgreSQL:

1. **Создание функций**:
   ```sql
   CREATE OR REPLACE FUNCTION function_name(arg1 type1, arg2 type2, ...)
   RETURNS return_type AS
   LANGUAGE plpgsql
   BEGIN
       -- Тело функции
       RETURN result_value;
   END;
   ```

2. **Языки для создания функций**:
   PostgreSQL поддерживает различные языки для создания функций, такие как `plpgsql`, `sql`, `plperl` и другие.

3. **Типы возвращаемых значений**:
   Функции могут возвращать значения различных типов данных, включая базовые типы данных PostgreSQL, составные типы и даже таблицы.

4. **Параметры функций**:
   Функции могут принимать входные параметры, которые используются внутри функции для выполнения операций.

5. **Возвращаемые значения**:
   Функции возвращают значение с помощью инструкции `RETURN`.

6. **Транзакции и изоляция**:
   Функции могут быть выполнены в рамках транзакции, и можно управлять уровнем изоляции транзакций.

7. **Безопасность и права доступа**:
   При создании функций можно устанавливать права доступа, определяя, какие пользователи имеют право вызывать функцию.

8. **Функции с побочными эффектами**:
   В функциях можно выполнять различные операции, такие как вставка, обновление или удаление данных.

9. **Перегрузка функций**:
   В PostgreSQL поддерживается перегрузка функций, что позволяет создавать несколько функций с одним и тем же именем, но с различными параметрами.

10. **Удаление функций**:
    Функции можно удалять с помощью команды `DROP FUNCTION`.

Использование функций в PostgreSQL позволяет создавать многократно используемый код, улучшать производительность и безопасность приложений, а также обеспечивать легкость поддержки и разработки.

## Триггеры

Триггеры в PostgreSQL представляют собой специальные функции, которые автоматически вызываются при определенных событиях, таких как вставка, обновление или удаление записи в таблице. Триггеры позволяют обеспечивать бизнес-логику на уровне базы данных, автоматизировать определенные операции и гарантировать целостность данных. Вот основные аспекты триггеров в PostgreSQL:

1. **Создание триггеров**:
   ```sql
   CREATE TRIGGER trigger_name
   AFTER INSERT OR UPDATE OR DELETE ON table_name
   FOR EACH ROW
   EXECUTE FUNCTION trigger_function();
   ```

2. **События триггера**:
   Триггеры могут реагировать на различные события, такие как `INSERT`, `UPDATE`, `DELETE`, а также комбинации этих событий.

3. **Типы триггеров**:
   В PostgreSQL существует несколько типов триггеров, включая `BEFORE`, `AFTER`, `INSTEAD OF` и другие, которые определяют, когда триггер будет вызываться относительно основного действия.

4. **Функции триггера**:
   Триггеры вызывают специальные функции, которые содержат логику, выполняемую при активации триггера.

5. **Доступ к данным**:
   Функции триггера могут обращаться к данным, связанным с событием, которое вызвало триггер, с помощью специальных переменных, таких как `NEW` и `OLD`.

6. **Целостность данных**:
   Триггеры могут использоваться для обеспечения целостности данных, например, для проверки или модификации данных перед их сохранением в таблице.

7. **Каскадное выполнение триггеров**:
   В PostgreSQL можно создавать цепочки триггеров, в которых один триггер вызывает другой, что позволяет сложной логике обработки данных.

8. **Отключение и удаление триггеров**:
   Триггеры можно временно отключать с помощью команды `DISABLE TRIGGER` и удалять с помощью команды `DROP TRIGGER`.

9. **Безопасность и права доступа**:
   Триггеры наследуют права доступа от таблицы, на которую они установлены, и могут быть ограничены только определенными пользователями или ролями.

10. **Применение триггеров**:
    Триггеры широко используются в различных сценариях, включая аудит изменений данных, автоматическую генерацию значений, проверку ограничений и другие задачи.

Триггеры в PostgreSQL предоставляют мощный механизм для автоматизации и контроля действий, выполняемых с данными, что улучшает надежность и целостность баз данных.

## Курсоры

Курсоры в PostgreSQL представляют собой механизм, который позволяет выполнять запросы к базе данных и обрабатывать результаты по частям. Курсоры полезны, когда необходимо обработать большой объем данных, но нежелательно извлекать все данные сразу из-за ограничений по памяти или производительности. Вот основные аспекты курсоров в PostgreSQL:

1. **Создание курсора**:
   ```sql
   DECLARE cursor_name CURSOR FOR SELECT column1, column2 FROM table_name WHERE condition;
   ```

2. **Открытие курсора**:
   ```sql
   OPEN cursor_name;
   ```

3. **Извлечение данных из курсора**:
   ```sql
   FETCH NEXT FROM cursor_name INTO variable1, variable2;
   ```

4. **Закрытие курсора**:
   ```sql
   CLOSE cursor_name;
   ```

5. **Типы курсоров**:
   В PostgreSQL поддерживаются различные типы курсоров, включая `FORWARD-ONLY` (перемещение только вперед), `SCROLL` (позволяет перемещаться в обе стороны), и `NO SCROLL` (без возможности перемещения).

6. **Операции с курсорами**:
   Кроме извлечения данных, с курсорами можно выполнять различные операции, такие как обновление, удаление или вставка данных.

7. **Блокирующие и неблокирующие курсоры**:
   Блокирующие курсоры блокируют строки данных, извлеченные из курсора, что может привести к проблемам с производительностью. Неблокирующие курсоры не блокируют строки, что делает их более предпочтительными в большинстве сценариев.

8. **Использование курсоров в функциях и процедурах**:
   Курсоры могут быть использованы в хранимых процедурах и функциях для обработки данных по частям, улучшая производительность и уменьшая использование ресурсов.

9. **Ограничения и рекомендации**:
   При использовании курсоров важно учитывать потребление ресурсов и оптимизировать запросы для минимизации задержек и улучшения производительности.

Курсоры в PostgreSQL предоставляют гибкий и мощный инструмент для обработки данных по частям, что позволяет эффективно работать с большими объемами данных и улучшать производительность приложений. Однако их использование требует внимания к деталям и оптимизации запросов для обеспечения оптимальной производительности.

## Временные таблицы

Временные таблицы в PostgreSQL — это специальный тип таблиц, которые существуют только в течение сессии пользователя и автоматически удаляются после завершения этой сессии. Они предоставляют удобный способ временно сохранять данные для дальнейшего использования без необходимости создавать постоянные структуры данных. Вот основные аспекты временных таблиц в PostgreSQL:

1. **Создание временной таблицы**:
   Временные таблицы создаются аналогично обычным таблицам, но с ключевым словом `TEMPORARY` или `TEMP` перед ключевым словом `TABLE`.
   ```sql
   CREATE TEMPORARY TABLE temp_table_name (
       column1 datatype,
       column2 datatype,
       ...
   );
   ```

2. **Особенности временных таблиц**:
    - Временные таблицы видны только в рамках текущей сессии пользователя.
    - Они автоматически удаляются при завершении сессии.
    - Имена временных таблиц не должны совпадать с именами постоянных таблиц в той же схеме.

3. **Использование временных таблиц в запросах**:
   Временные таблицы можно использовать в SQL-запросах так же, как и обычные таблицы, для выполнения операций вставки, обновления, выборки и удаления данных.

4. **Индексы и ограничения**:
   Временные таблицы могут иметь индексы, ограничения и триггеры, такие же, как и обычные таблицы, что обеспечивает гибкость в обработке данных.

5. **Очистка временных таблиц**:
   Поскольку временные таблицы автоматически удаляются при завершении сессии, нет необходимости явно удалять их. Однако в случае необходимости можно явно удалить временную таблицу с помощью команды `DROP TABLE`.

6. **Транзакции и временные таблицы**:
   Временные таблицы наследуют свойства транзакций, что позволяет контролировать их область видимости и управлять транзакциями в рамках сессии.

7. **Преимущества использования временных таблиц**:
    - Упрощение работы с временными данными.
    - Оптимизация производительности, так как временные таблицы могут быть адаптированы для конкретных операций и запросов.
    - Уменьшение нагрузки на систему базы данных путем временного сохранения промежуточных результатов.

Временные таблицы в PostgreSQL представляют собой удобный инструмент для временного хранения данных и обеспечивают гибкость и производительность при выполнении сложных операций и запросов.

## Обработка ошибок.

Обработка ошибок в PostgreSQL позволяет эффективно управлять исключениями и ошибками, которые могут возникнуть при выполнении SQL-команд, функций или триггеров. Вот основные моменты по обработке ошибок в PostgreSQL:

1. **Блоки обработки исключений**:
   Для обработки ошибок в PostgreSQL используются блоки `BEGIN ... EXCEPTION ... END`. В блоке `EXCEPTION` можно определить действия, которые будут выполнены при возникновении определенного исключения.

   ```sql
   BEGIN
       -- SQL-код
   EXCEPTION
       WHEN unique_violation THEN
           -- Обработка ошибки уникальности
       WHEN others THEN
           -- Обработка других ошибок
   END;
   ```

2. **Стандартные условные переменные**:
   В блоке обработки исключений можно использовать стандартные условные переменные, такие как `SQLSTATE`, `SQLERRM`, `SQLERRCODE`, чтобы получить дополнительную информацию об ошибке.

3. **Специфические исключения**:
   PostgreSQL предоставляет различные специфические исключения, такие как `unique_violation`, `not_null_violation`, `foreign_key_violation` и другие, которые позволяют детально определить тип ошибки и выполнить соответствующую обработку.

4. **Пользовательские исключения**:
   Пользователи могут определять свои собственные исключения с помощью команды `CREATE EXCEPTION`, что обеспечивает гибкость в управлении ошибками и исключениями в приложениях.

5. **Встроенные функции исключений**:
   В PostgreSQL существует ряд встроенных функций, таких как `RAISE`, `RAISE NOTICE`, `RAISE EXCEPTION`, которые позволяют возбуждать исключения и уведомления, управлять потоком выполнения и обеспечивать логирование ошибок.

6. **Интеграция с PL/pgSQL**:
   В PL/pgSQL, языке хранимых процедур PostgreSQL, обработка ошибок выполняется с использованием блоков `BEGIN ... EXCEPTION ... END` и предоставляет дополнительные инструменты для управления исключениями и выполнения логики обработки ошибок.

Обработка ошибок в PostgreSQL предоставляет мощный и гибкий механизм для управления исключениями и ошибками, что обеспечивает надежность, безопасность и эффективность работы приложений и запросов к базе данных. Это позволяет разработчикам создавать устойчивые и отказоустойчивые решения, обеспечивая корректную обработку ошибок и исключений в различных сценариях.