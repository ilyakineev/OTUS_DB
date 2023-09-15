CREATE DATABASE IRK_DB;

/*
 Создаем новую схему
 */
CREATE SCHEMA IF NOT EXISTS irk_;

/*
 Создаем таблицу склада
 */
CREATE TABLE IF NOT EXISTS irk_.composition (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "address" TEXT NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "composition_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу для номенклатурных позиций
 */
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
      );

/*
 Создаем таблицу производителей
 */
CREATE TABLE IF NOT EXISTS irk_.manufacturer (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "phone" VARCHAR(255) NOT NULL UNIQUE,
                               "address" TEXT NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "manufacturer_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу сотрудников
 */
CREATE TABLE IF NOT EXISTS irk_.worker (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "fk_position" integer NOT NULL,
                               "phone" VARCHAR(255) NOT NULL,
                               CONSTRAINT "worker_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу для хранения статуса номенклатурной позиции
 */
CREATE TABLE IF NOT EXISTS irk_.status (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "status_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу поставщиков
 */
CREATE TABLE IF NOT EXISTS irk_.provider (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "phone" VARCHAR(255) NOT NULL,
                               "address" TEXT NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "provider_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу для хранения должностей
 */
CREATE TABLE IF NOT EXISTS irk_.position (
                               "id" serial NOT NULL,
                               "position" VARCHAR(255) NOT NULL,
                               "description" TEXT,
                               "fk_role" integer NOT NULL,
                               CONSTRAINT "position_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
    );

/*
 Создаем таблицу для хранения истории изменений номенклатурной позиции
 */
CREATE TABLE IF NOT EXISTS irk_.item_history (
                               "id" serial NOT NULL,
                               "fk_operation" integer NOT NULL,
                               "fk_item" integer NOT NULL,
                               "fk_worker" integer NOT NULL,
                               "time" DATE NOT NULL,
                               CONSTRAINT "item_history_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу операций с номенклатурной позицией
 */
CREATE TABLE IF NOT EXISTS irk_.operation (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "operation_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Создаем таблицу ролей должности
 */
CREATE TABLE "public.role" (
                               "id" serial NOT NULL,
                               "name" VARCHAR(255) UNIQUE,
                               CONSTRAINT "role_pk" PRIMARY KEY ("id")
) WITH (
       OIDS=FALSE
      );

/*
 Создаем связи между сущностями.
 */
ALTER TABLE irk_.composition ADD CONSTRAINT "composition_fk0" FOREIGN KEY ("fk_worker") REFERENCES irk_.worker("id");
ALTER TABLE irk_.composition ADD CONSTRAINT "composition_fk1" FOREIGN KEY ("fk_item") REFERENCES irk_.item("id");

ALTER TABLE irk_.item ADD CONSTRAINT "item_fk0" FOREIGN KEY ("fk_manufacturer") REFERENCES irk_.manufacturer("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk1" FOREIGN KEY ("fk_status") REFERENCES irk_.status("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk2" FOREIGN KEY ("fk_provider") REFERENCES irk_.provider("id");

ALTER TABLE irk_.worker ADD CONSTRAINT "worker_fk0" FOREIGN KEY ("fk_position") REFERENCES irk_.position("id");

ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk0" FOREIGN KEY ("fk_operation") REFERENCES irk_.operation("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk1" FOREIGN KEY ("fk_item") REFERENCES irk_.item("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk2" FOREIGN KEY ("fk_worker") REFERENCES irk_.worker("id");

/*
Создаем индексы для таблиц
*/
CREATE INDEX item_idx ON item (catalogue_number);
CREATE INDEX worker_idx ON worker (name);
