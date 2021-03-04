-- таблица пользователей
INSERT users (email, phone, pass_hash, `status`) VALUES 
('e1@mail.ru', 79100010101 , SHA1('e1@mail.ru'), 0),
('e2@mail.ru', 79100010102 , SHA1('e2@mail.ru'), 0),
('e3@mail.ru', 79100010103 , SHA1('e3@mail.ru'), 0),
('e4@mail.ru', 79100010104 , SHA1('e4@mail.ru'), 0),
('e5@mail.ru', 79100010105 , SHA1('e5@mail.ru'), 1),
('e6@mail.ru', 79000010106 , SHA1('e6@mail.ru'), 2);
INSERT users (email, phone, pass_hash, `status`) VALUES 
('e7@mail.ru', 79100010107 , SHA1('e7@mail.ru'), 0),
('e8@mail.ru', 79100010108 , SHA1('e8@mail.ru'), 0),
('e9@mail.ru', 79100010109 , SHA1('e9@mail.ru'), 0),
('e10@mail.ru', 79100010110 , SHA1('e10@mail.ru'), 0),
('e11@mail.ru', 79100010111 , SHA1('e11@mail.ru'), 1),
('e12@mail.ru', 79000010112 , SHA1('e12@mail.ru'), 2);

-- таблица профилей
INSERT `profiles` (first_name, last_name, dob, gender, address, users_id) VALUES
('Евгений', 'Пашкевич', '1979-11-14', 'm', 'Москва, Россия', 1),
('Татьяна', 'Волкова', '1986-03-08', 'f', 'Санкт-Петербург, Россия', 2),
('Александр', 'Дуров', '1990-05-16', 'm', 'Краснодар, Россия', 3),
('Наталья', 'Гундарева', '1975-08-31', 'f', 'Казань, Россия', 4),
('Леонид', 'Артюхин', '1978-04-16', 'm', 'Калининград, Россия', 5),
('Людмила', 'Алексеева', '1988-12-31', 'f', 'Новосибирск, Россия', 6);
INSERT `profiles` (first_name, last_name, dob, gender, address, users_id) VALUES
('Константин', 'Берлов', '1979-11-14', 'm', 'Пенза, Россия', 7),
('Марина', 'Андреенко', '1986-03-08', 'f', 'Сартов, Россия', 8),
('Михаил', 'Строганов', '1990-05-16', 'm', 'Владимир, Россия', 9),
('Анастасия', 'Петренко', '1975-08-31', 'f', 'Вологда, Россия', 10),
('Федор', 'Малкин', '1978-04-16', 'm', 'Челябинск, Россия', 11),
('Ольга', 'Иванова', '1988-12-31', 'f', 'Воркута, Россия', 12);

-- таблица клиентов
INSERT clients (`code`, residence, citizenship, users_id, tariffs_id) VALUES
(2001, 1, 'Российская Федерация', 1, 1),
(2002, 1, 'Российская Федерация', 2, 2),
(2003, 1, 'Российская Федерация', 3, 3),
(2004, 1, 'Российская Федерация', 4, 1),
(2005, 0, 'Российская Федерация', 5, 2),
(2006, 1, 'Российская Федерация', 6, 3);
INSERT clients (`code`, residence, citizenship, users_id, tariffs_id) VALUES
(2007, 1, 'Российская Федерация', 7, 1),
(2008, 1, 'Российская Федерация', 8, 2),
(2009, 1, 'Российская Федерация', 9, 3),
(2010, 1, 'Российская Федерация', 10, 1),
(2011, 0, 'Российская Федерация', 11, 2),
(2012, 1, 'Российская Федерация', 12, 3);

-- таблица сессий
INSERT sessions (ip_address, device_id, device_name, users_id, location) VALUES
-- ('210.120.1.12', '75d20e85-6bf2-4799-84a1-8c23a502fb96', 'MAC OS, Canberra, Safari', 1);
-- ('212.20.112.22', '0035a5af-d69e-4746-8f96-3a0635a0acfd', 'iPHONE, iOS 14.1 Safari', 1);
-- ('10.58.11.132', 'a91f28bb-461b-49ef-bc41-d055d55a1cef', 'Windows PC, Windows 10, Internet Explorer 10', 1);
-- ('11.11.10.226', 'd7e29a20-0207-4e71-82dd-50a6e09a2d43', 'MAC OS, Canberra, Safari', 1);
-- ('195.20.101.2', '7648b2ea-e87d-4cc6-bb48-b0ef5ca7961a', 'iPHONE, iOS 14.1 Safari', 1, 'Москва, Россия');
('195.128.1.22', '48316e63-d76e-4b79-8965-2e6bd69598ec', 'Windows PC, Windows 10, Chrome', 1, 'Казань, Россия');
('210.1.54.120', 'f3005ddc-849d-4d05-bb71-03f7d7c198ae', 'MAC OS, Canberra, Safari', 1, 'Сочи, Россия'),
('196.12.31.48', '0c325dab-b5a8-4206-ab57-6f8b13b90b82', 'iPHONE, iOS 14.1 Safari', 1, 'Верхний Волочек, Россия'),
('10.1.10.223', 'ce55e2d3-7de1-43f2-bc95-204aa6031bcb', 'Windows PC, Windows 10, Chrome', 1, 'Калиниград, Россия'),
('198.160.10.21', '62db7e4f-a611-4965-a7ed-8e004686454e', 'MAC OS, Canberra, Safari', 1, 'Берлин, Германия'),
('201.10.20.8', '0ee08bfe-235d-4b39-a742-35a93cc62496', 'Windows PC, Windows 10, Chrome', 1, 'Лондон, Великобритания');

