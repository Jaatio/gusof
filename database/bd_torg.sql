-- Создание базы данных и выбор ее для работы
DROP DATABASE bd_torg;
CREATE DATABASE IF NOT EXISTS bd_torg;
USE bd_torg;
	
    
create table Информация(
ID INT PRIMARY KEY,
Полное_имя_клиента varchar(255),
Телефон_клиента int(10),
Email varchar(255),
Дата_заказа DATE NOT NULL,
Статус_заказа VARCHAR(50) CHARACTER SET UTF8MB4 NOT NULL
);

INSERT INTO Информация (ID, Полное_имя_клиента, Телефон_клиента, Email, Дата_заказа, Статус_заказа) VALUES
(1, 'Анна Вертиева', '+123456789', 'annv@example.com', '2024-10-17', 'Новый'),
(2, 'Олеся Гилина', '+987654321', 'ogil@example.com', '2024-10-21', 'В работе'),
(3, 'Алиса Мельникова', '+987657321', 'alim@example.com', '2024-10-11', 'Выполнен');


-- Создание таблицы "Товары"
CREATE TABLE Товары (
    ID_Товара INT PRIMARY KEY,
    Название_товара VARCHAR(100) CHARACTER SET UTF8MB4 NOT NULL,
    Категория VARCHAR(100) CHARACTER SET UTF8MB4 NOT NULL,
    Цена DECIMAL(10, 2) NOT NULL,
    Еденица_измерения VARCHAR(50) CHARACTER SET UTF8MB4 NOT NULL,
    Дата_изготовления DATE NOT NULL,
    Срок_годности DATE NOT NULL,
    Производитель VARCHAR(100) CHARACTER SET UTF8MB4 NOT NULL,
    Страна_производства VARCHAR(100) CHARACTER SET UTF8MB4 NOT NULL
);

-- Создание таблицы "Клиенты"
CREATE TABLE Клиенты (
    ID_Клиента INT PRIMARY KEY AUTO_INCREMENT,
    Полное_имя_клиента VARCHAR(150) CHARACTER SET UTF8MB4 NOT NULL,
    Телефон_клиента VARCHAR(20) CHARACTER SET UTF8MB4 NOT NULL,
    Email VARCHAR(100) CHARACTER SET UTF8MB4 NOT NULL,
    Отчество_клиента VARCHAR(50) CHARACTER SET UTF8MB4 NULL
);

-- Создание таблицы "Сотрудники"
CREATE TABLE Сотрудники (
    GUID_Сотрудника CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    Полное_имя_сотрудника VARCHAR(150) CHARACTER SET UTF8MB4 NOT NULL,
    Дата_рождения DATE NOT NULL,
    Телефон_сотрудника VARCHAR(20) NOT NULL,
    Адрес_сотрудника VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    Отчество_сотрудника VARCHAR(50) CHARACTER SET UTF8MB4 NULL
);

-- Создание таблицы "Заказы"
CREATE TABLE Заказы (
    ID_Заказа INT PRIMARY KEY AUTO_INCREMENT,
    Дата_заказа DATE NOT NULL,
    Статус_заказа VARCHAR(50) CHARACTER SET UTF8MB4 NOT NULL,
    ID_Клиента INT NOT NULL,
    GUID_Сотрудника CHAR(36) NOT NULL,
    FOREIGN KEY (ID_Клиента) REFERENCES Клиенты(ID_Клиента),
    FOREIGN KEY (GUID_Сотрудника) REFERENCES Сотрудники(GUID_Сотрудника)
);

-- Создание таблицы "Позиции заказа"
CREATE TABLE Позиции_заказа (
    ID_Позиции_заказа INT PRIMARY KEY AUTO_INCREMENT,
    ID_Заказа INT NOT NULL,
    ID_Товара INT NOT NULL,
    Количество_товара INT NOT NULL,
    FOREIGN KEY (ID_Заказа) REFERENCES Заказы(ID_Заказа),
    FOREIGN KEY (ID_Товара) REFERENCES Товары(ID_Товара)
);

-- Создание таблицы "Покупки"
CREATE TABLE Покупки (
    ID_Покупки INT PRIMARY KEY AUTO_INCREMENT,
    Дата_покупки DATE NOT NULL,
    Способ_оплаты VARCHAR(50) CHARACTER SET UTF8MB4 NOT NULL,
    ID_Клиента INT NOT NULL,
    GUID_Сотрудника CHAR(36) NOT NULL,
    FOREIGN KEY (ID_Клиента) REFERENCES Клиенты(ID_Клиента),
    FOREIGN KEY (GUID_Сотрудника) REFERENCES Сотрудники(GUID_Сотрудника)
);

