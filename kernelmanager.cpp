#include "kernelmanager.h"
#include <QFile>

KernelManager::KernelManager(QObject *parent)
    : QObject{parent}
{}

// get the currently used kernel
QStringList KernelManager::currentKernel()
{
    QString kernelString = QSysInfo::kernelVersion();
    QStringList kernelList = {kernelString};
    return kernelList;
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

    //process.start("/bin/bash", QStringList() << "-c" << "pacman -Ss ^linux$");
    // get list directly from arch linux archive

    process.start("/bin/bash", QStringList() << "-c"
                                             << "curl -s https://archive.archlinux.org/packages/l/linux/ | "
                                                "grep -o 'linux-[0-9].*-x86_64.pkg.tar.zst' | "
                                                "sort -V | uniq | sed 's/\">.*//' | grep -v '.sig'");

    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QStringList list = output.split("\n", Qt::SkipEmptyParts);
    //qDebug() << "List: " << list;

    return list;
}


// Get selected kernel
QString KernelManager::selectedKernel() const
{
    return m_selectedKernel;
}


// set selected kernel
void KernelManager::setSelectedKernel(const QString &newSelectedKernel)
{
    if (m_selectedKernel == newSelectedKernel)
        return;
    m_selectedKernel = newSelectedKernel;
    emit selectedKernelChanged();

    qDebug() << "Selected Kernel: " << m_selectedKernel;
}


// install kernel from Arch Linux Archive
QString KernelManager::installKernel(QString kernel)
{
    // 1. create URL and download kernel
    QString url = "https://archive.archlinux.org/packages/l/linux/" + m_selectedKernel;
    QString filePath = "/tmp/" + m_selectedKernel;
    QProcess curlProcess;
    curlProcess.start("curl", QStringList() << "-o" << filePath << url);
    curlProcess.waitForFinished();

    qDebug() << "filepath: " << filePath;

    // check if download was successfull
    if (!QFile::exists(filePath)) {
        return "Download failed. No file found.";
    }

    // log terminal output
    QString curlOutput = curlProcess.readAllStandardOutput();
    QString curlError = curlProcess.readAllStandardError();

    qDebug() << "Curl Output: " << curlOutput;
    qDebug() << "Curl Error: " << curlError;

    if (curlProcess.exitCode() != 0) {
        return "Download error: " + curlError;
    }


    // 2. install downloaded kernel
    QProcess installProcess;

    // create bash command for pacman package manager
    // sudo doesn't work with QProcess -> use pkexec
    QString bashCommand = "pkexec pacman -U --noconfirm " + filePath;
    //QString bashCommand = "pkexec bash -c 'yes | pacman -U " + filePath + "'";


    installProcess.start("/bin/bash", QStringList() << "-c" << bashCommand);
    installProcess.waitForFinished(-1);

    // log terminal output
    QString installOutput = installProcess.readAllStandardOutput();
    QString installError = installProcess.readAllStandardError();

    qDebug() << "Output: " << installOutput;
    qDebug() << "Error: " << installError;

    if (installProcess.exitCode()!= 0) {
        return "Error while installing kernel: " + installError;
    }

    return "Kernel " + kernel + " was successfull installed";
}
