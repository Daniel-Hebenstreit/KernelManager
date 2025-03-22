#include "kernelmanager.h"

KernelManager::KernelManager(QObject *parent)
    : QObject{parent}
{}

QString KernelManager::currentKernel()
{
    return QSysInfo::kernelVersion();
}

QStringList KernelManager::listInstalledKernels()
{
    // create instance
    QProcess process;

    // create list of all installed kernels in /boot directory
    // bash command: file /boot/* | grep 'Linux kernel.*boot executable' | sed 's/.*version \([^ ]\+\).*/\1/'
    process.start("/bin/bash", QStringList() << "-c" << "file /boot/* | grep 'Linux kernel.*boot executable' | sed 's/.*version \\([^ ]\\+\\).*/\\1/'");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QStringList list = output.split("\n", Qt::SkipEmptyParts);

    return list;
}

QStringList KernelManager::listArchKernels()
{
    QProcess process;

    process.start("/bin/bash", QStringList() << "-c" << "pacman -Ss ^linux$");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QStringList list = output.split("\n", Qt::SkipEmptyParts);


    // Format list
    QStringList filteredList;

    // Remove prefix 'core/linuxXYZ-rt '
    static const QRegularExpression regex("^core/linux[0-9]+(-rt)?\\s+|\\s*\\[[^\\]]+\\]$");

    // Remove descriptions (second line in results, e.g. 'The Linux54 kernel and modules')
    for (QString &line : list) {
        if (!line.startsWith(" ")) {
            line.remove(regex);
            filteredList.append(line);
        }
    }

    return filteredList;
}