-- Создание таблицы "Позиции покупки"
CREATE TABLE Позиции_покупки (
    ID_Позиции_покупки INT PRIMARY KEY AUTO_INCREMENT,
    ID_Покупки INT NOT NULL,
    ID_Товара INT NOT NULL,
    Количество_товара INT NOT NULL,
    FOREIGN KEY (ID_Покупки) REFERENCES Покупки(ID_Покупки),
    FOREIGN KEY (ID_Товара) REFERENCES Товары(ID_Товара)
);

-- Создание таблицы "История цен"
CREATE TABLE История_цен (
    ID_Изменения INT PRIMARY KEY AUTO_INCREMENT,
    Дата_изменения DATE NOT NULL,
    ID_Товара INT NOT NULL,
    Старая_цена DECIMAL(10, 2) NOT NULL,
    Новая_цена DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Товара) REFERENCES Товары(ID_Товара)
);

-- Вставка тестовых данных для "Товары"
INSERT INTO Товары (ID_Товара, Название_товара, Категория, Цена, Еденица_измерения, Дата_изготовления, Срок_годности, Производитель, Страна_производства)
VALUES
(1, 'Свинина', 'Мясо', 20.00, 'грамм', '2024-01-01', '2024-01-10', 'Хрюша', 'Россия'),
(2, 'Молоко', 'Молочные продукты', 70.00, 'литр', '2024-10-17', '2024-10-24', 'Milka', 'Германия'),
(3, 'Хлеб', 'Хлебобулочные_изделия', 20.00, 'штук', '2024-10-20', '2024-10-30', 'Fr_Pic', 'Франция'),
(4, 'Йогурт', 'Молочные продукты', 100.00, 'литр', '2024-10-20', '2024-11-15', 'Кубанский молочник', 'Россия'),
(5, 'Торт', 'Кондитерские изделия', 400.00, 'штука', '2024-10-10', '2024-10-17', 'Вкуснолюбов', 'Россия'),
(6, 'Кетчуп', 'Специи', 15.00, 'грамм', '2024-09-01', '2024-12-20', 'Hance', 'Англия'),
(7, 'Курятина', 'Мясо', 25.00, 'грамм', '2024-02-01', '2024-02-10', 'Цыпа', 'Россия');

-- Вставка тестовых данных для "Клиенты"
INSERT INTO Клиенты (Полное_имя_клиента, Телефон_клиента, Email, Отчество_клиента)
VALUES
('Анна Вертиева', '+123456789', 'annv@example.com', 'Андреевна'),
('Олеся Гилина', '+987654321', 'ogil@example.com', 'Михайловна');

-- Вставка тестовых данных для "Сотрудники"
INSERT INTO Сотрудники (Полное_имя_сотрудника, Дата_рождения, Телефон_сотрудника, Адрес_сотрудника, Отчество_сотрудника)
VALUES
('Елизавета Сеник', '1985-06-15', '+1122334455', 'Таганрог, Улица Богдана Хмельницкого, 12, 15', 'Андреевна'),
('Яна Мельникова', '1990-09-10', '+9988776655', 'Санкт-Петербург, Петровская, 15, 5', 'Алексеевна');

-- Вставка тестовых данных для "Заказы"
INSERT INTO Заказы (Дата_заказа, Статус_заказа, ID_Клиента, GUID_Сотрудника)
VALUES
 ('2024-10-01', 'Новый', 1, (SELECT GUID_Сотрудника FROM Сотрудники WHERE Полное_имя_сотрудника = 'Елизавета Сеник')),
 ('2024-10-02', 'В работе', 2, (SELECT GUID_Сотрудника FROM Сотрудники WHERE Полное_имя_сотрудника = 'Яна Мельникова'));

-- Вставка тестовых данных для "Позиции заказа"
INSERT INTO Позиции_заказа (ID_Заказа, ID_Товара, Количество_товара)
VALUES
(1, 1, 5000),
(1, 2, 50),
(2, 3, 20),
(2, 5, 10);

-- Вставка тестовых данных для "Покупки"
INSERT INTO Покупки (Дата_покупки, Способ_оплаты, ID_Клиента, GUID_Сотрудника)
VALUES
 ('2024-10-05', 'Кредитная карта', 1, (SELECT GUID_Сотрудника FROM Сотрудники WHERE Полное_имя_сотрудника = 'Елизавета Сеник')),
 ('2024-10-06', 'Наличные', 2, (SELECT GUID_Сотрудника FROM Сотрудники WHERE Полное_имя_сотрудника = 'Яна Мельникова'));

-- Вставка тестовых данных для "Позиции покупки"
INSERT INTO Позиции_покупки (ID_Покупки, ID_Товара, Количество_товара)
VALUES
(1, 1, 400),
(1, 2, 2),
(2, 3, 300),
(2, 5, 1);

-- Вставка данных для "История цен"
INSERT INTO История_цен (Дата_изменения, ID_Товара, Старая_цена, Новая_цена)
VALUES
('2024-09-01', 1, 20.00, 21.00),
('2024-09-02', 2, 70.00, 60.00);
