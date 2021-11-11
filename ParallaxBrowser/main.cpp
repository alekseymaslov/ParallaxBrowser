#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine>
#include <QWebEngineProfile>
#include <QDir>
#include <QDebug>

#include <iostream>
#include <memory>
#include <chrono>
#include <future>

#include "remapkeys.h"
#include "pagehandler.h"
#include "screenhandler.h"
#include "messagehandler.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QtWebEngine::initialize();
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    
    std::shared_ptr<RemapKeys> remapKeys =  std::make_shared<RemapKeys>();
    app.installEventFilter(remapKeys.get());

    auto root = engine.rootObjects()[0];
    QObject *swipeViewWebPages = root->findChild<QObject*>("swipeViewWebPages");
    PageHandler pageHandler(swipeViewWebPages, app.applicationDirPath());
    ScreenHandler sreenHandler(swipeViewWebPages);
    MessageHandler messageHandler(root);

    pageHandler.LoadPages();
    messageHandler.Init();
    
    QObject::connect(QCoreApplication::instance(), SIGNAL(aboutToQuit()), &pageHandler, SLOT(SavePages()));

    QObject::connect(&app, SIGNAL(applicationStateChanged(Qt::ApplicationState)), &sreenHandler, SLOT(CheckState(Qt::ApplicationState)));


    qDebug() << QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    qDebug() <<app.applicationDirPath();


    int result = app.exec();
    return result;
}
