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

# Для проверки эффективности индексов проведем сравнения поиска по странам

# Выборка всех значений
```shell
OTUS> db.user.find().explain("executionStats")
{
  explainVersion: '1',
  queryPlanner: {
    namespace: 'OTUS.user',
    indexFilterSet: false,
    parsedQuery: {},
    queryHash: '8880B5AF',
    planCacheKey: '8880B5AF',
    maxIndexedOrSolutionsReached: false,
    maxIndexedAndSolutionsReached: false,
    maxScansToExplodeReached: false,
    winningPlan: { stage: 'COLLSCAN', direction: 'forward' },
    rejectedPlans: []
  },
  executionStats: {
    executionSuccess: true,
    nReturned: 1154,
    executionTimeMillis: 1,
    totalKeysExamined: 0,
    totalDocsExamined: 1154,
    executionStages: {
      stage: 'COLLSCAN',
      nReturned: 1154,
      executionTimeMillisEstimate: 0,
      works: 1155,
      advanced: 1154,
      needTime: 0,
      needYield: 0,
      saveState: 1,
      restoreState: 1,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 1154
    }
  },
  command: { find: 'user', filter: {}, '$db': 'OTUS' },
  serverInfo: {
    host: '629c94964182',
    port: 27017,
    version: '7.0.6',
    gitVersion: '66cdc1f28172cb33ff68263050d73d4ade73b9a4'
  },
  serverParameters: {
    internalQueryFacetBufferSizeBytes: 104857600,
    internalQueryFacetMaxOutputDocSizeBytes: 104857600,
    internalLookupStageIntermediateDocumentMaxSizeBytes: 104857600,
    internalDocumentSourceGroupMaxMemoryBytes: 104857600,
    internalQueryMaxBlockingSortMemoryUsageBytes: 104857600,
    internalQueryProhibitBlockingMergeOnMongoS: 0,
    internalQueryMaxAddToSetBytes: 104857600,
    internalDocumentSourceSetWindowFieldsMaxMemoryBytes: 104857600,
    internalQueryFrameworkControl: 'trySbeRestricted'
  },
  ok: 1
}
```
# Поиск по country: 'DE'
```shell
db.user.find({ country: 'DE' }).explain("executionStats")
```

```shell
OTUS> db.user.find({ country: 'DE' }).explain("executionStats")
{
  explainVersion: '1',
  queryPlanner: {
    namespace: 'OTUS.user',
    indexFilterSet: false,
    parsedQuery: { country: { '$eq': 'DE' } },
    queryHash: 'B752FA80',
    planCacheKey: 'B752FA80',
    maxIndexedOrSolutionsReached: false,
    maxIndexedAndSolutionsReached: false,
    maxScansToExplodeReached: false,
    winningPlan: {
      stage: 'COLLSCAN',
      filter: { country: { '$eq': 'DE' } },
      direction: 'forward'
    },
    rejectedPlans: []
  },
  executionStats: {
    executionSuccess: true,
    nReturned: 185,
    executionTimeMillis: 1,
    totalKeysExamined: 0,
    totalDocsExamined: 1154,
    executionStages: {
      stage: 'COLLSCAN',
      filter: { country: { '$eq': 'DE' } },
      nReturned: 185,
      executionTimeMillisEstimate: 0,
      works: 1155,
      advanced: 185,
      needTime: 969,
      needYield: 0,
      saveState: 1,
      restoreState: 1,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 1154
    }
  },
  command: { find: 'user', filter: { country: 'DE' }, '$db': 'OTUS' },
  serverInfo: {
    host: '629c94964182',
    port: 27017,
    version: '7.0.6',
    gitVersion: '66cdc1f28172cb33ff68263050d73d4ade73b9a4'
  },
  serverParameters: {
    internalQueryFacetBufferSizeBytes: 104857600,
    internalQueryFacetMaxOutputDocSizeBytes: 104857600,
    internalLookupStageIntermediateDocumentMaxSizeBytes: 104857600,
    internalDocumentSourceGroupMaxMemoryBytes: 104857600,
    internalQueryMaxBlockingSortMemoryUsageBytes: 104857600,
    internalQueryProhibitBlockingMergeOnMongoS: 0,
    internalQueryMaxAddToSetBytes: 104857600,
    internalDocumentSourceSetWindowFieldsMaxMemoryBytes: 104857600,
    internalQueryFrameworkControl: 'trySbeRestricted'
  },
  ok: 1
}
```

