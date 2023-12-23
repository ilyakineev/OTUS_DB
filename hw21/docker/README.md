Для тестирования производительности MySQL с использованием `sysbench`, выполните следующие шаги:

1. **Установка sysbench**:
2. **Настройка MySQL**:
    - Убедитесь, что у вас установлен и запущен сервер MySQL.
    - Создайте базу данных и пользователя для тестирования. Например:
      ```sql
      CREATE DATABASE testdb;
      GRANT ALL PRIVILEGES ON testdb.* TO 'root'@'localhost' IDENTIFIED BY 'password';
      FLUSH PRIVILEGES;
      ```

3. **Подготовка тестовых данных**:

- Используйте `sysbench` для создания тестовой базы данных. Пример:

```
sysbench oltp_read_write --db-driver=mysql --mysql-host=localhost --mysql-user=root --mysql-password=password --mysql-db=testdb --tables=10 --table-size=100000 prepare
```

,где --tables=10 колличесво таблиц (10 таблиц), --table-size=100000 - количество строк в таблице 100000

Результат:

```
ilyakineev@MacBook-Air-Ilya ~ % sysbench oltp_read_write --db-driver=mysql --mysql-db=testDB --mysql-user=root --mysql-password=password --table-size=100000 --tables=10 prepare

sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Creating table 'sbtest1'...
Inserting 100000 records into 'sbtest1'
Creating a secondary index on 'sbtest1'...
Creating table 'sbtest2'...
Inserting 100000 records into 'sbtest2'
Creating a secondary index on 'sbtest2'...
Creating table 'sbtest3'...
Inserting 100000 records into 'sbtest3'
Creating a secondary index on 'sbtest3'...
Creating table 'sbtest4'...
Inserting 100000 records into 'sbtest4'
Creating a secondary index on 'sbtest4'...
Creating table 'sbtest5'...
Inserting 100000 records into 'sbtest5'
Creating a secondary index on 'sbtest5'...
Creating table 'sbtest6'...
Inserting 100000 records into 'sbtest6'
Creating a secondary index on 'sbtest6'...
Creating table 'sbtest7'...
Inserting 100000 records into 'sbtest7'
Creating a secondary index on 'sbtest7'...
Creating table 'sbtest8'...
Inserting 100000 records into 'sbtest8'
Creating a secondary index on 'sbtest8'...
Creating table 'sbtest9'...
Inserting 100000 records into 'sbtest9'
Creating a secondary index on 'sbtest9'...
Creating table 'sbtest10'...
Inserting 100000 records into 'sbtest10'
Creating a secondary index on 'sbtest10'...
```

4. **Запуск теста**:
    - Вы можете запустить различные тесты в зависимости от ваших потребностей. Например, тестирование производительности
      на чтение/запись с 10 потоками в течение 60 секунд:
    ```
    sysbench oltp_read_write --db-driver=mysql --mysql-host=localhost --mysql-user=root --mysql-password=password
    --mysql-db=testdb --tables=10 --table-size=100000 --threads=10 --time=60 run
    ```
   Результат:

```
ilyakineev@MacBook-Air-Ilya ~ %       sysbench oltp_read_write --db-driver=mysql --mysql-host=localhost --mysql-user=root --mysql-password=password --mysql-db=testdb --tables=10 --table-size=100000 --threads=10 --time=60 run

sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 10
Initializing random number generator from current time


Initializing worker threads...

Threads started!

SQL statistics:
    queries performed:
        read:                            3922772
        write:                           1120792
        other:                           560396
        total:                           5603960
    transactions:                        280198 (4667.33 per sec.)
    queries:                             5603960 (93346.63 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.0336s
    total number of events:              280198

Latency (ms):
         min:                                    0.64
         avg:                                    2.14
         max:                                  162.61
         95th percentile:                        0.00
         sum:                               599854.97

Threads fairness:
    events (avg/stddev):           28019.8000/204.75
    execution time (avg/stddev):   59.9855/0.00
```

5. **Анализ результатов**:
   После завершения теста `sysbench` предоставит вам результаты, включая общее количество выполненных транзакций, время
   отклика и т. д.

6. **Очистка тестовых данных**:
   После завершения тестирования вы можете очистить тестовые данные, выполнив следующую команду:

   ```
   DROP TABLE testDB;
   ```