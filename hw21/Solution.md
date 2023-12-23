# Домашнее задание

Создаем базу данных MySQL в докере

## Цель:

Упаковка скриптов создания БД в контейнер

## Описание/Пошаговая инструкция выполнения домашнего задания:

* Забрать стартовый репозиторий https://github.com/aeuge/otus-mysql-docker
* Рописать sql скрипт для создания своей БД в init.sql
* Проверить запуск и работу контейнера следую описанию в репозитории

Задания повышенной сложности*
прописать кастомный конфиг - настроить innodb_buffer_pool и другие параметры по желанию
протестить сисбенчем - результат теста приложить в README
Возможные проблемы:
не подключается к
БД - https://stackoverflow.com/questions/19101243/error-1130-hy000-host-is-not-allowed-to-connect-to-this-mysql-server
на m1 не
запускается - https://stackoverflow.com/questions/65456814/docker-apple-silicon-m1-preview-mysql-no-matching-manifest-for-linux-arm64-v8

## Решение:

### [Docker-compose](docker/docker-compose.yml)

### [Настройка сервера MySQL](docker/custom.conf/my.cnf)

### [Настройка и запуск Sysbench](docker/README.md)