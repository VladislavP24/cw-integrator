#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTranslator>
#include <QtWidgets/QMainWindow>
#include <QtCharts/QChartView>
#include <QtCharts/QLegend>
#include <QtCharts/QLineSeries>
#include <QtCharts/QCategoryAxis>
#include <QThread>
#include <QPainter>
#include <QSettings>
#include <QFileDialog>
#include <QMessageBox>
#include <QTextStream>
#include <QFile>
#include <QListWidget>
#include <QStatusBar>
#include <QListWidgetItem>
#include<QTextStream>
#include<QTableView>
#include <QDir>
#include <QInputDialog>
#include <QLibraryInfo>
#include <QDebug>
#include <QContextMenuEvent>
#include <QTableView>>

#include "dialog.h"
#include "tablemodel.h"
#include "sysintegrator.h"
#include "company.h"
#include "projects.h"
#include "clients.h"
#include "techno.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

/**
 * @brief Класс главного окна приложения
 */
class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    /**
     * @brief Конструктор класса MainWindow
     * @param parent - указатель на родительский объект
     */
    MainWindow(QWidget *parent = nullptr);

    /**
     * @brief Деструктор класса MainWindow
     */
    ~MainWindow();

private slots:
    /**
     * @brief Слот для обработки нажатия на кнопку "Cоединение" в меню
     */
    void on_actionConnect_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "О авторе" в меню
     */
    void on_actionAbout_programm_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "Удаление" в меню
     */
    void on_actionDelete_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "Новое окно" в меню
     */
    void on_actionNew_Window_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "Сумма зарплат"
     */
    void on_action_Amount_of_salaries_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "Интервал проектов"
     */
    void on_action_Project_Completion_triggered();

    /**
     * @brief Слот для обработки нажатия на кнопку "Вставить" для добавления данных в таблицу системных интеграторов
     */
    void on_pushButton_1_clicked();

    /**
     * @brief Слот для обработки нажатия на кнопку "Вставить" для добавления данных в таблицу компаний
     */
    void on_pushButton_2_clicked();

    /**
     * @brief Слот для обработки нажатия на кнопку "Вставить" для добавления данных в таблицу проектов
     */
    void on_pushButton_3_clicked();

    /**
     * @brief Слот для обработки нажатия на кнопку "Вставить" для добавления данных в таблицу технологий
     */
    void on_pushButton_4_clicked();

    /**
     * @brief Слот для обработки нажатия на кнопку "Вставить" для добавления данных в таблицу клиентов
     */
    void on_pushButton_5_clicked();

    /**
     * @brief Слот для обработки нажатия на кнопку "Найти" для поиска данных в таблице системных интеграторов
     */
    void on_pushButton_11_clicked();

private:
    Ui::MainWindow *ui; /**< Указатель на объект интерфейса главного окна */
    QSqlDatabase *db; /**< Объект базы данных */
    QTranslator translator; /**< Объект перевода */
    TableModel *TableModelObj; /**< Объект табличной модели */

    /**
     * @brief Метод для чтения настроек приложения
     */
    void readSettings();

    /**
     * @brief Метод для записи настроек приложения
     */
    void writeSettings();

    Sysintegrator *sysintegrator {nullptr}; /**< Модель таблицы системных интеграторов */
    Company *company {nullptr}; /**< Модель таблицы компаний */
    Project *project {nullptr}; /**< Модель таблицы проектов */
    Client *client  {nullptr}; /**< Модель таблицы клиентов */
    Techno *techno  {nullptr}; /**< Модель таблицы технологий */
};
#endif // MAINWINDOW_H.
