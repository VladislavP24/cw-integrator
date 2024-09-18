#ifndef CLIENTS_H
#define CLIENTS_H

#include "tablemodel.h"

/**
 * @brief Класс модели данных для таблицы клиентов
 */
class Client: public TableModel
{
private:
    QSqlDatabase *db {nullptr}; /**< Указатель на объект базы данных */
    const QString TABLE_NAME = "clients"; /**< Имя таблицы в базе данных */

public:
    /**
     * @brief Конструктор класса Client
     * @param parent - указатель на родительский объект
     * @param iDb - ссылка на объект базы данных
     */
    explicit Client(QObject *parent, QSqlDatabase &iDb);

    /**
     * @brief Возвращает данные для указанного индекса и роли
     * @param index - индекс элемента
     * @param role - роль элемента
     * @return данные элемента
     */
    QVariant data(const QModelIndex &index, int role) const override;

    /**
     * @brief Возвращает данные заголовка для указанного раздела, ориентации и роли
     * @param section - номер раздела
     * @param orientation - ориентация
     * @param role - роль элемента
     * @return данные заголовка элемента
     */
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;

    /**
     * @brief Возвращает флаги элемента для указанного индекса
     * @param index - индекс элемента
     * @return флаги элемента
     */
    Qt::ItemFlags flags(const QModelIndex &index) const override;
};

#endif // CLIENTS_H
