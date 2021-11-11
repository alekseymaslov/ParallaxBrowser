#include <QDebug>

#include "screenhandler.h"


ScreenHandler::ScreenHandler(QObject* inSwipeView, QObject *parent) :  QObject(parent), mSwipeView(inSwipeView)
{

}


void ScreenHandler::CheckState(Qt::ApplicationState inState)
{
    if(Qt::ApplicationState::ApplicationInactive == inState)
    {
        qDebug() << "ApplicationInactive";
        QMetaObject::invokeMethod(mSwipeView, "setForcePageActive", Q_ARG(bool, true));
    }
    else if(Qt::ApplicationState::ApplicationActive == inState)
    {
        qDebug() << "ApplicationActive";
        QMetaObject::invokeMethod(mSwipeView, "setForcePageActive", Q_ARG(bool, false));
    }
}
