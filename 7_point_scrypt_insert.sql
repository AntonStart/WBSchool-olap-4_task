-- Примитивный рандомайзер для вставки в буфер
insert into direct_log.users_buff
    select abs(rand64())
        , rand64() % 100
        , toDate(0) + interval (rand32() % 7300) day
        , randomString(10)
        , randomString(15)
        , if(rand32()%2 = 0, 'A', 'B');

-- Что в буфере?
select * from direct_log.users_buff;
-- Что в stg?
select * from stg.users;
-- Что в currently?
select * from currently.users_current;
