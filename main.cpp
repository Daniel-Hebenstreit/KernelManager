#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSysInfo>
#include <QDebug>
#include "kernelmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //KernelManager manager;

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("KernelManager", "Main");

    return app.exec();
}
