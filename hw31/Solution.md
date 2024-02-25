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


```shell
docker ps 
```

```shell
docker build -t my_sql_image ./docker
```

```shell
docker run -d -p 3306:3306 --name my_sql my_sql_image
```

```shell
docker exec -it my_sql /bin/bash
```

```shell
mysql -u root
```

```sql
CREATE DATABASE world;
```

```sql
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
```

```sql
GRANT ALL PRIVILEGES ON world.* TO 'user'@'localhost';
```

```sql
FLUSH PRIVILEGES;
```

```sql
USE world;
```

```sql
SHOW TABLES;
```

```
mysql> show tables;
Empty set (0.00 sec)
```

```sql
EXIT
```

```shell
cd path/inside/container/ 
```

```shell
root@954c7e4eaf2b:/path/inside/container# ls -l
total 1784
-rw-r--r-- 1 root root 1826104 Feb 23 05:38 backup_des.xbstream.gz-195395-1e696d.des3
```

```shell
root@954c7e4eaf2b:/path/inside/container# openssl des3 -d -salt -k "password" -in backup_des.xbstream.gz-195395-1e696d.des3 | gunzip > backup.xbstream
*** WARNING : deprecated key derivation used.
Using -iter or -pbkdf2 would be better.
root@954c7e4eaf2b:/path/inside/container# ls -l
total 73992
-rw-r--r-- 1 root root 73938960 Feb 25 11:00 backup.xbstream
-rw-r--r-- 1 root root  1826104 Feb 23 05:38 backup_des.xbstream.gz-195395-1e696d.des3
```

```shell
mkdir "backup"
xbstream -x -C backup/ < backup.xbstream
```

```shell
cd ..
xtrabackup --prepare --target-dir=backup/
```
```shell
rm -r /var/lib/mysql
xtrabackup --copy-back --target-dir=backup/ --datadir=/var/lib/mysql
```

```shell
chown -R mysql:mysql /var/lib/mysql
```

```shell
exit
```

```shell
docker restart my_sql
```

```shell
docker exec -it my_sql /bin/bash
```

```shell
mysql -u root
```

```sql
USE world;
```

```sql
SHOW TABLES;
```

```sql
mysql> select count(*) from city where countrycode = 'RUS';
+----------+
| count(*) |
+----------+
|      189 |
+----------+
1 row in set (0.02 sec)
```