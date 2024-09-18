#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QMainWindow>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlRelation>
#include <QSqlRelationalTableModel>
#include <QSqlRelationalDelegate>
#include <QMessageBox>
#include <QSettings>
#include <QScreen>
#include <QDebug>
#include <QSortFilterProxyModel>
#include <QTranslator>
#include <QSqlQuery>

#include "delegateforvalidation.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    readSettings();
    if(QSqlDatabase::isDriverAvailable("QPSQL")) //Проверка наличие драйвера
        qDebug() << "QPSQL found!";
    else
    {
        qDebug() << "EROR! QPSQL not found!";
    }

    QString pathToTranslation;

    pathToTranslation = QDir::currentPath()+ "/debug";
    translator.load("QtLanguage_ru.qm", pathToTranslation) ?
        qDebug() << "File with translation loaded" :
        qDebug() << "File with translation not loaded. Check path to file";
    qDebug() << pathToTranslation;

    qApp->installTranslator(&translator) ?
        qDebug() << "Translator installed" :
        qDebug() << "Translator not installed";
    ui->retranslateUi(this);

    ui->SysTableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    ui->CompanyTableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    ui->ProjectTableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    ui->ClientTableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    ui->TechnoTableView->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    readSettings();

    ui->SysTableView->setSortingEnabled(true);
    ui->CompanyTableView->setSortingEnabled(true);
    ui->ProjectTableView->setSortingEnabled(true);
    ui->ClientTableView->setSortingEnabled(true);
    ui->TechnoTableView->setSortingEnabled(true);

    ui->SysTableView->setDragEnabled(true);
    ui->SysTableView->setAcceptDrops(true);
    ui->SysTableView->setDropIndicatorShown(true);

    ui->CompanyTableView->setDragEnabled(true);
    ui->CompanyTableView->setAcceptDrops(true);
    ui->CompanyTableView->setDropIndicatorShown(true);

    ui->ProjectTableView->setDragEnabled(true);
    ui->ProjectTableView->setAcceptDrops(true);
    ui->ProjectTableView->setDropIndicatorShown(true);

    ui->ClientTableView->setDragEnabled(true);
    ui->ClientTableView->setAcceptDrops(true);
    ui->ClientTableView->setDropIndicatorShown(true);

    ui->TechnoTableView->setDragEnabled(true);
    ui->TechnoTableView->setAcceptDrops(true);
    ui->TechnoTableView->setDropIndicatorShown(true);

    // Установка валидаторов на столбцы с номерами телефонов
    DelegateForValidation * delegate = new DelegateForValidation;
    ui->SysTableView->setItemDelegateForColumn(4,delegate);
    ui->ClientTableView->setItemDelegateForColumn(3,delegate);
    ui->CompanyTableView->setItemDelegateForColumn(3,delegate);

    // Устанавливаем валидатор на ввод в SysTableView
    QRegularExpression expr11("[A-Z]{1}[a-z]{30}"); // Фамилия
    QRegularExpressionValidator *validator11 = new QRegularExpressionValidator(expr11);
    ui->lineEdit_11->setValidator(validator11);

    QRegularExpression expr12("[A-Z]{1}[a-z]{30}"); // Имя
    QRegularExpressionValidator *validator12 = new QRegularExpressionValidator(expr12);
    ui->lineEdit_12->setValidator(validator12);

    QRegularExpression expr13("[A-Z]{1}[a-z0-9\\s-]{30}"); // Должность
    QRegularExpressionValidator *validator13 = new QRegularExpressionValidator(expr13);
    ui->lineEdit_13->setValidator(validator13);

    QRegularExpression expr14("8{1}[0-9]{10}"); // Номер телефона
    QRegularExpressionValidator *validator14 = new QRegularExpressionValidator(expr14);
    ui->lineEdit_14->setValidator(validator14);

    QRegularExpression expr15("[0-9]{7}"); // Зарплата
    QRegularExpressionValidator *validator15 = new QRegularExpressionValidator(expr15);
    ui->lineEdit_15->setValidator(validator15);

    // Устанавливаем валидатор на ввод в CompanyTableView
    QRegularExpression expr21("[A-Z]{1}[a-z0-9\\s.,-]{30}"); // Адрес компании
    QRegularExpressionValidator *validator21 = new QRegularExpressionValidator(expr21);
    ui->lineEdit_21->setValidator(validator21);

    QRegularExpression expr22("[A-Z]{1}[a-z0-9\\s.,-]{30}"); // Адрес компании
    QRegularExpressionValidator *validator22 = new QRegularExpressionValidator(expr22);
    ui->lineEdit_22->setValidator(validator22);

    QRegularExpression expr23("8{1}[0-9]{10}"); // Номер телефона
    QRegularExpressionValidator *validator23 = new QRegularExpressionValidator(expr23);
    ui->lineEdit_23->setValidator(validator23);

    // Устанавливаем валидатор на ввод в ProjectTableView
    QRegularExpression expr31("[A-Z]{1}[a-z0-9\\s,.-]{50}"); // Название проекта
    QRegularExpressionValidator *validator31 = new QRegularExpressionValidator(expr31);
    ui->lineEdit_31->setValidator(validator31);

    QRegularExpression expr32("[A-Z]{1}[a-z\\s]{30}"); // Статус проекта
    QRegularExpressionValidator *validator32 = new QRegularExpressionValidator(expr32);
    ui->lineEdit_32->setValidator(validator32);

    // Устанавливаем валидатор на ввод в TechnotTableView
    QRegularExpression expr41("[A-Z]{1}[a-z0-9\\s,.-]{50}"); // Название технологии
    QRegularExpressionValidator *validator41 = new QRegularExpressionValidator(expr41);
    ui->lineEdit_41->setValidator(validator41);

    QRegularExpression expr42("[A-Z]{1}[a-z0-9\\s,.-]{200}"); // Информация о технологии
    QRegularExpressionValidator *validator42 = new QRegularExpressionValidator(expr42);
    ui->lineEdit_42->setValidator(validator42);

    // Устанавливаем валидатор на ввод в ClientTableView
    QRegularExpression expr51("[A-Z]{1}[a-z]{30}"); // Фамилия
    QRegularExpressionValidator *validator51 = new QRegularExpressionValidator(expr51);
    ui->lineEdit_51->setValidator(validator51);

    QRegularExpression expr52("[A-Z]{1}[a-z]{30}"); // Имя
    QRegularExpressionValidator *validator52 = new QRegularExpressionValidator(expr52);
    ui->lineEdit_52->setValidator(validator52);

    QRegularExpression expr53("8{1}[0-9]{10}"); // Номер телефона
    QRegularExpressionValidator *validator53 = new QRegularExpressionValidator(expr53);
    ui->lineEdit_53->setValidator(validator53);
}


