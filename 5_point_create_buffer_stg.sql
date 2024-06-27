-- Создаем таблицу в stg слое
CREATE TABLE IF NOT EXISTS stg.users
(
    user_id UInt64,
    age UInt8,
    date_birth date,
    user_name String,
    user_last_name String,
    user_group LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY user_id;

-- Создаем буферную таблицу в direct_log слое для транспорта данных в stg.users
CREATE TABLE IF NOT EXISTS direct_log.users_buff
(
    user_id UInt64,
    age UInt8,
    date_birth date,
    user_name String,
    user_last_name String,
    user_group LowCardinality(String)
)
ENGINE = Buffer('stg',
                'users',
                16,
                10,
                100,
                1000,
                10000,
                10000000,
                100000000);
