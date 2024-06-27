-- роль с правами чтения данных
CREATE ROLE readonly_user;
-- выдача прав для роли чтение и убить запрос
GRANT SELECT ON *.* TO readonly_user;
GRANT KILL QUERY ON *.* TO readonly_user;
-- роль с правами чтения и create/insert в базе stg
CREATE ROLE read_all_create_stg_user;
-- выдача прав для роли чтение, убить запрос, create table/view, insert
GRANT SELECT ON *.*  TO read_all_create_stg_user;
GRANT KILL QUERY ON *.* TO read_all_create_stg_user;
GRANT CREATE TABLE ON stg.*  TO read_all_create_stg_user;
GRANT CREATE VIEW ON stg.*  TO read_all_create_stg_user;
GRANT INSERT ON stg.*  TO read_all_create_stg_user;
GRANT ALTER TABLE ON stg.*  TO read_all_create_stg_user;

-- Юзер с привилегиями для чтения
CREATE USER pozdnyakov_reader DEFAULT ROLE readonly_user IDENTIFIED WITH sha256_password BY 'qwerty';
-- Юзер с привилегиями чтение + CREATE/INSERT/ALTER
CREATE USER pozdnyakov_stg DEFAULT ROLE read_all_create_stg_user IDENTIFIED WITH sha256_password BY 'qwerty';
