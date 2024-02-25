# Домашнее задание
Восстановить таблицу из бэкапа
## Цель:

* В этом ДЗ осваиваем инструмент для резервного копирования и восстановления - xtrabackup. Задача восстановить конкретную таблицу из сжатого и шифрованного бэкапа.

## Описание/Пошаговая инструкция выполнения домашнего задания:

* В материалах приложен файл бэкапа backup_des.xbstream.gz.des3 и дамп структуры базы world-db.sql
  Бэкап выполнен с помощью команды:
  sudo xtrabackup --backup --stream=xbstream
  --target-dir=/tmp/backups/xtrabackup/stream
  | gzip - | openssl des3 -salt -k "password" \

    stream/backup_des.xbstream.gz.des3
    Требуется восстановить таблицу world.city из бэкапа и выполнить оператор:
    select count(*) from city where countrycode = 'RUS';
    Результат оператора написать в чат с преподавателем.

## Критерии оценки:

9 баллов - задание выполнено, но есть недочеты
10 баллов - задание выполнено в полном объеме

## Решение:

Понял вас, вот исправленные комментарии с учётом ваших указаний:

### Вывод списка всех работающих контейнеров Docker.
```shell
docker ps 
```

### Построение Docker-образа из Dockerfile в каталоге "./docker" и назначение ему имени "my_sql_image".
```shell
docker build -t my_sql_image ./docker
```

### Запуск контейнера с образом "my_sql_image", проброс порта 3306 хоста на порт 3306 контейнера и назначение контейнеру имени "my_sql".
```shell
docker run -d -p 3306:3306 --name my_sql my_sql_image
```

### Вход в контейнер "my_sql" с использованием интерактивной оболочки.
```shell
docker exec -it my_sql /bin/bash
```

### Подключение к серверу MySQL, используя пользователя root.
```shell
mysql -u root
```

### Создание новой базы данных с именем "world".
```sql
CREATE DATABASE world;
```

### Создание нового пользователя с именем "user", имеющего доступ только с локального хоста и использующего пароль "password".
```sql
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
```

### Предоставление пользователю "user" всех привилегий для работы с базой данных "world".
```sql
GRANT ALL PRIVILEGES ON world.* TO 'user'@'localhost';
```

### Применение всех изменений в привилегиях, сделанных в этом сеансе.
```sql
FLUSH PRIVILEGES;
```

### Выбор базы данных "world" для использования.
```sql
USE world;
```

### Показ списка таблиц в базе данных.
```sql
SHOW TABLES;
```

### Выход из интерактивной оболочки MySQL.
```sql
EXIT
```

### Переход в указанный каталог внутри контейнера.
```shell
cd path/inside/container/ 
```

### Показ списка файлов и папок в текущем каталоге внутри контейнера.
```shell
root@954c7e4eaf2b:/path/inside/container# ls -l
total 1784
-rw-r--r-- 1 root root 1826104 Feb 23 05:38 backup_des.xbstream.gz-195395-1e696d.des3
```

### Расшифровка и распаковка архива с помощью OpenSSL.
```shell
root@954c7e4eaf2b:/path/inside/container# openssl des3 -d -salt -k "password" -in backup_des.xbstream.gz-195395-1e696d.des3 | gunzip > backup.xbstream
```

### Показ обновленного списка файлов и папок в текущем каталоге.
```shell
root@954c7e4eaf2b:/path/inside/container# ls -l
total 73992
-rw-r--r-- 1 root root 73938960 Feb 25 11:00 backup.xbstream
-rw-r--r-- 1 root root  1826104 Feb 23 05:38 backup_des.xbstream.gz-195395-1e696d.des3
```

### Создание новой папки "backup" и извлечение содержимого архива в неё.
```shell
mkdir "backup"
xbstream -x -C backup/ < backup.xbstream
```

### Подготовка данных для восстановления с помощью инструмента xtrabackup.
```shell
cd ..
xtrabackup --prepare --target-dir=backup/
```

### Удаление старых данных MySQL и копирование восстановленных данных на их место.
```shell
rm -r /var/lib/mysql
xtrabackup --copy-back --target-dir=backup/ --datadir=/var/lib/mysql
```

### Установка прав владельца на директорию MySQL.
```shell
chown -R mysql:mysql /var/lib/mysql
```

### Выход из оболочки контейнера.
```shell
exit
```

### Перезапуск контейнера с именем "my_sql".
```shell
docker restart my_sql
```

### Вход в контейнер "my_sql" с использованием интерактивной оболочки.
```shell
docker exec -it my_sql /bin/bash
```

### Подключение к серверу MySQL, использование пользователя root.
```shell
mysql -u root
```

### Выбор базы данных "world" для использования.
```sql
USE world;
```

### Показ списка таблиц в базе данных.
```sql
SHOW TABLES;
```

### Выполнение запроса к базе данных, возвращающего количество городов с кодом страны "RUS".
```sql
mysql> select count(*) from city where countrycode = 'RUS';
+----------+
| count(*) |
+----------+
|      189 |
+----------+
1 row in set (0.02 sec)
```

