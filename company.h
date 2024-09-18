#ifndef COMPANY_H
#define COMPANY_H

#include "tablemodel.h"

/**
 * @class Company
 * @brief Класс, представляющий модель таблицы для компаний.
 * Унаследован от класса TableModel.
 */
class Company : public TableModel
{
private:
    QSqlDatabase *db {nullptr}; /**< Указатель на объект базы данных. */
    const QString TABLE_NAME = "company"; /**< Название таблицы компаний в базе данных. */
public:
    /**
     * @brief Конструктор класса Company
     * @param parent - указатель на родительский объект
     * @param iDb - ссылка на объект базы данных
     */
    explicit Company(QObject *parent, QSqlDatabase &iDb);

    /**
     * @brief Получение данных для указанного индекса и роли.
     * @param index Индекс элемента в модели.
     * @param role Роль элемента (например, Qt::DisplayRole или Qt::EditRole).
     * @return Значение элемента, представленное типом QVariant.
     */
    QVariant data(const QModelIndex &index, int role) const override;

    /**
     * @brief Получение заголовка для указанного раздела и ориентации.
     * @param section Номер раздела (например, столбец таблицы).
     * @param orientation Ориентация заголовка (горизонтальная или вертикальная).
     * @param role Роль элемента (например, Qt::DisplayRole или Qt::EditRole).
     * @return Заголовок элемента, представленный типом QVariant.
     */
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;

    /**
     * @brief Получение флагов элемента для указанного индекса.
     * @param index Индекс элемента в модели.
     * @return Флаги элемента, представленные типом Qt::ItemFlags.
     */
    Qt::ItemFlags flags(const QModelIndex &index) const override;
};

#endif // COMPANY_H