# Устанавливаем индекс по country
```shell
OTUS> db.user.createIndex({ country: 1 })
country_1
```

# Выполняем повторный поиск по country: 'DE'
```shell
OTUS> db.user.find({ country: 'DE' }).explain("executionStats")
{
  explainVersion: '1',
  queryPlanner: {
    namespace: 'OTUS.user',
    indexFilterSet: false,
    parsedQuery: { country: { '$eq': 'DE' } },
    queryHash: 'B752FA80',
    planCacheKey: 'AD016A77',
    maxIndexedOrSolutionsReached: false,
    maxIndexedAndSolutionsReached: false,
    maxScansToExplodeReached: false,
    winningPlan: {
      stage: 'FETCH',
      inputStage: {
        stage: 'IXSCAN',
        keyPattern: { country: 1 },
        indexName: 'country_1',
        isMultiKey: false,
        multiKeyPaths: { country: [] },
        isUnique: false,
        isSparse: false,
        isPartial: false,
        indexVersion: 2,
        direction: 'forward',
        indexBounds: { country: [ '["DE", "DE"]' ] }
      }
    },
    rejectedPlans: []
  },
  executionStats: {
    executionSuccess: true,
    nReturned: 185,
    executionTimeMillis: 4,
    totalKeysExamined: 185,
    totalDocsExamined: 185,
    executionStages: {
      stage: 'FETCH',
      nReturned: 185,
      executionTimeMillisEstimate: 0,
      works: 186,
      advanced: 185,
      needTime: 0,
      needYield: 0,
      saveState: 0,
      restoreState: 0,
      isEOF: 1,
      docsExamined: 185,
      alreadyHasObj: 0,
      inputStage: {
        stage: 'IXSCAN',
        nReturned: 185,
        executionTimeMillisEstimate: 0,
        works: 186,
        advanced: 185,
        needTime: 0,
        needYield: 0,
        saveState: 0,
        restoreState: 0,
        isEOF: 1,
        keyPattern: { country: 1 },
        indexName: 'country_1',
        isMultiKey: false,
        multiKeyPaths: { country: [] },
        isUnique: false,
        isSparse: false,
        isPartial: false,
        indexVersion: 2,
        direction: 'forward',
        indexBounds: { country: [ '["DE", "DE"]' ] },
        keysExamined: 185,
        seeks: 1,
        dupsTested: 0,
        dupsDropped: 0
      }
    }
  },
  command: { find: 'user', filter: { country: 'DE' }, '$db': 'OTUS' },
  serverInfo: {
    host: '629c94964182',
    port: 27017,
    version: '7.0.6',
    gitVersion: '66cdc1f28172cb33ff68263050d73d4ade73b9a4'
  },
  serverParameters: {
    internalQueryFacetBufferSizeBytes: 104857600,
    internalQueryFacetMaxOutputDocSizeBytes: 104857600,
    internalLookupStageIntermediateDocumentMaxSizeBytes: 104857600,
    internalDocumentSourceGroupMaxMemoryBytes: 104857600,
    internalQueryMaxBlockingSortMemoryUsageBytes: 104857600,
    internalQueryProhibitBlockingMergeOnMongoS: 0,
    internalQueryMaxAddToSetBytes: 104857600,
    internalDocumentSourceSetWindowFieldsMaxMemoryBytes: 104857600,
    internalQueryFrameworkControl: 'trySbeRestricted'
  },
  ok: 1
}
```

# Вывод
### Без использования индекса:

- **Количество документов, возвращенных запросом**: 185
- **Общее количество документов, просканированных для выполнения запроса**: 1154
- **Метод выполнения запроса**: COLLSCAN (сканирование всей коллекции)

### После добавления индекса на поле `country`:

- **Количество документов, возвращенных запросом**: 185
- **Общее количество документов, просканированных для выполнения запроса**: 185
- **Метод выполнения запроса**: IXSCAN (поиск с использованием индекса)