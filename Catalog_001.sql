 Drop DATABASE Catalog_001;

CREATE DATABASE IF NOT EXISTS Catalog_001;

USE Catalog_001;


-- CREATE TABLE IF NOT EXISTS list_product # список товаров
-- (
-- id_barcode INT NOT NULL, #(id штрих кода)
-- name_product VARCHAR(40) NOT NULL #(наименование товара)
-- );



CREATE TABLE IF NOT EXISTS supplier_list # список поставщиков
(
id_supplier INT PRIMARY KEY AUTO_INCREMENT, #(id поставщика)
name_supplier VARCHAR(40) NOT NULL UNIQUE, #(наименование поставщика)
inn_supplier VARCHAR(25) NOT NULL, #(инн поставщика)
address_supplier VARCHAR(50) NOT NULL, #(адрес поставщика)
telephone_supplier VARCHAR(30) NOT NULL #(телефон поставщика)
);


CREATE TABLE IF NOT EXISTS list_of_units # список единиц измерения
(
id_unit INT PRIMARY KEY AUTO_INCREMENT, #(id единицы измерения)
name_unit VARCHAR(6) NOT NULL #(наименование единицы измерения)
);

 
CREATE TABLE IF NOT EXISTS group_product # группа товаров
(
id_group_product INT PRIMARY KEY AUTO_INCREMENT, #(id группы товаров)
name_group_product VARCHAR(40) NOT NULL UNIQUE #( название группы товаров)
);


CREATE TABLE IF NOT EXISTS group_receipt # группы поступлений
(
id_group_receipt INT PRIMARY KEY AUTO_INCREMENT, #(id группы поступления)
name_group_receipt VARCHAR(25) NOT NULL, # (наименование группы поступления)
total_sum_receipt FLOAT NOT NULL # (общая сумма по группе поступления)
);


CREATE TABLE IF NOT EXISTS group_consumption # группы расходов
(
id_group_consumption INT PRIMARY KEY AUTO_INCREMENT, #(id группы расходов)
name_group_consumption VARCHAR(20) NOT NULL, #(наименование группы расходов)
total_sum_consumption FLOAT NOT NULL #(общая сумма по группе расхода)
);


CREATE TABLE IF NOT EXISTS Nomenclature # номенклатура
(
name_product_Nomenclature VARCHAR(100) NOT NULL UNIQUE, #(наименование товара)
id_product INT PRIMARY KEY AUTO_INCREMENT, #(id товара)
barcode_Nomenclature FLOAT NOT NULL UNIQUE ,
name_unit_Nomenclature VARCHAR(25) NOT NULL, #(единица измерения)
balance_Nomenclature FLOAT, #(остаток)
cost_price FLOAT, #(остаток)
margin INT NOT NULL, #(наценка)
retai_price INT, #(розничная цена)
id_group_product_Nomenclature INT , #(группа товаров)
total_product FLOAT, #(итого по товару)
FOREIGN KEY (id_group_product_Nomenclature) REFERENCES group_product(id_group_product)
);


CREATE TABLE IF NOT EXISTS Receipt_of_goods_and_ready_meals # поступление товаров и готовых блюд 
(
id_group_receipt INT, #(id группы поступления)
id_group_receipt_Receipt_of_goods INT NOT NULL, #(наименование группы поступления)
id_receipt INT PRIMARY KEY AUTO_INCREMENT, #(id поступления)
date_001 DATETIME NOT NULL, #(дата и время поступления)
document_base VARCHAR(25) NOT NULL, #(документ основание)
id_supplier_Receipt_of_goods INT NOT NULL, #(id поставщика)
sum_document INT NOT NULL, #(сумма по документу)
total_receipt_supplier INT NOT NULL, #(итого поступления по поставщику)
total_group_receipt INT NOT NULL, #(итого по группе поступления)
FOREIGN KEY (id_group_receipt_Receipt_of_goods) REFERENCES group_receipt(id_group_receipt),
FOREIGN KEY (id_supplier_Receipt_of_goods) REFERENCES supplier_list(id_supplier)
);


