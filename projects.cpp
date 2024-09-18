#include "projects.h"

Project::Project(QObject *parent, QSqlDatabase &iDb)
    :TableModel{parent},
    db(&iDb)
{
    setTable(TABLE_NAME);

    setRelation(fieldIndex("client_project"),
                QSqlRelation("clients", "id_client", "last_name"));

    setRelation(fieldIndex("id_techno"),
                QSqlRelation("technologies", "id_techno", "name_techno"));
}

QVariant Project::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() + 1 > rowsToShow)
        return QVariant();
    return TableModel::data(index, role);
}

QVariant Project::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role != Qt::DisplayRole)
        return QVariant();

    if(orientation == Qt::Vertical)
        return QVariant(section + 1);
    if(orientation == Qt::Horizontal)
        switch(section)
        {
        case 0: return tr("id_project");
        case 1: return tr("name_project");
        case 2: return tr("date_project");
        case 3: return tr("status_project");
        case 4: return tr("client_project");
        case 5: return tr("id_techno");
        }
    return QVariant();
}

Qt::ItemFlags Project::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    switch(index.column())
    {
    case 0: return defaultFlags;
    case 1: return defaultFlags | Qt::ItemIsEditable;
    case 2:return defaultFlags  | Qt::ItemIsEditable;
    case 3:return defaultFlags  | Qt::ItemIsEditable;
    case 4:return defaultFlags  | Qt::ItemIsEditable;
    case 5:return defaultFlags  | Qt::ItemIsEditable;
    default: return Qt::NoItemFlags;
    }
}
