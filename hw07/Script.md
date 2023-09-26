## 1. Базу данных.
[Создание базы данных в Postgresql](https://postgrespro.ru/docs/postgresql/12/manage-ag-createdb)

    CREATE DATABASE IRK_DB;

## 2. Табличные пространства и роли.
 [Табличные пространства в Postgresql](https://postgrespro.ru/docs/postgresql/12/manage-ag-tablespaces)

 `` !! Необходимо подготовить пространство на диске и указать путь при создании дискового пространства !!``    

    CREATE TABLESPACE irk_db LOCATION '/irk';
    CREATE TABLESPACE worker_db LOCATION '/worker';

 [Создание роли](https://postgrespro.ru/docs/postgresql/12/sql-createrole)

    CREATE ROLE admin WITH SUPERUSER CREATEROLE PASSWORD 'jw8s0F4';
    CREATE ROLE devoloper WITH CREATEDB PASSWORD 'devoloper' CONNECTION LIMIT 3;
    CREATE ROLE analyst WITH CREATEDB PASSWORD 'analyst' VALID UNTIL '2024-01-01';
    
## 3. Схему данных.
[Создание схемы в Postgresql](https://postgrespro.ru/docs/postgresql/12/ddl-schemas#DDL-SCHEMAS-CREATE)
    
    CREATE SCHEMA IF NOT EXISTS irk_;
    CREATE SCHEMA IF NOT EXISTS worker_;

## 4. Таблицы своего проекта, распределив их по схемам и табличным пространствам.

### 4.1 Схема irk_   

#### Создаем таблицу склада

    CREATE TABLE IF NOT EXISTS irk_.composition (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "address" TEXT NOT NULL,
        "description" TEXT,
        CONSTRAINT "composition_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;

#### Создаем таблицу для номенклатурных позиций

    CREATE TABLE IF NOT EXISTS irk_.item (
        "id" serial NOT NULL,
        "catalogue_number" VARCHAR(255) NOT NULL UNIQUE,
        "name" VARCHAR(255) NOT NULL,
        "fk_manufacturer" integer NOT NULL,
        "fk_status" integer NOT NULL,
        "fk_provider" integer NOT NULL,
        "fk_composition" integer NOT NULL,
        "description" TEXT,
        CONSTRAINT "item_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;


#### Создаем таблицу производителей

    CREATE TABLE IF NOT EXISTS irk_.manufacturer (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "phone" VARCHAR(255) NOT NULL UNIQUE,
        "address" TEXT NOT NULL,
        "description" TEXT,
        CONSTRAINT "manufacturer_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;

#### Создаем таблицу для хранения статуса номенклатурной позиции

    CREATE TABLE IF NOT EXISTS irk_.status (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "description" TEXT,
        CONSTRAINT "status_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;


#### Создаем таблицу поставщиков

    CREATE TABLE IF NOT EXISTS irk_.provider (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "phone" VARCHAR(255) NOT NULL,
        "address" TEXT NOT NULL,
        "description" TEXT,
        CONSTRAINT "provider_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;

#### Создаем таблицу для хранения истории изменений номенклатурной позиции

    CREATE TABLE IF NOT EXISTS irk_.item_history (
        "id" serial NOT NULL,
        "fk_operation" integer NOT NULL,
        "fk_item" integer NOT NULL,
        "fk_worker" integer NOT NULL,
        "time" DATE NOT NULL,
        CONSTRAINT "item_history_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;

#### Создаем таблицу операций с номенклатурной позицией

    CREATE TABLE IF NOT EXISTS irk_.operation (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "description" TEXT,
        CONSTRAINT "operation_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE irk_db;

### 4.2 Схема worker_    

#### Создаем таблицу сотрудников

    CREATE TABLE IF NOT EXISTS worker_.worker (
        "id" serial NOT NULL,
        "name" VARCHAR(255) NOT NULL,
        "fk_position" integer NOT NULL,
        "phone" VARCHAR(255) NOT NULL,
        CONSTRAINT "worker_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE worker_db


#### Создаем таблицу для хранения должностей

    CREATE TABLE IF NOT EXISTS worker_.position (
        "id" serial NOT NULL,
        "position" VARCHAR(255) NOT NULL,
        "description" TEXT,
        "fk_role" integer NOT NULL,
        CONSTRAINT "position_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE worker_db;

#### Создаем таблицу ролей должности

    CREATE TABLE IF NOT EXISTS worker_.role" (
        "id" serial NOT NULL,
        "name" VARCHAR(255) UNIQUE,
        CONSTRAINT "role_pk" PRIMARY KEY ("id")
    ) WITH (
        OIDS=FALSE
    ) TABLESPACE worker_db