-- таблица счетов
INSERT accounts (cur_id, acc_number, client_id) VALUES
(1, '32345678901234567890', 3),
(2, '32345678901234567891', 3),
(3, '32345678901234567892', 3);

-- Таблица карт
INSERT cards (mps, is_credit, is_virtual, product, token, masked_pan, valid_up, client_id, accounts_id) VALUES
-- ('Master Card', 0, 0, 'Master Card Black CashBack', '1234567890123456', '123456***1234', '03/2025', 1, 1);
-- ('Master Card', 0, 1, 'Master Card Alfa Virtual', '1234567890123456', '123456***1235', '03/2025', 1, 1);
-- ('VISA', 1, 0, 'VISA GOLD', '1234567890123456', '123456***1236', '03/2025', 1, 2);
-- ('VISA', 0, 1, 'VISA Standard', '1234567890123456', '123456***1237', '03/2025', 1, 3);
('Master Card', 0, 0, 'Master Card Black CashBack', '1234567890123456', '123456***1234', '03/2025', 2, 1);

-- таблица уведомлений
INSERT notifications (message, client_id) VALUES
-- ('**1234 Покупка совершена успешно. Сумма 106 RUB. Остаток 17 051,51 Пятерочка 28 февраля', 1);
('Уважаемый клиент, карта visa1239 активирована', 2);
-- ('VISA1235 25.02.21 17:51 ОТКАЗ. Покупка  305 RUB Азбука вкуса 27 февраля', 1);
-- ('Документ "Выписка по счету дебетовой карты" готов. Документ доступен по ссылке "ссылка"', 1);

-- таблица сообщений
INSERT messages (from_client, to_client, `text`) VALUES
-- (1, NULL, 'Почему с меня списали 100 рублей?');
-- (NULL, 1, 'Здравствуйте Евгений, передаю вопрос оператору');
-- (NULL, 1, 'Здравствуйте Евгений, 100 рублей списано за обслуживание карты согласно тарифам банка.');
-- (1, NULL, 'Неожиданно! А давно у Вас поменялись тарифы?');
-- (NULL, 1, 'Евгений, тарифы изменились с нового года. Чем я могу помочь еще?');
-- (1, NULL, 'Спасибо. Больше вопросов нет');
-- (NULL, 1, 'Евгений, спасибо за обращение! Рада помочь, хорошего дня!');
(NULL, NULL, 'Привет, бот!');

-- таблица операций. 
INSERT operations (amount, `description`, accounts_id, cards_id, services_id) VALUES
(100, 'Пополнение счета внутренним переводом', 1, NULL, 7);

-- таблица со списокм услуг банка
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Open currency account', 'Открытие валютного счета счета');
-- Выпуск карт
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Issue card', 'Выпуск карты');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Issue additional card', 'Выпуск дополнительной карты');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Issue virtual card', 'Выпуск виртуальной карты');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Issue additional virtual card', 'Выпуск дополнительной виртуальной карты');
-- Платежи и переводы
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Internal Transfer', 'Перевод средств клиенту банка');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('External Transfer', 'Перевод средств клиенту другого банка');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('External Transfer curr', 'Перевод средств в валюте');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Tariff payment', 'Оплата тарифного плана');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Service Fee', 'Комиссия за услуги банка');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Utility payment', 'Оплата коммунальных услуг');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Mobile payment', 'Оплата мобильного телефона');
-- Карточные операции
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Card purchase', 'Покупка с использованием карты');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Cash withdrawal', 'Снятие наличных в банкоматах банка');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Cash withdrawal ext', 'Снятие наличных в банкоматах другого банка');
INSERT INTO `piab`.`services` (`name`, `description`) VALUES ('Card top up', 'Пополнение карт');

-- таблица тарифных планов
-- INSERT INTO `piab`.`tariffs` (`name`, `description`, `price_m`, `price_y`) VALUES ('Basic', 'Базовый бесплатный тариф', '0', '0');
-- INSERT INTO `piab`.`tariffs` (`name`, `description`, `price_m`, `price_y`) VALUES ('Standard', 'стандартный тариф', '300.00', '3000.00');
-- INSERT INTO `piab`.`tariffs` (`name`, `description`, `price_m`, `price_y`) VALUES ('Advanced', 'Продвинутый тариф. Все включено', '1000.00', '11000.00');

-- таблица курсов валют
-- INSERT INTO `piab`.`rates` (`cur_2_sell`, `cur_2_buy`, `rate`) VALUES ('3', '1', '73.11');
-- INSERT INTO `piab`.`rates` (`cur_2_sell`, `cur_2_buy`, `rate`) VALUES ('1', '3', '74.4901');
INSERT INTO `piab`.`rates` (`cur_2_sell`, `cur_2_buy`, `rate`) VALUES ('2', '1', '88.38');
INSERT INTO `piab`.`rates` (`cur_2_sell`, `cur_2_buy`, `rate`) VALUES ('1', '2', '90.78');