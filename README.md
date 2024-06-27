# WBSchool-olap-4_task
CLICKHOUSE (Docker + DDL(USER, ROLE, GRANT, BUFFER TABLE, MATERIALIZED VIEW)
* Задание
  1) Поднять кликхаус в докере
  2) Настроить пользователя администратора
  3) Создать базы для стейджинга, исторических данных, текущих данных и буферных таблиц
  4) Создать роль только для чтения и роль с возможность создавать и заполнять данные в БД стейджинга(stg). Создать двух пользователей с такими правами по умолчанию
  5) Реализовать через буфферную таблицу заполнение stg слоя
  6) Создать матереализованное представление для перемещения данных из stg слоя в слой текущих данных
  7) Смоделировать вставку данных в буфферную таблицу для stg слоя. В конечном итоге данные должны быть заполнены и в stg слое, и в слое текущих данных
     
  Команды для выполнениния пунктов 2-7 включительно, выложить в свой git. Каждый пункт - отдельный файл. Для пункта 7 необходимы скриншоты данных в таблице stg и current слоя

  P.S. просьба делать осмысленную структуру таблицы(поля). Их может быть 3-4, но чтобы они могли нести какую то потенциально полезную информацию

* Решение.
  1) Выполнил в wsl консоли  ```docker run -d -p 8123:8123 -p9000:9000 --name some-clickhouse-server --ulimit nofile=262144:262144 clickhouse/clickhouse-server```
     После создал подключение в dataGrip.
  2) Создаем пользователя и добавляем ему права. [файл с кодом 1](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/2_point_admin_create.sql).
  3) Создаем 4 базы данных direct_log для буферных таблиц, stg для сырых данных, history для исторических таблиц, currently для текущих данных [файл с кодом 2](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/3_point_create_databases.sql)
  4) Создаем две роли, одну наполняем правами на чтение, вторую согласно заданию. Далее создаем юзеров с присвоением ролей. [файл с кодом 3](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/4_point_role_users_create.sql)
  5) Создаем таблицу в stg слое, затем буферную таблицу в direct_log слое (ссылается на таблицу в stg). [файл с кодом 4](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/5_point_create_buffer_stg.sql)
  6) Создаем таблицу в currently слое, затем создаем materialized view для транспорта из stg -> в currently. [файл с кодом 5](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/6_point_create_mat_view_and_currently.sql)
  7) Напишем [скрипт](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/7_point_scrypt_insert.sql) с random функциями для вставки в buffer таблицу, выполним его несколько раз. Далее селектнем [буфер](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/1_buffer.jpg), затем [stg](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/2_stg.jpg), затем [currently](https://github.com/AntonStart/WBSchool-olap-4_task/blob/main/3_currently.jpg).

PS. Имя и фамилия userov наполнял через randomstring() поэтому символьно.
  
