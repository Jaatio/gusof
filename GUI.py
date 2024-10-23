from PyQt5 import QtWidgets
import sys
from Py_forms.torg import Ui_MainWindow
from main import DB


class MainWindow(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)  # Инициализация интерфейса







if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    start_app = MainWindow()
    start_app.show()
    sys.exit(app.exec_())

