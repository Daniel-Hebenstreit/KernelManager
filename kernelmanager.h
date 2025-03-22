#ifndef KERNELMANAGER_H
#define KERNELMANAGER_H

#include <QObject>
#include <QSysInfo>
#include <QDebug>
#include <QQmlEngine>
#include <QProcess>
#include <QRegularExpression>

class KernelManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit KernelManager(QObject *parent = nullptr);

    Q_INVOKABLE static QString currentKernel();
    Q_INVOKABLE QStringList listInstalledKernels();
    Q_INVOKABLE QStringList listArchKernels();
    //Q_INVOKABLE QStringList listManjaroKernels();

signals:
};

#endif // KERNELMANAGER_H
