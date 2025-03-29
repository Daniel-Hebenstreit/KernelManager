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

    Q_PROPERTY(QString selectedKernel READ selectedKernel WRITE setSelectedKernel NOTIFY selectedKernelChanged FINAL)

public:
    explicit KernelManager(QObject *parent = nullptr);

    Q_INVOKABLE static QStringList currentKernel();
    Q_INVOKABLE QStringList listInstalledKernels();
    Q_INVOKABLE QStringList listArchArchiveKernels();
    //Q_INVOKABLE QStringList listManjaroKernels();
    Q_INVOKABLE QString installKernel(QString kernel);


    QString selectedKernel() const;
    void setSelectedKernel(const QString &newSelectedKernel);

signals:
    void selectedKernelChanged();
private:
    QString m_selectedKernel;
};

#endif // KERNELMANAGER_H
