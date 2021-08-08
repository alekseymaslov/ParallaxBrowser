#ifndef WEBPAGEHANDLER_H
#define WEBPAGEHANDLER_H

#include <QObject>
#include <QVector>

class WebPageHandler final : public  QObject
{
private:
    const QObject* firstPage = nullptr;
public:
    WebPageHandler(const QObject* inBasePage);
    
    ~WebPageHandler();

public slots:
    void AddPage();

    void RemovePage();
};

#endif // WEBPAGEHANDLER_H
