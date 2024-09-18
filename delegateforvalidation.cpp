#include "delegateforvalidation.h"
#include <QLineEdit>
#include <QRegularExpression>
#include <QRegularExpressionValidator>
#include <QDebug>

DelegateForValidation::DelegateForValidation(QWidget *parent):
    QStyledItemDelegate(parent)
{}

// установка валидаторов для столбцов
QWidget *DelegateForValidation::createEditor(QWidget *parent, \
                                             const QStyleOptionViewItem &option, \
                                             const QModelIndex &index) const
{
    Q_UNUSED(option)
    QLineEdit *lineEdit = new QLineEdit(parent);
    QRegularExpression expr;
    expr.setPattern("8{1}[0-9]{10}");
    QRegularExpressionValidator *validator = new QRegularExpressionValidator(expr);

    lineEdit->setValidator(validator);
    return lineEdit;
}
