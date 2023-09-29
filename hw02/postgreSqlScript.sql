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
                                	"name" varchar(255) NOT NULL UNIQUE,
                                	"address" varchar(255) NOT NULL,
                                	"description" TEXT NOT NULL,
                                	CONSTRAINT "composition_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу для номенклатурных позиций
 */
CREATE TABLE IF NOT EXISTS irk_.item (
                                	"id" serial NOT NULL,
                                	"catalogue_number" varchar(255) NOT NULL,
                                	"name" varchar(255) NOT NULL,
                                	"fk_batch" integer NOT NULL,
                                	"fk_composition" integer NOT NULL,
                                	"fk_manufacturer" integer NOT NULL,
                                	"fk_status" integer NOT NULL,
                                	"description" TEXT NOT NULL,
                                	CONSTRAINT "item_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу производителей
 */
CREATE TABLE IF NOT EXISTS irk_.manufacturer (
                                	"id" serial NOT NULL,
                                	"name" varchar(255) UNIQUE NOT NULL,
                                	"phone" varchar(255) UNIQUE NOT NULL,
                                	"address" varchar(255) NOT NULL,
                                	"description" TEXT NOT NULL,
                                	CONSTRAINT "manufacturer_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу сотрудников
 */
CREATE TABLE IF NOT EXISTS irk_.worker (
                                	"id" serial NOT NULL,
                                	"first_name" varchar(255) NOT NULL,
                                	"middle_name" varchar(255) NOT NULL,
                                	"last name" varchar(255),
                                	"phone" varchar(255) UNIQUE,
                                	"fk_position" integer NOT NULL,
                                	"description" TEXT NOT NULL,
                                	CONSTRAINT "worker_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу для хранения статуса номенклатурной позиции
 */
CREATE TABLE IF NOT EXISTS irk_.status (
                                	"id" serial NOT NULL,
                                	"name" varchar(255) UNIQUE,
                                	"description" TEXT NOT NULL,
                                	CONSTRAINT "status_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу поставщиков
 */
CREATE TABLE IF NOT EXISTS irk_.provider (
                               	"id" serial NOT NULL,
                               	"name" varchar(255) UNIQUE,
                               	"phone" varchar(255) UNIQUE,
                               	"address" TEXT,
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
                                	"position" varchar(255),
                                	"description" TEXT NOT NULL,
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
                                	"time" TIME,
                                	CONSTRAINT "item_history_pk" PRIMARY KEY ("id")
                                ) WITH (
                                  OIDS=FALSE
                                );

/*
 Создаем таблицу операций с номенклатурной позицией
 */
CREATE TABLE IF NOT EXISTS irk_.operation (
                               	"id" serial NOT NULL,
                               	"name" varchar(255) UNIQUE,
                               	"description" TEXT NOT NULL,
                               	CONSTRAINT "operation_pk" PRIMARY KEY ("id")
                               ) WITH (
                                 OIDS=FALSE
                               );

/*
 Создаем таблицу ролей должности
 */
CREATE TABLE irk_.role (
                    	"id" serial NOT NULL,
                    	"name" varchar(255) NOT NULL,
                    	CONSTRAINT "role_pk" PRIMARY KEY ("id")
                    ) WITH (
                      OIDS=FALSE
                    );

/*
 Создаем таблицу партии
 */
CREATE TABLE irk_.batch (
                    	"id" serial NOT NULL,
                    	"fk_provider" integer NOT NULL,
                    	CONSTRAINT "batch_pk" PRIMARY KEY ("id")
                    ) WITH (
                      OIDS=FALSE
                    );

/*
Создаем таблицу цен
*/
CREATE TABLE irk_.price (
                    	"fk_item" integer NOT NULL,
                    	"price" integer NOT NULL
                    ) WITH (
                      OIDS=FALSE
                    );

/*
 Создаем связи между сущностями.
 */
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk0" FOREIGN KEY ("fk_batch") REFERENCES irk_.batch("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk1" FOREIGN KEY ("fk_composition") REFERENCES irk_.composition("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk2" FOREIGN KEY ("fk_manufacturer") REFERENCES irk_.manufacturer("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk3" FOREIGN KEY ("fk_status") REFERENCES irk_.status("id");
ALTER TABLE irk_.worker ADD CONSTRAINT "worker_fk0" FOREIGN KEY ("fk_position") REFERENCES irk_.position("id");
ALTER TABLE irk_.position ADD CONSTRAINT "position_fk0" FOREIGN KEY ("fk_role") REFERENCES irk_.role("id");

ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk0" FOREIGN KEY ("fk_operation") REFERENCES irk_.operation("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk1" FOREIGN KEY ("fk_item") REFERENCES irk_.item("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk2" FOREIGN KEY ("fk_worker") REFERENCES irk_.worker("id");
ALTER TABLE irk_.batch ADD CONSTRAINT "batch_fk0" FOREIGN KEY ("fk_provider") REFERENCES irk_.provider("id");
ALTER TABLE irk_.price ADD CONSTRAINT "price_fk0" FOREIGN KEY ("fk_item") REFERENCES irk_.item("id");

/*
Создаем индексы для таблиц
*/
CREATE INDEX item_idx ON irk_.item (catalogue_number);
CREATE INDEX worker_idx ON irk_.worker (fk_position);