MainWindow::~MainWindow()
{
    QSqlDatabase::removeDatabase("qt_sql_default_connection");
    writeSettings();
    delete ui;
}


// Подключение к базе данных
void MainWindow::on_actionConnect_triggered()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
    db.setConnectOptions("requiressl=1;connect_timeout=2");
    db.setHostName("rdbms.vt");
    db.setPort(5432);
    db.setDatabaseName("it_database");
    db.setUserName("vlad");
    db.setPassword("3");
    bool opened = db.open();
    if (opened) {
        qDebug() << "Connect success!";
    }
    else
        qDebug() << "Connect fail: " << db.lastError().text();

    sysintegrator = new Sysintegrator(this, db);
    ui->SysTableView->setModel(sysintegrator);
    ui->SysTableView->setItemDelegateForColumn(sysintegrator->fieldIndex("id_project"),
                                                      new QSqlRelationalDelegate(ui->SysTableView));
    ui->SysTableView->setItemDelegateForColumn(sysintegrator->fieldIndex("id_company"),
                                                      new QSqlRelationalDelegate(ui->SysTableView));
    sysintegrator->select();

    company = new Company(this, db);
    ui->CompanyTableView->setModel(company);
    company->select();

    project = new Project(this, db);
    ui->ProjectTableView->setModel(project);
    ui->ProjectTableView->setItemDelegateForColumn(project->fieldIndex("client_id"),
                                               new QSqlRelationalDelegate(ui->ProjectTableView));
    ui->ProjectTableView->setItemDelegateForColumn(project->fieldIndex("id_techno"),
                                               new QSqlRelationalDelegate(ui->ProjectTableView));
    project->select();

    client = new Client(this, db);
    ui->ClientTableView->setModel(client);
    client->select();

    techno = new Techno(this, db);
    ui->TechnoTableView->setModel(techno);
    techno->select();
}


