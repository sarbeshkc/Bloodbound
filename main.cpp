#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "DatabaseManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Create an instance of DatabaseManager
    DatabaseManager dbManager;

    QQmlApplicationEngine engine;

    // Register DatabaseManager type with QML
    qmlRegisterType<DatabaseManager>("com.bloodbound", 1, 0, "DatabaseManager");

    // Set DatabaseManager instance as a context property
    engine.rootContext()->setContextProperty("dbManager", &dbManager);


    // Load the main QML file
    const QUrl url(QStringLiteral("../../MainView.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
