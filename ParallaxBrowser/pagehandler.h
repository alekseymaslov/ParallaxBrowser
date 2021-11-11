#ifndef PREEXIT_H
#define PREEXIT_H

#include <QObject>
#include <QString>

class PageHandler: public QObject
{
    Q_OBJECT
    QObject* mSwipeView = nullptr;
    const QString mPathToSaves;
    const QString mFileName = "pages.json";
public:
    PageHandler(QObject* inSwipeView, const QString& inPathToSaves);
    virtual ~PageHandler();
private:
    const QString GetPagesPath();
public slots:
    void LoadPages();
    void SavePages();
};

#endif // PREEXIT_H
