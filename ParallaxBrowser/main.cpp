#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <webpagehandler.h>

int main(int argc, char *argv[])
{
    
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    
//     QObject *rootObject = engine.rootObjects().first();
//     QObject *frameForWebPage = rootObject->findChild<QObject*>("frameForWebPage");
//     
//     WebPageHandler webpagehandler(frameForWebPage);
//     QObject *roundButtonNewPage = rootObject->findChild<QObject*>("roundButtonNewPage");
//     QObject::connect(roundButtonNewPage, SIGNAL(clicked()),
//         &webpagehandler, SLOT(AddPage()));

    

    return app.exec();
}
