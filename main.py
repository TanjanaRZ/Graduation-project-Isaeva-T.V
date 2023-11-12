import sys  # sys нужен для передачи argv в QApplication
from PyQt5 import QtWidgets
import Main_menu_01  # Это наш конвертированный файл дизайна

# для подключения к базе данных :

import mysql.connector
from getpass import getpass
from mysql.connector import connect, Error
from PyQt5.QtSql import QSqlDatabase, QSqlQuery

    

class ExampleApp(QtWidgets.QMainWindow, Main_menu_01.Ui_Main_menu_01):
    def __init__(self):
        # Это здесь нужно для доступа к переменным, методам
        # и т.д. в файле Main_menu_01.py
        super().__init__()
        self.setupUi(self)  # Это нужно для инициализации нашего дизайна

        # Подключение к базе данных, через код

        def create_connection(host_name, user_name, user_password, Catalog_001):
            connection = None
            try:
               connection = mysql.connector.connect(
                   host=host_name,
                   user=user_name,
                   passwd=user_password,
                   database=Catalog_001
               )
               print("Connection to MySQL DB successful")
            except Error as e:
               print(f"The error '{e}' occurred")

            return connection
        
        connection = create_connection("localhost", "root", "Ввести пароль", "Catalog_001")




        # Подключение к существующей базе данных с вводом пароля:

# try:
#     with connect(
#         host="localhost",
#         user=input("Имя пользователя: "),
#         password=getpass("Пароль: "),
#         database="online_movie_rating",
#     ) as connection:
#         print(connection)
# except Error as e:
#     print(e)


        self.NomenclatureT.setCurrentIndex(0)
        
        # Кнопки главного меню

        def sTE():
            self.NomenclatureT.setCurrentWidget(self.Page_nomenclature)
        self.add_nomenclature.clicked.connect(sTE) # type: ignore

        def sTE1():
            self.NomenclatureT.setCurrentWidget(self.Page_receipt)
        self.add_receipt.clicked.connect(sTE1) # type: ignore

        def sTE2():
            self.NomenclatureT.setCurrentWidget(self.Page_consumption)
        self.add_consumption.clicked.connect(sTE2) # type: ignore

        def sTE3():
            self.NomenclatureT.setCurrentWidget(self.Page_technolog)
        self.add_technological.clicked.connect(sTE3) # type: ignore

        def sTE4():
            self.NomenclatureT.setCurrentWidget(self.Page_calculation)
        self.add_calculation.clicked.connect(sTE4) # type: ignore

        def sTE5():
            self.NomenclatureT.setCurrentWidget(self.Page_report)
        self.add_report.clicked.connect(sTE5)
        

        # Заполнение таблицы данными из базы данных


        with connection.cursor() as cursor:
                cursor.execute("""
             SELECT * FROM catalog_001.nomenclature;
             """)
                numenclature_arr = cursor.fetchall() 
                for row in range(len(numenclature_arr)):
                     for col in range(len(numenclature_arr[0])):
                        self.tableNomenclature.setItem(row + 1, col, QtWidgets.QTableWidgetItem(str(numenclature_arr[row][col])))


            # Добавить запись Новый товар
        
        def add_new_product():
            
            with connection.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO Nomenclature (name_product_Nomenclature, barcode_Nomenclature, name_unit_Nomenclature, margin)
                    VALUES
                    ('"""+self.lineEdit_new_prdct_name.displayText()+"""',
                     """+self.lineEdit_new_prdct_cod.displayText()+""",
                     '"""+self.comboBox_new_prdct_unit.currentText()+"""',
                     '"""+self.lineEdit_new_prdct_margin.displayText()+"""')""")
    
                connection.commit()

            self.new_prdct.hide()
        self.buttonBox_new_prdct.accepted.connect(add_new_product)

        # Открыть окно Новый товар

    

        # Выбор группы товаров при создании нового товара

        def select_group_product_to_nomen():
            self.comboBox_new_prdct_group.clear()
            with connection.cursor() as cursor:
                cursor.execute("SELECT name_group_product FROM catalog_001.group_product;")
                array_group_product = cursor.fetchall()
                for row in array_group_product:
                    self.comboBox_new_prdct_group.addItem(row[0])
            self.new_prdct.show()
        self.new_prdct.hide()
        self.add_new_product.clicked.connect(select_group_product_to_nomen) 

 
         # Отмена добавления Нового товара

        self.buttonBox_new_prdct.rejected.connect(self.new_prdct.hide) 



        

        # Открыть окно Новая Группа

        self.widget_new_group.hide()
        self.add_group_product.clicked.connect(self.widget_new_group.show)
       

        # Добавить запись Группа товаров
        
        def add_new_group():
            
            with connection.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO group_product (name_group_product)
                    VALUES
                    ('"""+self.lineEdit_widget_new_group.displayText()+"""')""")
                connection.commit()
            self.widget_new_group.hide()
        self.buttonBox_widget_new_group.accepted.connect(add_new_group)
 
        # Отмена добавления Группы продуктов

        self.buttonBox_widget_new_group.rejected.connect(self.widget_new_group.hide) 

        

      
        
    



def main():
    app = QtWidgets.QApplication(sys.argv)  # Новый экземпляр QApplication

    window = ExampleApp()  # Создаём объект класса ExampleApp
    window.show()  # Показываем окно
    app.exec_()  # и запускаем приложение

if __name__ == '__main__':  # Если мы запускаем файл напрямую, а не импортируем
    main()  # то запускаем функцию main()