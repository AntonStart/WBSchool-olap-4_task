-- Создаем юзера с sha256_password
CREATE USER pozdnyakov_admin IDENTIFIED WITH sha256_password BY 'qwerty';

-- Eсли мы хoтим дать суперпользователя для pozdnyakov_admin
-- ужно раскоментить в users.xml следующий конфиг

--             <!--
--             <grants>
--                 <query>GRANT ALL ON *.*</query>
--             </grants>
--             -->

-- Далее откроем соединение и выполним:
--GRANT ALL ON *.* TO pozdnyakov_admin WITH GRANT OPTION;

-- Наделяем его правами админа
GRANT CURRENT GRANTS ON *.* TO pozdnyakov_admin WITH GRANT OPTION;
