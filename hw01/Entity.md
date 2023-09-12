## Описание суженостей БД

[Схема сущностей БД](Entity.png)

[Скрипты создания схемы и таблиц БД](postgreSqlScript.sql)

### 1. Склад - composition
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _address_ - Aдресс, TEXT NOT NULL
* _fk_worker_ - Идентификатор сотрудника, INTEGER NOT NULL
* _fk_item_ - Идентификаторы номенклатурных позиций, INTEGER NOT NULL
* _description_ - Описание,  TEXT

### 2. Номенклатурная позиция - item
* _id_ - Идентификатор записи, serial NOT NULL
* _catalogue_number_ - Каталожный номер, VARCHAR(255) NOT NULL,
* _name_ - Наименование, VARCHAR(255) NOT NULL,
* _fk_manufacturer_ - Идентификатор производителя, INTEGER NOT NULL,
* _fk_status_ - Статус номенклатурной позиции, INTEGER NOT NULL,
* _fk_provider_ - Поставщик, INTEGER NOT NULL,
* _description_ - Описание,  TEXT

### 3. Производитель - manufacturer
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,
* _address_ - Aдресс, TEXT NOT NULL
* _description_ - Описание, TEXT

### 4. Сотрудник - worker
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _fk_position_ - Идентификатор долджность, INTEGER NOT NULL,
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,

### 5. Статус номенклатурной позиции - status
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _description_ - Описание, TEXT

### 6. Поставщик - provider
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,
* _address_ - Aдресс, TEXT NOT NULL
* _description_ - Описание, TEXT
 
### 7. Должность - position
* _id_ - Идентификатор записи, serial NOT NULL
* _position_ - Долджность, VARCHAR(255) NOT NULL,
* _description_ - Описание, TEXT

### 8. История номенклатурной позиции - item_history
* _id_ - Идентификатор записи, serial NOT NULL
* _fk_operation_ - Идентификатор операция, INTEGER NOT NULL,
* _fk_item_ - Идентификатор номенклатурной позиции, INTEGER NOT NULL,
* _fk_worker_ - Идентификатор сотрудника, INTEGER NOT NULL,
* _time_ - Время выполнения операции, DATE NOT NULL

### 9. Операция над номенклатурной позицией - operation
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Наименование операции, VARCHAR(255) NOT NULL
* _description_ - Описание, TEXT