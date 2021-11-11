#ifndef SCREENHANDLER_H
#define SCREENHANDLER_H

#include <QObject>
#include <QApplication>

class ScreenHandler : public QObject
{
    Q_OBJECT
    QObject* mSwipeView = nullptr;
public:
    explicit ScreenHandler(QObject* inSwipeView, QObject *parent = nullptr);

public slots:
    void CheckState(Qt::ApplicationState inState);
};

#endif // SCREENHANDLER_H
