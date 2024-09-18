#include "tablemodel.h"

TableModel::TableModel(QObject *parent)
    :QSqlRelationalTableModel{parent}
{
    setEditStrategy(TableModel::EditStrategy::OnFieldChange);
}


int TableModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return rowsToShow;
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || index.row() + 1 > rowsToShow)
        return QVariant();
    return QSqlRelationalTableModel::data(index, role);
}

bool TableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid())
        return false;
    if(QSqlRelationalTableModel::setData(index, value, role))
    {
        submitAll();
        emit signalSelectAll(this);
        return true;
    }
    return false;
}

void TableModel::fetchMore(const QModelIndex &parent)
{
    if(parent.isValid())
        return;
    rowsToShow += qMin(FETCH_STEP, QSqlRelationalTableModel::rowCount(parent) - rowsToShow);
    emit layoutChanged(); // обновление модели (+ пересчет строк методом rowCount)
}


bool TableModel::canFetchMore(const QModelIndex &parent) const
{
    if(parent.isValid())
        return false;
    qDebug() << "Can fetch more";
    return (rowsToShow < QSqlRelationalTableModel::rowCount(parent));
}

QMimeData *TableModel::mimeData(const QModelIndexList &indexes) const
{
    qDebug() << "mimeData FUNCTION";
    if(indexes.isEmpty())
        return nullptr;
    if(!indexes.at(0).isValid())
        return nullptr;

    if (firstMimeType == "text/plain" && secondMimeType == "application/x-qabstractitemmodeldatalist")
    {
        QString result;

        int topSelectionRange = indexes.at(0).row();
        int leftSelectionRange = indexes.at(0).column();
        for (int i = 0; i < indexes.count(); ++i) {
            if (!indexes.at(i).isValid())
                return nullptr;

            int c = indexes.at(i).column() - leftSelectionRange;
            int r = indexes.at(i).row() - topSelectionRange;

            if (c > 0 && (c < 0 || indexes.at(i).row() == topSelectionRange))
                result += columnDelimiter;
            if (r > 0 && indexes.at(i).column() == leftSelectionRange)
                result += rowDelimiter;
            result += quotes +
                      indexes.at(i).data(Qt::DisplayRole).toString() +
                      quotes;
        }

        result += rowDelimiter;
        qDebug() << result;

        // создаем mimeData, которая будет использоваться для drop
        QMimeData *mimeData = new QMimeData;
        // создаем mimeDataForLocal для записи типа и mimeData для внутренних переносов
        QMimeData *mimeDataForLocal = QAbstractTableModel::mimeData(indexes);
        // записываем типы с данными для drop в mimeData
        mimeData->setData(secondMimeType, mimeDataForLocal->data(secondMimeType));
        mimeData->setData(firstMimeType, result.toUtf8());
        return mimeData;
    }

    return nullptr;
}

bool TableModel::dropMimeData(const QMimeData *data, Qt::DropAction action, int row, int column, const QModelIndex &parent)
{
    qDebug() << "dropMimeData FUNCTION";
    if(data == nullptr)
        return false;

    QByteArray dataforsecond = data->data(secondMimeType);
    QMimeData *forsecond = new  QMimeData;
    forsecond->setData(secondMimeType, dataforsecond);
    forsecond->setText(dataforsecond);

    if(data->hasFormat("application/x-qabstractitemmodeldatalist"))
    {
        return QAbstractTableModel::dropMimeData(forsecond, action, row, column, parent);
    }

    if (data->hasFormat("text/plain"))
    {
        QStringList strings;
        strings = data->text().split(rowDelimiter);

        for (int rowSelected = 0; rowSelected < strings.count(); ++rowSelected)
        {
            if ((row + rowSelected) >= rowCount(parent))
                insertRow(rowCount(parent));
            QStringList tokens = strings[rowSelected].split(columnDelimiter);
            for (int columnSelected = 0; columnSelected < tokens.count(); columnSelected++)
            {
                QString token = tokens[columnSelected];
                token.remove(quotes);
                if (token.isEmpty())
                    continue;
                QAbstractItemModel *item = new TableModel;
                item->setData(parent, token, Qt::EditRole);
                QMap<int, QVariant> k;
                setItemData(item->data(parent, Qt::DisplayRole).toModelIndex(), k);
                delete item;
            }
        }
        return true;
    }

    return false;
}



