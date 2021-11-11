#ifndef MESSAGEHANDLER_H
#define MESSAGEHANDLER_H

#include <QObject>
#include <QApplication>

class MessageHandler : public QObject
{
    Q_OBJECT
    QObject* mRoot = nullptr;
public:
    explicit MessageHandler(QObject* inRoot, QObject *parent = nullptr);

    void Init();
signals:

public slots:
    void Notification(const QString &title, const QString &msg);
};

#endif // MESSAGEHANDLER_H
