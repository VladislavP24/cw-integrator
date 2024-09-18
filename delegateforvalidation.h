#ifndef DELEGATEFORVALIDATION_H
#define DELEGATEFORVALIDATION_H

#include <QStyledItemDelegate>

/**
 * @brief Класс делегатов для валидации вводимых данных DelegateForValidation
 *
 * Класс наследуется от QStyleItemDelegate. Используется при вводе данных в модель. Используются регулярные
 * выражения для возможности ввода только верных по формату данных.
 */
class DelegateForValidation : public QStyledItemDelegate
{
    Q_OBJECT
public:
    /**
     * @brief Конструктор класса DelegateForValidation
     * @param parent Указатель на объект родителя (обнуленный указатель)
     */
    explicit DelegateForValidation(QWidget *parent = nullptr);

    // QAbstractItemDelegate interface
public:
    /**
     * @brief метод createEditor
     * является переопределенным и константным, реализует проверку вводимых
     * данных
     * @param parent Указатель на объект родителя
     * @param option Ссылка на опции (параметры описания вмиджета)
     * @param index Ссылка на индекс ячейки, которая будет проверяться
     * @return указатель на виджет text editor с введенными значениями
     */
    QWidget *createEditor(QWidget *parent, \
                          const QStyleOptionViewItem &option, \
                          const QModelIndex &index) const override;
};

#endif // DELEGATEFORVALIDATION_H
