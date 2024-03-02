# Домашнее задание
MongoDB
## Цель:
В результате выполнения ДЗ вы научитесь разворачивать MongoDB, заполнять данными и делать запросы.
## Описание/Пошаговая инструкция выполнения домашнего задания:

Необходимо:

установить MongoDB одним из способов: ВМ, докер;
заполнить данными;
написать несколько запросов на выборку и обновление данных
Сдача ДЗ осуществляется в виде миниотчета.

Задание повышенной сложности*
создать индексы и сравнить производительность.

## Критерии оценки:

задание выполнено - 10 баллов
предложено красивое решение - плюс 2 балла
предложено рабочее решение, но не устранены недостатки, указанные преподавателем - минус 2 балла
плюс 5 баллов за задание со звездочкой*

## Решение:

# Шаг 1: Запуск сервисов Docker, определенных в файле [docker-compose.yml](docker/docker-compose.yml) 
```shell
docker-compose -f docker/docker-compose.yml up
```

# Шаг 2: Вывод списка всех запущенных контейнеров Docker
```shell
docker ps
```

```
➜  hw40 git:(main) ✗ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                      NAMES
629c94964182   mongo:latest   "docker-entrypoint.s…"   12 seconds ago   Up 11 seconds   0.0.0.0:27017->27017/tcp   mongodb
```

# Шаг 3: Импорт [данных](docker/initdb/some_customers.csv) в контейнер MongoDB и запуск оболочки Mongosh
```shell
docker exec -it mongodb bash
mongoimport --host localhost --db OTUS --collection user --type csv --file some_customers.csv --headerline
mongosh
```

```
➜  hw40 git:(main) ✗ docker exec -it mongodb bash
mongoimport --host localhost --db OTUS --collection user --type csv --file some_customers.csv --headerline
mongosh
root@629c94964182:/# mongoimport --host localhost --db OTUS --collection user --type csv --file some_customers.csv --headerline
2024-03-02T10:12:46.502+0000    connected to: mongodb://localhost/
2024-03-02T10:12:46.530+0000    1154 document(s) imported successfully. 0 document(s) failed to import.
root@629c94964182:/# mongosh
Current Mongosh Log ID: 65e2fb9e074c609d6dcccd3c
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.5
Using MongoDB:          7.0.6
Using Mongosh:          2.1.5

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2024-03-02T10:12:06.238+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2024-03-02T10:12:06.921+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
   2024-03-02T10:12:06.921+00:00: /sys/kernel/mm/transparent_hugepage/enabled is 'always'. We suggest setting it to 'never'
   2024-03-02T10:12:06.921+00:00: vm.max_map_count is too low
------

test> 

```

# Шаг 4: Переключение на базу данных OTUS в оболочке Mongosh
```shell
use OTUS
```

```
test> use OTUS
switched to db OTUS
```

# Шаг 5: Выполнение операций над коллекцией 'user'

# Поиск всех документов в коллекции 'user'
```shell
db.user.find()
```
Результат:
```shell
OTUS> db.user.find()
[
  {
    _id: ObjectId('65e2fb9e19c5026f9f255b5e'),
    title: 'Dr.',
    first_name: 'Danilo',
    last_name: 'Ambrosini',
    correspondence_language: 'IT',
    birth_date: '1900-01-01',
    gender: 'Unknown',
    marital_status: '',
    country: 'IT',
    postal_code: 21100,
    region: '',
    city: 'Varese',
    street: 'Via dolomiti',
    building_number: 13
  }, 
  
  ...
  
  {
    _id: ObjectId('65e2fb9e19c5026f9f255b71'),
    title: '',
    first_name: '',
    last_name: 'Haugen pål',
    correspondence_language: 'NO',
    birth_date: '1900-01-01',
    gender: 'Unknown',
    marital_status: '',
    country: 'NO',
    postal_code: 4280,
    region: '',
    city: 'Skudeneshavn',
    street: 'Alterfjellet 18b',
    building_number: ''
  }
]
```

# Вставка нового документа в коллекцию 'user'
```shell
db.user.insertOne({
_id: ObjectId('65e2f9a8b8afc9a23e46ae86'),
title: 'Frau',
first_name: 'Susann',
last_name: 'Wiffler',
correspondence_language: 'DE',
birth_date: '1900-01-01',
gender: 'Female',
marital_status: '',
country: 'DE',
postal_code: 65201,
region: '',
city: 'Wiesbaden',
street: 'Rheingaustr 16',
building_number: ''
})
```
Результат:
```shell
OTUS> db.user.insertOne({
... _id: ObjectId('65e2f9a8b8afc9a23e46ae86'),
... title: 'Frau',
... first_name: 'Susann',
... last_name: 'Wiffler',
... correspondence_language: 'DE',
... birth_date: '1900-01-01',
... gender: 'Female',
... marital_status: '',
... country: 'DE',
... postal_code: 65201,
... region: '',
... city: 'Wiesbaden',
... street: 'Rheingaustr 16',
... building_number: ''
... })
{
  acknowledged: true,
  insertedId: ObjectId('65e2f9a8b8afc9a23e46ae86')
}
```

# Обновление документа в коллекции 'user'
```shell
db.user.updateOne(
{ _id: ObjectId('65e2f9a8b8afc9a23e46ae86') }, // Условие выборки документа для изменения
{ $set: { postal_code: 12345 } } // Поля для обновления и их новые значения
)
```
Результат:
```shell
OTUS> db.user.updateOne(
... { _id: ObjectId('65e2f9a8b8afc9a23e46ae86') }, // Условие выборки документа для изменения
... { $set: { postal_code: 12345 } } // Поля для обновления и их новые значения
... )
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```

# Удаление документа из коллекции 'user'
```shell
db.user.deleteOne({ _id: ObjectId('65e2f9a8b8afc9a23e46ae86') })
```
Результат:
```shell
OTUS> db.user.deleteOne({ _id: ObjectId('65e2f9a8b8afc9a23e46ae86') })
{ acknowledged: true, deletedCount: 1 }
```