import sys
import pymysql
import pymysql.cursors

class torg_db:


    def __init__(self):
        try:
            self.connection = pymysql.connect(host='localhost',
                                              user='root',
                                              password='',
                                              database='4question',
                                              cursorclass=pymysql.cursors.DictCursor)

            print("Соединение с базой данных установлено")
        except pymysql.MySQLError as e:
            print(f"Ошибка при подключении к базе данных: {e}")
            sys.exit()

    def fetch_data(self):
        try:
            with self.connection.cursor() as cursor:
                cursor.execute("SELECT * FROM 4question.information;")
                results = cursor.fetchall()
                return results
        except pymysql.MySQLError as e:
            print(f"Ошибка при выполнении запроса: {e}")
            return None



DB = torg_db()
