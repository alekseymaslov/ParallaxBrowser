#include <QDebug>
#include <QVector>
#include <QFile>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

#include "pagehandler.h"



PageHandler::PageHandler(QObject* inSwipeView, const QString& inPathToSaves) : mSwipeView(inSwipeView), mPathToSaves(inPathToSaves)
{
    assert(inSwipeView != nullptr);
}

PageHandler::~PageHandler()
{
    qDebug() << "~PreExit()";
}

const QString PageHandler::GetPagesPath()
{
#ifdef Q_OS_UNIX
   return  QString(mPathToSaves + "/" + mFileName);
#elif Q_OS_WINDOWS
    return QString(mPathToSaves + "\\" + mFileName);
#endif
}
//FIXME: bug load or save
void PageHandler::LoadPages()
{
    QString rough;
    QJsonDocument jsonDoc;
    QJsonObject jsonBase;
    QJsonArray jsonPages;
    QJsonValue jsonPagesValue;

    QFile file(GetPagesPath());
    if(!file.open(QIODevice::ReadOnly)) {
        return ;
    }
    rough = file.readAll();
    file.close();
    jsonDoc = QJsonDocument::fromJson(rough.toUtf8());
    jsonBase = jsonDoc.object();
    jsonPagesValue = jsonBase["Pages"];//TODO: to const
    jsonPages = jsonPagesValue.toArray();
    for(int i = (jsonPages.count() - 1); 0 <= i; i--)
    {
         QJsonObject jsonPage = jsonPages[i].toObject();
         qDebug() << jsonPage[QString(i)].toString();

         QMetaObject::invokeMethod(mSwipeView, "addPage",
                  Q_ARG(QString, QString(jsonPage[QString(i)].toString())));
    }
}

void PageHandler::SavePages()
{
    QVector<QString> pageToSave;
    QVariant returnedValue;

    QFile file(GetPagesPath());

    QJsonObject jsonBase;
    QJsonArray jsonPages;
    if(!file.open(QIODevice::WriteOnly)) {
        return ;
    }


    QMetaObject::invokeMethod(mSwipeView, "getPageCount",
            Q_RETURN_ARG(QVariant, returnedValue));
    int pageCount = returnedValue.toInt();
    for(int i = 0; i < pageCount; i++ )
    {
         QString page;
         QMetaObject::invokeMethod(mSwipeView, "getPagesMetaData",
                 Q_RETURN_ARG(QString, page),
                 Q_ARG(QVariant, QVariant(i)));

         if(!page.isEmpty())
         {
             pageToSave.push_back(page);
             qDebug() << page;
             QJsonObject jsonPage;
             jsonPage.insert(QString(i), page);
             jsonPages.append(jsonPage);
         }
    }
    jsonBase.insert("Pages", jsonPages);//TODO: to const
    QJsonDocument jsonDoc;
    jsonDoc.setObject(jsonBase);
    file.write(jsonDoc.toJson());
    file.close();
}
