#include "kernelmanager.h"

KernelManager::KernelManager(QObject *parent)
    : QObject{parent}
{}

// get the currently used kernel
QString KernelManager::currentKernel()
{
    return QSysInfo::kernelVersion();
}


// get a list of all installed kernels
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


// get a list of all official and supported kernels (only arch-based distros or distros using pacman)
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


//
// QString KernelManager::selectedKernel(const QString &kernel)
// {
//     qDebug() << "Selected Kernel:" << kernel;
//     return kernel;
// }

// QString KernelManager::installKernel(QString kernel)
// {
//     QProcess process;
//     process.start("bin/bash", )
// }

QString KernelManager::selectedKernel() const
{
    //qDebug() << "Selected Kernel:" << selectedKernel;
    return m_selectedKernel;
}

void KernelManager::setSelectedKernel(const QString &newSelectedKernel)
{
    if (m_selectedKernel == newSelectedKernel)
        return;
    m_selectedKernel = newSelectedKernel;
    emit selectedKernelChanged();
    qDebug() << "Selected Kernel: " << m_selectedKernel;

}
