## Описание суженостей БД

### 1. Склад - composition
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _address_ - Aдресс, TEXT NOT NULL
* _worker_ids_ - Идентификатор сотрудника, serial NOT NULL
* _item_ids_ - Идентификаторы номенклатурных позиций, serial NOT NULL
* _description_ - Описание,  TEXT

### 2. Номенклатурная позиция - item
* _id_ - Идентификатор записи, serial NOT NULL
* _catalogue_number_ - Каталожный номер, VARCHAR(255) NOT NULL,
* _name_ - Наименование, VARCHAR(255) NOT NULL,
* _manufacturer_id_ - Идентификатор производителя, serial NOT NULL,
* _status_id_ - Статус номенклатурной позиции, serial NOT NULL,
* _provider_id_ - Поставщик, serial NOT NULL,
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
* _position_id_ - Идентификатор долджность, serial NOT NULL,
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
* _operation_id_ - Идентификатор операция, serial NOT NULL,
* _item_id_ - Идентификатор номенклатурной позиции, serial NOT NULL,
* _worker_id_ - Идентификатор сотрудника, serial NOT NULL,
* _time_ - Время выполнения операции, DATE NOT NULL

### 9. Операция над номенклатурной позицией - operation
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Наименование операции, VARCHAR(255) NOT NULL
* _description_ - Описание, TEXT