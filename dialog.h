#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>

namespace Ui {
class Dialog;
}

/**
 * @brief Класс диалогового окна "О авторе" Dialog
 *
 * Класс наследуется от QDialog. Класс диалогового окна, которое вызывается в случае срабатывания action
 * из главного окна (класса MainWindow). Выводит основную информацию об авторе
 * работы
 */
class Dialog : public QDialog
{
    Q_OBJECT

public:
    /**
     * @brief Конструктор класса Dialog
     * @param parent - указатель на родительский объект
     */
    explicit Dialog(QWidget *parent = nullptr);

    /**
     * @brief Деструктор класса Dialog
     */
    ~Dialog();

private:
    Ui::Dialog *ui;
};

#endif // DIALOG_H.