//Чтение настроек
void MainWindow::readSettings()
{
    QSettings settings("PetrovVV", "cw-sysintegrator");
    settings.beginGroup("GraphicalInterface");
    resize(settings.value("size", QSize(800, 500)).toSize());
    QRect screenGeometry = QApplication::primaryScreen()->geometry();
    int x = (screenGeometry.width() - window()->width())/2;
    int y = (screenGeometry.height() - window()->height())/2;
    move(settings.value("pos", QPoint(x, y)).toPoint());
    settings.endGroup();
}


//Запись настроек
void MainWindow::writeSettings()
{
    QSettings settings("PetrovVV","cw-sysintegrator");
    settings.beginGroup("GraphicalInterface");
    settings.setValue("size",size());
    settings.setValue("pos",pos());
    settings.endGroup();
}


//Диалоговое окно об авторе
void MainWindow::on_actionAbout_programm_triggered()
{
    Dialog dialog;
    dialog.exec();
}


//Удаление данных из БД
void MainWindow::on_actionDelete_triggered()
{
    QSqlQuery query;
    bool ok;
    QStringList items;

    items << tr("sys_integrator") << tr("company") << tr("projects") << tr("techno") << tr("clients");
    QString text = QInputDialog::getItem(this, tr("Deleting data"),
                                         tr("Choose a table:"), items, 0, false, &ok);
    bool ook;
    int iValue = QInputDialog::getInt(this,
                                      tr("Deleting data"),
                                      tr("Enter id the string:"),
                                      0,
                                      0,
                                      1000000,
                                      1,
                                      &ook);

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    if (text == "sys_integrator"){
        query.prepare("DELETE FROM sys_integrator WHERE id_integrator = :id");
        query.bindValue(":id", iValue);
    }
    else if (text == "company"){
        query.prepare("DELETE FROM company WHERE id_company = :id");
        query.bindValue(":id", iValue);
    }
    else if (text == "projects"){
        query.prepare("DELETE FROM projects WHERE id_project = :id");
        query.bindValue(":id", iValue);
    }
    else if (text == "technologies"){
        query.prepare("DELETE FROM technologies WHERE id_technologies = :id");
        query.bindValue(":id", iValue);
    }
    else if (text == "clients"){
        query.prepare("DELETE FROM clients WHERE id_client = :id");
        query.bindValue(":id", iValue);
    }

    if (!query.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        QMessageBox::critical(this, tr("Application"),
                              query.lastError().text());
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    on_actionConnect_triggered();
    QMessageBox::information(this, tr("Application"),
                             tr("Entry deleted successfully!"));
}


//Вызов нового окна приложения
void MainWindow::on_actionNew_Window_triggered()
{
    MainWindow *mainWindow = new MainWindow;
    mainWindow->show();
}


//Добавление данных в таблицу sys_integretor
void MainWindow::on_pushButton_1_clicked()
{
    QString last_name = ui->lineEdit_11->text();
    QString first_name = ui->lineEdit_12->text();
    QString job_title = ui->lineEdit_13->text();
    QString phone_number = ui->lineEdit_14->text();
    QString salary = ui->lineEdit_15->text();
    int id_project = ui->spinBox_11->value();
    int id_company = ui->spinBox_12->value();

    // Подготовка SQL-запроса для вставки данных
    QString query = "INSERT INTO sys_integrator VALUES (DEFAULT, :last_name, :first_name, :job_title, :phone_number, :salary, :id_project, :id_company)";

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    // Выполнение SQL-запроса с данными
    QSqlQuery sqlQuery;
    sqlQuery.prepare(query);
    sqlQuery.bindValue(":last_name", last_name);
    sqlQuery.bindValue(":first_name", first_name);
    sqlQuery.bindValue(":job_title", job_title);
    sqlQuery.bindValue(":phone_number", phone_number);
    sqlQuery.bindValue(":salary", salary);
    sqlQuery.bindValue(":id_project", id_project);
    sqlQuery.bindValue(":id_company", id_company);

    if (!sqlQuery.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        qDebug() << sqlQuery.lastError().text();
        QMessageBox::critical(this, tr("Insert error"),
                              tr("Error with inserting data in table. \nInsert failed"));
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    QMessageBox::information(this, tr("Application"),
                             tr("Entry added successfully!"));
    sysintegrator->select();
    company->select();
    project->select();
    techno->select();
    client->select();
}


//Добавление данных в таблицу company
void MainWindow::on_pushButton_2_clicked()
{
    QString name_company = ui->lineEdit_22->text();
    QString address_company = ui->lineEdit_22->text();
    QString phone_number = ui->lineEdit_23->text();

    // Подготовка SQL-запроса для вставки данных
    QString query = "INSERT INTO company VALUES (DEFAULT, :name_company, :address_company, :phone_number)";

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    // Выполнение SQL-запроса с данными
    QSqlQuery sqlQuery;
    sqlQuery.prepare(query);
    sqlQuery.bindValue(":name_company", name_company);
    sqlQuery.bindValue(":address_company", address_company);
    sqlQuery.bindValue(":phone_number", phone_number);

    if (!sqlQuery.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        qDebug() << sqlQuery.lastError().text();
        QMessageBox::critical(this, tr("Insert error"),
                              tr("Error with inserting data in table. \nInsert failed"));
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    QMessageBox::information(this, tr("Application"),
                             tr("Entry added successfully!"));

    sysintegrator->select();
    company->select();
    project->select();
    techno->select();
    client->select();
}


//Добавление данных в таблицу projects
void MainWindow::on_pushButton_3_clicked()
{
    QString name_project = ui->lineEdit_31->text();
    QString date_project = ui->dateEdit_3->date().toString("yyyy-MM-dd");
    QString status_project = ui->lineEdit_32->text();
    int client_project = ui->spinBox_31->value();
    int id_techno = ui->spinBox_32->value();

    // Подготовка SQL-запроса для вставки данных
    QString query = "INSERT INTO projects VALUES (DEFAULT, :name_project, :date_project, :status_project, :client_project, :id_techno)";

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    // Выполнение SQL-запроса с данными
    QSqlQuery sqlQuery;
    sqlQuery.prepare(query);
    sqlQuery.bindValue(":name_project", name_project);
    sqlQuery.bindValue(":date_project", date_project);
    sqlQuery.bindValue(":status_project", status_project);
    sqlQuery.bindValue(":client_project", client_project);
    sqlQuery.bindValue(":id_techno", id_techno);

    if (!sqlQuery.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        qDebug() << sqlQuery.lastError().text();
        QMessageBox::critical(this, tr("Insert error"),
                              tr("Error with inserting data in table. \nInsert failed"));
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    QMessageBox::information(this, tr("Application"),
                             tr("Entry added successfully!"));

    sysintegrator->select();
    company->select();
    project->select();
    techno->select();
    client->select();
}


//Добавление данных в таблицу technologies
void MainWindow::on_pushButton_4_clicked()
{
    QString name_techno = ui->lineEdit_41->text();
    QString info_techno = ui->lineEdit_42->text();
    int degree_complexity = ui->spinBox_41->value();


    // Подготовка SQL-запроса для вставки данных
    QString query = "INSERT INTO technologies VALUES (DEFAULT, :name_techno, :info_techno, :degree_complexity)";

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    // Выполнение SQL-запроса с данными
    QSqlQuery sqlQuery;
    sqlQuery.prepare(query);
    sqlQuery.bindValue(":name_techno", name_techno);
    sqlQuery.bindValue(":info_techno", info_techno);
    sqlQuery.bindValue(":degree_complexity", degree_complexity);


    if (!sqlQuery.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        qDebug() << sqlQuery.lastError().text();
        QMessageBox::critical(this, tr("Insert error"),
                              tr("Error with inserting data in table. \nInsert failed"));
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    QMessageBox::information(this, tr("Application"),
                             tr("Entry added successfully!"));

    sysintegrator->select();
    company->select();
    project->select();
    techno->select();
    client->select();
}


//Добавление данных в таблицу clients
void MainWindow::on_pushButton_5_clicked()
{
    QString last_name = ui->lineEdit_51->text();
    QString first_name = ui->lineEdit_52->text();
    QString phone_number = ui->lineEdit_53->text();


    // Подготовка SQL-запроса для вставки данных
    QString query = "INSERT INTO clients VALUES (DEFAULT, :last_name, :first_name, :phone_number)";

    // Начало транзакции
    QSqlDatabase db = QSqlDatabase::database();
    if (!db.transaction()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Transaction error"),
                              tr("Error starting transaction. \nOperation failed"));
        return;
    }

    // Выполнение SQL-запроса с данными
    QSqlQuery sqlQuery;
    sqlQuery.prepare(query);
    sqlQuery.bindValue(":last_name", last_name);
    sqlQuery.bindValue(":first_name", first_name);
    sqlQuery.bindValue(":phone_number", phone_number);


    if (!sqlQuery.exec()) {
        // Откат транзакции в случае ошибки
        db.rollback();
        qDebug() << sqlQuery.lastError().text();
        QMessageBox::critical(this, tr("Insert error"),
                              tr("Error with inserting data in table. \nInsert failed"));
        return;
    }

    // Подтверждение транзакции
    if (!db.commit()) {
        qDebug() << db.lastError().text();
        QMessageBox::critical(this, tr("Commit error"),
                              tr("Error committing transaction. \nOperation failed"));
        return;
    }

    QMessageBox::information(this, tr("Application"),
                             tr("Entry added successfully!"));

    sysintegrator->select();
    company->select();
    project->select();
    techno->select();
    client->select();
}


//Поиск по таблицы sys_integrator
void MainWindow::on_pushButton_11_clicked()
{
    if(sysintegrator == nullptr)
        return;

    QString columnName;
    switch(ui->SearchcomboBox->currentIndex())
    {
    case 0: columnName = "last_name";            break;
    case 1: columnName = "first_name";           break;
    case 2: columnName = "job_title";            break;
    case 3: columnName = "phone_number";         break;
    case 4: columnName = "salary";               break;
    case 5: columnName = "name_project";         break;
    case 6: columnName = "name_company";         break;
    }

    sysintegrator->setFilter(QString("CAST(%1 AS TEXT) ILIKE '%%2%'").arg(columnName)
                               .arg(ui->lineEditSearch_1->text()));
    if(!sysintegrator->select())
        qDebug() << sysintegrator->lastError().text();
}


// Вычисления на стороне клиента
void MainWindow::on_action_Amount_of_salaries_triggered()
{
    int sum = 0;
    int rows = ui->SysTableView->model()->rowCount();
    for (int row = 0; row < rows; ++row)
    {
        QModelIndex index = sysintegrator->index(row, 5); // Индекс столбца с зарплатой
        sum += sysintegrator->data(index, Qt::DisplayRole).toInt();
        qDebug() << sum;
    }

    // Вывод суммы зарплат
    QMessageBox::information(nullptr, tr("Amount of salaries"), QString(tr("Total amout: %1")).arg(sum));
}


// Вычисления на стороне сервера
// Функция высчитвает количество проектов в определенной промежуток времени
void MainWindow::on_action_Project_Completion_triggered()
{
    // Вывод диалогового окна для ввода начальной даты
    QString startDateText = QInputDialog::getText(nullptr, tr("Select start date"), tr("Date:"));
    if (startDateText.isEmpty()) {
        return;
    }
    QDate startDate = QDate::fromString(startDateText, "dd.MM.yyyy");

    // Вывод диалогового окна для ввода конечной даты
    QString endDateText = QInputDialog::getText(nullptr, tr("Choose an end date"), tr("Date:"));
    if (endDateText.isEmpty()) {
        return;
    }
    QDate endDate = QDate::fromString(endDateText, "dd.MM.yyyy");


    QSqlQuery query;

    // Подготовка и выполнение запроса
    QString queryString = "SELECT COUNT(*) FROM projects WHERE date_project >= :startDate AND date_project <= :endDate";
    QSqlQuery sqlQuery;
    sqlQuery.prepare(queryString);
    sqlQuery.bindValue(":startDate", startDate);
    sqlQuery.bindValue(":endDate", endDate);
    if (!sqlQuery.exec()) {
        qDebug() << "Ошибка при выполнении запроса:" << sqlQuery.lastError().text();
    }

    int rowCount = 0;
    if (sqlQuery.next()) {
        rowCount = sqlQuery.value(0).toInt();
    }
    QMessageBox::information(nullptr, tr("Count project"), QString(tr("Count project: %1")).arg(rowCount));
}



