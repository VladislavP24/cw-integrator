#include "techno.h"

Techno::Techno(QObject *parent, QSqlDatabase &iDb)
    :TableModel{parent},
    db(&iDb)
{
    setTable(TABLE_NAME);
}


QVariant Techno::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() + 1 > rowsToShow)
        return QVariant();
    return TableModel::data(index, role);
}

QVariant Techno::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role != Qt::DisplayRole)
        return QVariant();

    if(orientation == Qt::Vertical)
        return QVariant(section + 1);
    if(orientation == Qt::Horizontal)
        switch(section)
        {
        case 0: return tr("id_techno");
        case 1: return tr("name_techno");
        case 2: return tr("info_techno");
        case 3: return tr("degree_complexity");
        }
    return QVariant();
}

Qt::ItemFlags Techno::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    switch(index.column())
    {
    case 0: return defaultFlags;
    case 1: return defaultFlags | Qt::ItemIsEditable;
    case 2: return defaultFlags | Qt::ItemIsEditable;
    case 3: return defaultFlags | Qt::ItemIsEditable;
    default: return Qt::NoItemFlags;
    }
}