CREATE TABLE IF NOT EXISTS Consumption_of_goods # расход товаров и готовых блюд
(
id_group_consumption INT, #(id группы расходов)
id_consumption INT PRIMARY KEY AUTO_INCREMENT, #(id расхода)
id_group_consumption_Consumption_of_goods INT NOT NULL, #(наименование группы расходов)
date_001 DATETIME NOT NULL, #(дата и время поступления)
document_base VARCHAR(25), #(документ основание)
id_supplier_Consumption_of_goods INT NOT NULL, #(имя поставщика)
sum_document INT NOT NULL, #(сумма по документу)
total_consumption_supplier INT NOT NULL, #(итого поступления по поставщику)
total_group_consumption INT NOT NULL, #итого по группе поступления)
FOREIGN KEY (id_group_consumption_Consumption_of_goods) REFERENCES group_consumption(id_group_consumption),
FOREIGN KEY (id_supplier_Consumption_of_goods) REFERENCES supplier_list(id_supplier)
);


CREATE TABLE IF NOT EXISTS technological_cards_list # список технологических карт
(
Id_technological_cards INT NOT NULL, #(id технологической карты)
id_product_technological_cards INT NOT NULL, #(наименование товара)
barcode_technological_cards INT NOT NULL, #(штрих-код),
document_base VARCHAR(25), # документ основание
id_group_product_technological_cards INT NOT NULL, #(группа товаров)
cooking_method VARCHAR(100) NOT NULL, #(способ приготовления)
quantity_unit_receipt FLOAT NOT NULL, #(вес поступления)
quantity_dish INT NOT NULL, #(количество штук готового блюда)
total_cost_price FLOAT NOT NULL, #(итого себестоимость)
dish_output_group_product INT NOT NULL, #(выход готового блюда)
margin INT NOT NULL, #(наценка)
retai_price INT NOT NULL, #(розничная цена),
FOREIGN KEY (id_product_technological_cards) REFERENCES Nomenclature(id_product),
FOREIGN KEY (id_group_product_technological_cards) REFERENCES group_product(id_group_product)
);


CREATE TABLE IF NOT EXISTS goods_for_consumption # список товаров к расходу
(
Id_list_of_consumables INT PRIMARY KEY AUTO_INCREMENT, #(id списка к расходу)
id_product_goods_for_consumption INT NOT NULL, #(наименование товара)
id_unit_goods_for_consumption INT NOT NULL, #(единица измерения)
balance_goods_for_consumption FLOAT NOT NULL, #(остаток)
id_group_product_goods_for_consumption INT NOT NULL, #(группа товаров)
cost_price FLOAT NOT NULL, #(себестоимость )
quantity_unit_consumption FLOAT NOT NULL, #(количество единиц измерения к расходу)
sum_product FLOAT NOT NULL, #(сумма по товару)
FOREIGN KEY (id_product_goods_for_consumption) REFERENCES Nomenclature(Id_product),
FOREIGN KEY (id_group_product_goods_for_consumption) REFERENCES group_product(id_group_product),
FOREIGN KEY (id_unit_goods_for_consumption) REFERENCES list_of_units(Id_unit)
);



CREATE TABLE IF NOT EXISTS list_of_dishes #перечень блюд
(
id_dish INT PRIMARY KEY AUTO_INCREMENT, #(id блюда)
id_product_list_of_dishes INT NOT NULL, # (наименование товара)
barcode_list_of_dishes INT NOT NULL, #(штрих код)
name_unit VARCHAR(6) NOT NULL, #(единица измерения)
balance_list_of_dishes INT NOT NULL, #(остаток)
id_group_product_list_of_dishes INT NOT NULL, #(группа товаров)
FOREIGN KEY (id_product_list_of_dishes) REFERENCES Nomenclature(id_product),
FOREIGN KEY (id_group_product_list_of_dishes) REFERENCES group_product(id_group_product)
);


CREATE TABLE IF NOT EXISTS arrival_goods # список товаров прихода
(
id_arrival_goods_list INT PRIMARY KEY AUTO_INCREMENT, #(id списка к расходу)
id_product_goods_for_consumption INT NOT NULL, #(наименование товара)
id_unit_goods_for_consumption INT NOT NULL, #(наименование единицы измерения)
balance_arrival_goods FLOAT NOT NULL, #(остаток)
id_group_product_goods_for_consumption INT NOT NULL, #(группа товаров)
cost_price FLOAT NOT NULL, #(себестоимость )
arrival_quantity FLOAT NOT NULL, #(количество единиц измерения к расходу)
sum_product FLOAT NOT NULL, #(сумма по товару)
FOREIGN KEY (id_product_goods_for_consumption) REFERENCES Nomenclature(Id_product),
FOREIGN KEY (id_group_product_goods_for_consumption) REFERENCES group_product(id_group_product),
FOREIGN KEY (id_unit_goods_for_consumption) REFERENCES list_of_units(Id_unit)
);
























