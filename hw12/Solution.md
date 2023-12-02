# Домашнее задание

Посчитать кол-во очков по всем игрокам за текущий год и за предыдущий.

## Цель:

Научиться использовать функцию LAG и CTE

## Описание/Пошаговая инструкция выполнения домашнего задания:

### 1. Создайте таблицу и наполните ее данными

```sql
CREATE TABLE statistic(
    player_name VARCHAR(100) NOT NULL,
    player_id INT NOT NULL,
    year_game SMALLINT NOT NULL CHECK (year_game > 0),
    points DECIMAL(12,2) CHECK (points >= 0),
    PRIMARY KEY (player_name,year_game)
);
```

### 2. Заполнить данными

```sql
INSERT INTO
statistic(player_name, player_id, year_game, points)
VALUES
('Mike',1,2018,18),
('Jack',2,2018,14),
('Jackie',3,2018,30),
('Jet',4,2018,30),
('Luke',1,2019,16),
('Jack',3,2019,15),
('Jackie',4,2019,28),
('Jet',5,2019,25),
('Luke',1,2020,19),
('Mike',2,2020,17),
('Jack',3,2020,18),
('Jackie',4,2020,29),
('Jet',5,2020,27);
```

### 3. Написать запрос суммы очков с группировкой и сортировкой по годам

```sql 
SELECT s.year_game as year, SUM(points) as point
    FROM statistic s 
    GROUP by s.year_game
    ORDER by s.year_game 
```

### 4. Написать cte показывающее то же самое

```sql 
SELECT DISTINCT
    year_game as year,
    SUM(points) OVER (PARTITION BY year_game) AS point
FROM statistic
ORDER BY year_game;
```

### 5. Используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий.

```sql
SELECT
    s.player_id as Id,
    s.player_name as Name,
    s.year_game as Yeae,
    s.points as Point, 
    LAG(s.points, 1, 0) OVER (PARTITION BY s.player_id ORDER BY s.year_game) AS prev_year_points
FROM statistic s
```