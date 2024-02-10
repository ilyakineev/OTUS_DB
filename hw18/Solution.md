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

```shell
cd docker/
```
1. **Запуск docker-compose в папке ../docker:**
```shell
docker-compose -f ./docker/docker-compose.yml up -d
```
Если есть нужда удалить контейнеры
```shell
docker-compose down
```   
Если перезапустить
```shell
docker-compose restart 
```

2. **Проверка запушенных контейнеров**
```shell
docker ps 
```

3. **Подключение к командной строке мастера:**
```bash
docker exec -it primary bash
```
Вход в интерактивную оболочку PostgreSQL от имени пользователя student.
```shell
psql -U student -d primary_db
```

Создаем пользователяч для репликации
```shell
create user replica with replication encrypted password 'replica_pas';
```

Необходимо поправить postgresql.conf для primary
 
```

```

Необходимо поправить postgresql.conf для replica

```

```

4. **Подключение к командной строке реплики:**
    ```bash
    docker exec -it replica bash
    ```
   Вход в интерактивную оболочку PostgreSQL от имени пользователя student.
    ```shell
    psql -U student -d replica_db
    ```

5. **Проверка, является ли сервер мастером или репликой:**
    ```sql
    select pg_is_in_recovery();
    ```

6. **Вывод информации о состоянии репликации:**
    ```sql
    select * from pg_stat_replication;
    ```

7. **Вывод списка баз данных:**
    ```shell
    \l
    ```

8. **Вывод списка пользователей:**
    ```shell
    \du
    ```

9. **Создание каталога для репликации:**
    ```shell
    rm -rf /var/lib/postgresql/data/*
    ```

10. **Использование pg_basebackup для создания реплики:**
    ```shell
    pg_basebackup -h primary -U student -D /var/lib/postgresql/data -P -Xs -R
    ```

Эти скрипты предполагают, что вы уже находитесь в нужной директории перед выполнением каждой команды. Убедитесь, что у
вас установлен Docker и Docker Compose для успешного выполнения этих операций.

запускаме обновление системы и установку некоторых утилит
```shell
apt update
apt install sysv-rc
apt install sudo
sudo pg_createcluster 16 main
```

1) **Подключение к командной строке мастера:**
```bash
docker exec -it primary bash
```

От имини пользователя postgres мы создаем пользователя для репликации
```shell
su - postgres
createuser --replication -P rep_user
```

Ввводим параль password для нового пользователя c с паролем password
```shell
postgres@047f1db57f98:~$ createuser --replication -P rep_user
Enter password for new role: 
Enter it again: 
```

Далее, смотрим расположение conf файла:
```shell
psql -c 'SHOW config_file;'

               config_file                
------------------------------------------
 /var/lib/postgresql/data/postgresql.conf
(1 row)
```

в файл postgresql.conf вводим 
```
wal_level = replica
max_wal_senders = 2
max_replication_slots = 2
hot_standby = on
hot_standby_feedback = on
```

в файл pg_hba.conf вводим
```
host replication rep_user 0.0.0.0:5434 scram-sha-256
```

Перезапустим postgresql
```shell
docker restart primary
```

Переходим на настройку replica

```shell
docker exec -it replica bash
```

Удаляем содержимое 
```shell
rm -r var/lib/postgresql/data/*
```






Настройка бэкапа primary 
```bash
docker exec -it primary bash
```
Переключаемся на имя другого пользователя
```shell
su - postgres
```
Выполняем ёбэкап
```bash
pg_basebackup --pgdata=/basebackup -R
```
"-R" сформирует настройки для репликации


```shell
docker exec -it primary su - postgres 
```

Копируем бэкап из одной директории в другую
```shell
docker stop replica
rm -rf replica/data/postgresql/
mv primary/data/basebackup/ replica/data/postgresql/
docker restart replica
chown -R postgres:postgres 
```

```shell
docker exec -it primary su - postgres 
pg_createcluster 16 replica
pg_ctlcluster 16 replica start
```