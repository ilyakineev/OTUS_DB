
/*
 Создаем новую схему
 */
CREATE SCHEMA IF NOT EXISTS irk_;

/*
 Склад
 */
CREATE TABLE IF NOT EXISTS irk_.composition (
                                      "id" serial NOT NULL,
                                      "name" VARCHAR(255) NOT NULL,
                                      "address" TEXT NOT NULL,
                                      "worker_ids" integer NOT NULL,
                                      "item_ids" integer NOT NULL,
                                      "description" TEXT,
                                      CONSTRAINT "composition_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Номенклатурная позиция
 */
CREATE TABLE IF NOT EXISTS irk_.item (
                               "id" serial NOT NULL,
                               "catalogue_number" VARCHAR(255) NOT NULL,
                               "name" VARCHAR(255) NOT NULL,
                               "manufacturer_id" integer NOT NULL,
                               "status_id" integer NOT NULL,
                               "provider_id" integer NOT NULL,
                               "description" TEXT,
                               CONSTRAINT "item_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Производитель
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
 Сотрудник
 */
CREATE TABLE IF NOT EXISTS irk_.worker (
                                 "id" serial NOT NULL,
                                 "name" VARCHAR(255) NOT NULL,
                                 "position_id" integer NOT NULL,
                                 "phone" VARCHAR(255) NOT NULL,
                                 CONSTRAINT "worker_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Статус номенклатурной позиции
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
 Поставщик
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
 Должность
 */
CREATE TABLE IF NOT EXISTS irk_.position (
                                   "id" serial NOT NULL,
                                   "position" VARCHAR(255) NOT NULL,
                                   "description" TEXT,
                                   CONSTRAINT "position_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
    );

/*
 История номенклатурной позиции
 */
CREATE TABLE IF NOT EXISTS irk_.item_history (
                                       "id" serial NOT NULL,
                                       "operation_id" integer NOT NULL,
                                       "item_id" integer NOT NULL,
                                       "worker_id" integer NOT NULL,
                                       "time" DATE NOT NULL,
                                       CONSTRAINT "item_history_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );

/*
 Операция над номенклатурной позицией
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
 Связи между сущностями.
 */
ALTER TABLE irk_.composition ADD CONSTRAINT "composition_fk0" FOREIGN KEY ("worker_ids") REFERENCES irk_.worker("id");
ALTER TABLE irk_.composition ADD CONSTRAINT "composition_fk1" FOREIGN KEY ("item_ids") REFERENCES irk_.item("id");

ALTER TABLE irk_.item ADD CONSTRAINT "item_fk0" FOREIGN KEY ("manufacturer_id") REFERENCES irk_.manufacturer("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk1" FOREIGN KEY ("status_id") REFERENCES irk_.status("id");
ALTER TABLE irk_.item ADD CONSTRAINT "item_fk2" FOREIGN KEY ("provider_id") REFERENCES irk_.provider("id");

ALTER TABLE irk_.worker ADD CONSTRAINT "worker_fk0" FOREIGN KEY ("position_id") REFERENCES irk_.position("id");

ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk0" FOREIGN KEY ("operation_id") REFERENCES irk_.operation("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk1" FOREIGN KEY ("item_id") REFERENCES irk_.item("id");
ALTER TABLE irk_.item_history ADD CONSTRAINT "item_history_fk2" FOREIGN KEY ("worker_id") REFERENCES irk_.worker("id");







