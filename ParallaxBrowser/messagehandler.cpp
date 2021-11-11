
#include <QDebug>

#include "messagehandler.h"

MessageHandler::MessageHandler(QObject* inRoot, QObject *parent) :  QObject(parent), mRoot(inRoot)
{

}

void MessageHandler::Init()
{
    QObject::connect(mRoot, SIGNAL(onNotificationRecived(QString, QString)),
                         this, SLOT(Notification(QString, QString)));

}

void MessageHandler::Notification(const QString& title, const QString &msg)
{
    qDebug() << "Notification title:" << title;
    qDebug() << "Notification message:" << msg;

    QString separator(" ");
    QString quote("\"");
    QString notification("notify-send");

    notification.append(separator).append(quote).append(title).append(quote).append(separator).append(quote).append(msg).append(quote);

    system(notification.toStdString().c_str());
}
