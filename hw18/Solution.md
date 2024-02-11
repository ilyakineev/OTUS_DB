# Домашнее задание

Делаем физическую и логическую репликации

## Цель:

После домашнего задания вы сможете настраивать физическую и логическую репликации самостоятельно

## Описание/Пошаговая инструкция выполнения домашнего задания:

### Физическая репликация:

Весь стенд собирается в Docker образах или ВМ. Необходимо:

* Настроить физическую репликации между двумя кластерами базы данных
* Репликация должна работать использую "слот репликации"
* Реплика должна отставать от мастера на 5 минут

### Логическая репликация:

В стенд добавить еще один кластер Postgresql. Необходимо:

* Создать на первом кластере базу данных, таблицу и наполнить ее данными (на ваше усмотрение)
* На нем же создать публикацию этой таблицы
* На новом кластере подписаться на эту публикацию
* Убедиться что она среплицировалась. Добавить записи в эту таблицу на основном сервере и убедиться, что они видны на
  логической реплике
  Версия PostgreSQL на ваше усмотрение

### Решение

#### Физическая репликация

Да, конечно. Вот пошаговые скрипты для выполнения указанных операций:

## Пошаговая инструкция для настройки репликации в PostgreSQL с использованием Docker

### 1. Запуск контейнеров

```shell
docker-compose -f docker/docker-compose.yml up
```

### 2. Проверка запущенных контейнеров

```shell
docker ps
```

### 3. Вход в контейнер primary

```shell
docker exec -it primary bash
```

### 4. Создание пользователя для репликации

```shell
su - postgres
createuser --replication -P repluser
```

Запоминаем пароль.

### 5. Настройка параметров конфигурации PostgreSQL

Открываем файл postgresql.conf и добавляем следующие строки:

```conf
wal_level = replica
max_wal_senders = 2
max_replication_slots = 2
hot_standby = on
hot_standby_feedback = on
```

### 6. Просмотр подсети Docker

```shell
docker network inspect bridge | grep Subnet
```

Ожидаемый результат:
```
  "Subnet": "172.17.0.0/16",
```

### 7. Добавление строки в файл pg_hba.conf

```conf
host replication all 172.17.0.2/16 trust
```

### 8. Перезапуск контейнера primary

```shell
docker restart primary
```

### 9.Делаем pg_basebackup внутри контейнера primary
```shell
pg_basebackup -h primary -U repluser -D /basebackup -P -Xs -R
```

### 10. Обновление данных на реплике

```shell
rm -rf docker/replica/data/postgresql 
cp -r docker/primary/data/basebackup docker/replica/data/postgresql/
```

На primary_db можно проверить состояние репликации

```sql
select * from pg_stat_replication;
```

```
pid|usesysid|usename |application_name|client_addr|client_hostname|client_port|backend_start                |backend_xmin|state    |sent_lsn |write_lsn|flush_lsn|replay_lsn|write_lag      |flush_lag      |replay_lag     |sync_priority|sync_state|reply_time                   |
---+--------+--------+----------------+-----------+---------------+-----------+-----------------------------+------------+---------+---------+---------+---------+----------+---------------+---------------+---------------+-------------+----------+-----------------------------+
 80|   16389|repluser|walreceiver     |172.21.0.3 |               |      38464|2024-02-11 15:58:02.450 +0300|747         |streaming|0/30136B8|0/30136B8|0/30136B8|0/30136B8 |00:00:00.000908|00:00:00.001365|00:00:00.001366|            0|async     |2024-02-11 16:00:12.730 +0300|```
```

```sql
select * from pg_stat_wal_receiver
```
```
 pid|status   |receive_start_lsn|receive_start_tli|written_lsn|flushed_lsn|received_tli|last_msg_send_time           |last_msg_receipt_time        |latest_end_lsn|latest_end_time              |slot_name|sender_host|sender_port|conninfo                                                                                                                                                                                                                                                       |
---+---------+-----------------+-----------------+-----------+-----------+------------+-----------------------------+-----------------------------+--------------+-----------------------------+---------+-----------+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
 30|streaming|0/3000000        |                1|0/30136B8  |0/30136B8  |           1|2024-02-11 16:00:12.728 +0300|2024-02-11 16:00:12.729 +0300|0/30136B8     |2024-02-11 16:00:12.728 +0300|         |primary    |       5432|user=repluser passfile=/root/.pgpass channel_binding=prefer dbname=replication host=primary port=5432 fallback_application_name=walreceiver sslmode=prefer sslcompression=0 sslcertmode=allow sslsni=1 ssl_min_protocol_version=TLSv1.2 gssencmode=prefer krbsr|
```
