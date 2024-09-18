#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QSqlRelationalTableModel>
#include <QMimeData>
#include <QDebug>

/**
 * @brief Класс модели таблицы
 */
class TableModel: public QSqlRelationalTableModel
{
    Q_OBJECT


protected:
    const int FETCH_STEP = 20; /**< Количество строк, загружаемых за один раз */
    int rowsToShow = 0; /**< Количество строк, отображаемых в данный момент */

    /**
     * @brief Флаги элементов таблицы по умолчанию
     */
    Qt::ItemFlags defaultFlags = Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsDragEnabled;

    QString firstMimeType = "text/plain"; /**< 1 MIME-тип для drag&drop */
    QString secondMimeType = "application/x-qabstractitemmodeldatalist"; /**< 2 MIME-тип для drag&drop */
    QString columnDelimiter = ";"; /**< Разделитель столбцов */
    QString rowDelimiter = "\n"; /**< Разделитель строк */
    QString quotes = "\""; /**< Кавычки */

public:
    /**
     * @brief Конструктор класса
     * @param parent Родительский объект
     */
    explicit TableModel(QObject *parent = nullptr); //Конструктор класса

    /**
     * @brief Возвращает количество строк в модели
     * @param parent Родительский индекс
     * @return Количество строк
     */
    int rowCount(const QModelIndex &parent) const override; //Возвращает количество строк в модели

    /**
     * @brief Возвращает данные для указанного индекса и роли
     * @param index Индекс
     * @param role Роль
     * @return Данные
     */
    QVariant data(const QModelIndex &index, int role) const override; //Возвращает данные для указанного индекса и роли

    /**
     * @brief Устанавливает данные для указанного индекса и роли
     * @param index Индекс
     * @param value Значение
     * @param role Роль
     * @return true, если данные были установлены успешно, иначе false
     */
    bool setData(const QModelIndex &index, const QVariant &value, int role) override; //Устанавливает данные для указанного индекса и роли

    /**
     * @brief Загружает дополнительные строки
     * @param parent Родительский индекс
     */
    void fetchMore(const QModelIndex &parent) override; //Загружает дополнительные строки

    /**
     * @brief Проверяет, можно ли загрузить дополнительные строки. Можно загружать,
     * когда пользователь достиг последней видимой строки, и в БД есть еще строки
     * @param parent Родительский индекс
     * @return true, если можно загрузить дополнительные строки, иначе false
     */
    bool canFetchMore(const QModelIndex &parent) const override; //Проверяет, можно ли загрузить дополнительные строки. Можно загружать, когда пользователь достиг последней видимой строки, и в БД есть еще строки

    /**
     * @brief Возвращает MIME-данные для указанных индексов
     * @param indexes Индексы
     * @return MIME-данные
     */
    QMimeData *mimeData(const QModelIndexList &indexes) const override; //Возвращает MIME-данные для указанных индексов

    /**
     * @brief Обрабатывает MIME-данные, бросаемые на модель
     * @param data MIME-данные
     * @param action Действие
     * @param row Строка
     * @param column Столбец
     * @param parent Родительский индекс
     * @return true, если данные были обработаны успешно, иначе false
     */
    bool dropMimeData(const QMimeData *data, Qt::DropAction action, int row, int column, const QModelIndex &parent) override; //Обрабатывает MIME-данные, бросаемые на модель

signals:
    void signalSelectAll(void* parent = nullptr);
};

#endif // TABLEMODEL_H

