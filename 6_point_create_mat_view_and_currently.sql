-- Создаем таблицу в сurrently слое с replacing движком для схлопывания по id
CREATE TABLE IF NOT EXISTS currently.users_current
(
    user_id UInt64,
    age UInt8,
    date_birth date,
    user_name String,
    user_last_name String,
    user_group LowCardinality(String),
    dt_load datetime MATERIALIZED now()
)
ENGINE = ReplacingMergeTree()
PARTITION BY toYYYYMM(dt_load)
ORDER BY user_id
TTL toStartOfDay(dt_load) + interval 1 year;

-- оздадим MATERIALIZED VIEW для транспорта из stg.users в currently.users_current
CREATE MATERIALIZED VIEW stg.users_materialized_view TO currently.users_current AS
    select user_id
        , age
        ,date_birth
        ,user_name
        ,user_last_name
        ,user_group
    from stg.users;
