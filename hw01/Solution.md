# Сущности БД

## Описание суженостей БД

Инструментально-раздаточные кладовые относятся к вспомогательным службам цеха. Их назначение — получение с центрального склада инструмента, оснастки, приспособлений, необходимых для производственных процессов. В ИРК организуется хранение инструмента, его учет, выдача рабочим. Инструментальная кладовая оборудуется в отдельном помещении, оснащенном специальными системами хранения.

* Упорядочивание хранения большого объема инструмента и оснастки для станков ЧПУ.
* Упорядочивание выдачи/сдачи инструмента ответственным лицам.
* Обеспечение контроля за исправностью инструмента.
* Повышение эффективности производственного процесса за счет быстрого обеспечения рабочих необходимыми инструментами.

### Склад - composition

* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _address_ - Aдресс, TEXT NOT NULL
* _worker_ids_ - Идентификатор сотрудника, serial NOT NULL
* _item_ids_ - Идентификаторы номенклатурных позиций, serial NOT NULL
* _description_ - Описание,  TEXT

### Номенклатурная позиция - item
* _id_ - Идентификатор записи, serial NOT NULL
* _catalogue_number_ - Каталожный номер, VARCHAR(255) NOT NULL,
* _name_ - Наименование, VARCHAR(255) NOT NULL,
* _manufacturer_id_ - Идентификатор производителя, serial NOT NULL,
* _status_id_ - Статус номенклатурной позиции, serial NOT NULL,
* _provider_id_ - Поставщик, serial NOT NULL,
* _description_ - Описание,  TEXT

### Производитель - manufacturer
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,
* _address_ - Aдресс, TEXT NOT NULL
* _description_ - Описание, TEXT

### Сотрудник - worker
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _position_id_ - Идентификатор долджность, serial NOT NULL,
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,

### Статус номенклатурной позиции - status
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _description_ - Описание, TEXT

### Поставщик - provider
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Имя склада, VARCHAR(255) NOT NULL
* _phone_ - Контактный телефон, VARCHAR(255) NOT NULL UNIQUE,
* _address_ - Aдресс, TEXT NOT NULL
* _description_ - Описание, TEXT
 
### Должность - position
* _id_ - Идентификатор записи, serial NOT NULL
* _position_ - Долджность, VARCHAR(255) NOT NULL,
* _description_ - Описание, TEXT

### История номенклатурной позиции - item_history
* _id_ - Идентификатор записи, serial NOT NULL
* _operation_id_ - Идентификатор операция, serial NOT NULL,
* _item_id_ - Идентификатор номенклатурной позиции, serial NOT NULL,
* _worker_id_ - Идентификатор сотрудника, serial NOT NULL,
* _time_ - Время выполнения операции, DATE NOT NULL

### Операция над номенклатурной позицией - operation
* _id_ - Идентификатор записи, serial NOT NULL
* _name_ - Наименование операции, VARCHAR(255) NOT NULL
* _description_ - Описание, TEXT