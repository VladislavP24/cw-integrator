#include "sysintegrator.h"

Sysintegrator::Sysintegrator(QObject *parent, QSqlDatabase &iDb)
    : TableModel{parent},
    db(&iDb)
{
    setTable(TABLE_NAME);

    setRelation(fieldIndex("id_project"),
                QSqlRelation("projects", "id_project", "name_project"));

    setRelation(fieldIndex("id_company"),
                QSqlRelation("company", "id_company", "name_company"));
}

QVariant Sysintegrator::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() + 1 > rowsToShow)
        return QVariant();
    return TableModel::data(index, role);
}

QVariant Sysintegrator::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role != Qt::DisplayRole)
        return QVariant();

    if(orientation == Qt::Vertical)
        return QVariant(section + 1);
    if(orientation == Qt::Horizontal)
        switch(section)
        {
        case 0: return tr("id_integrator");
        case 1: return tr("last_name");
        case 2: return tr("first_name");
        case 3: return tr("job_title");
        case 4: return tr("phone_number");
        case 5: return tr("salary");
        case 6: return tr("id_project");
        case 7: return tr("id_company");
        }
    return QVariant();
}

Qt::ItemFlags Sysintegrator::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    switch(index.column())
    {
    case 0:return defaultFlags;
    case 1:return defaultFlags | Qt::ItemIsEditable;
    case 2:return defaultFlags | Qt::ItemIsEditable;
    case 3:return defaultFlags | Qt::ItemIsEditable;
    case 4:return defaultFlags | Qt::ItemIsEditable;
    case 5:return defaultFlags | Qt::ItemIsEditable;
    case 6:return defaultFlags | Qt::ItemIsEditable;
    case 7:return defaultFlags | Qt::ItemIsEditable;
    default: return Qt::NoItemFlags;
    }
}
