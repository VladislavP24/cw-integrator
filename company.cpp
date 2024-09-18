#include "company.h"

Company::Company(QObject *parent, QSqlDatabase &iDb)
    :TableModel{parent},
    db(&iDb)
{
    setTable(TABLE_NAME);
}


QVariant Company::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() + 1 > rowsToShow)
        return QVariant();
    return TableModel::data(index, role);
}

QVariant Company::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role != Qt::DisplayRole)
        return QVariant();

    if(orientation == Qt::Vertical)
        return QVariant(section + 1);
    if(orientation == Qt::Horizontal)
        switch(section)
        {
        case 0: return tr("id_company");
        case 1: return tr("name_company");
        case 2: return tr("address_company");
        case 3: return tr("phone_number");
        }
    return QVariant();
}

Qt::ItemFlags Company::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    switch(index.column())
    {
    case 0: return defaultFlags;
    case 1: return defaultFlags | Qt::ItemIsEditable;
    case 2:return defaultFlags | Qt::ItemIsEditable;
    case 3:return defaultFlags | Qt::ItemIsEditable;
    default: return Qt::NoItemFlags;
    }
}
