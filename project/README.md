### Запускаем docker-compose для тестирования
```shell
docker-compose -f docker/docker-compose.yml up -d
```

### Запускаем приложение ИРК (Пока пропускаем)
```shell
gradle bootrun
```

### Проверяем запущенные контейнеры
```shell
docker ps
```

### Для создания бэкапа заходим в контейнер
```shell
docker exec -it IRK /bin/bash
```

### Переходим в каталог с бэкапами
```shell
cd /basebackup/
```

### Проверяем содержимое каталога
```shell
ls -l
```

### Запускаем скрипт для создания бэкапа
```shell
sh backup.sh
```