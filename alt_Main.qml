import QtQuick
import QtQuick.Controls

//import KernelManager

Window {
    id: root

    width: 640
    height: 510
    visible: true
    color: "#2e2d2c"
    title: qsTr("Linux Kernel Manager")

    property string textColor: "white"
    property string backgroundColor: "teal" //"#595854"
    property bool labelFontBold: true
    property int labelFontSize: 17
    property int listFontSize: 16
    property int radius: 5

    KernelManager {
        id: manager
    }
    Item {
        id: container

        anchors.fill: parent


        Item {
            id: itemListsId

            width: parent.width - 18
            height: parent.height - 35
            //anchors.centerIn: parent
            anchors {
                top: parent.top
                bottom: itemButtonsId.top
                left: parent.left
                right: parent.right
            }

            // Currently used kernel
            Label {
                id: labelUsedKernelId

                anchors {
                    top: parent.top
                    left: parent.left
                }

                text: "Used Kernel"
                font.bold: root.labelFontBold
                font.pixelSize: root.labelFontSize
                color: root.textColor
                padding: 5

                background: Rectangle {
                    color: root.backgroundColor
                    implicitWidth: 150
                    implicitHeight: 30
                    topLeftRadius: root.radius
                    topRightRadius: root.radius

                }
            }

            Rectangle {
                id: listUsedKernelId

                anchors {
                    top: labelUsedKernelId.bottom
                    left: parent.left
                    right: parent.right
                }

                width: parent.width
                height: 35
                color: root.backgroundColor
                topRightRadius: root.radius
                bottomLeftRadius: root.radius
                bottomRightRadius: root.radius

                Text {
                    anchors.centerIn: parent
                    text: manager.currentKernel()
                    color: root.textColor
                    font.pixelSize: root.listFontSize
                }
            }

            // Installed kernels
            Label {
                id: labelInstalledKernelsId

                anchors {
                    top: listUsedKernelId.bottom
                    left: parent.left
                    topMargin: 15
                }

                text: "Installed Kernels"
                font.bold: root.labelFontBold
                font.pixelSize: root.labelFontSize
                color: root.textColor
                padding: 5

                background: Rectangle {
                    color: root.backgroundColor
                    implicitWidth: 150
                    implicitHeight: 30
                    topLeftRadius: root.radius
                    topRightRadius: root.radius

                }
            }


            ListView {
                id: listInstalledKernelsId

                anchors {
                    top: labelInstalledKernelsId.bottom
                    left: parent.left
                }

                height: Math.max(Math.min(listInstalledKernelsId.count * 35, root.height/4), 35)
                width: parent.width
                clip: true

                model: manager.listInstalledKernels()
                delegate: installedDelegateId

                ScrollBar.vertical: ScrollBar {}
            }

            Component {
                id: installedDelegateId

                Rectangle {
                    width: parent.width
                    height: 35
                    color: root.backgroundColor

                    topRightRadius: index === 0 ? root.radius : 0 // if index == 0 {radius = root.radius} else {radius = 0}
                    bottomLeftRadius: index === (listInstalledKernelsId.count - 1) ? root.radius : 0
                    bottomRightRadius: bottomLeftRadius

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: root.listFontSize
                        color: root.textColor
                        text: modelData
                    }
                }
            }


            // Available kernels
            Label {
                id: labelAvailableKernelsId

                anchors {
                    top: listInstalledKernelsId.bottom
                    left: parent.left
                    topMargin: 15
                }

                text: "Available Arch Kernels"
                font.bold: root.labelFontBold
                font.pixelSize: root.labelFontSize
                color: root.textColor
                padding: 5

                background: Rectangle {
                    color: root.backgroundColor
                    implicitWidth: 150
                    implicitHeight: 30
                    topLeftRadius: root.radius
                    topRightRadius: root.radius

                }
            }

            ListView {
                id: listAvailableKernelsId

                anchors {
                    top: labelAvailableKernelsId.bottom
                    bottom: itemListsId.bottom
                    bottomMargin: 15
                    left: parent.left
                }

                width: parent.width
                height: Math.max(Math.min(listAvailableKernelsId.count * 35, root.height/3), 35)
                clip: true

                model: manager.listArchKernels()
                delegate: availableDelegateId

                ScrollBar.vertical: ScrollBar {
                    //policy: ScrollBar.AlwaysOn
                }
            }

            Component {
                id: availableDelegateId

                Rectangle {
                    width: parent.width
                    height: 35
                    color: root.backgroundColor

                    topRightRadius: index === 0 ? root.radius : 0 // if index == 0 {radius = root.radius} else {radius = 0}
                    bottomLeftRadius: index === (listAvailableKernelsId.count - 1) ? root.radius : 0
                    bottomRightRadius: bottomLeftRadius

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: root.listFontSize
                        color: root.textColor
                        text: modelData
                    }
                }
            }
        }

        Item {
            id: itemButtonsId

            anchors {
                bottom: container.bottom
                left: parent.left
                right: parent.right
            }

            height: 60

            // Rectangle {
            //     anchors.fill: parent

            //     color: "teal"
            // }

            Button {
                id: btnUse

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 25
                }

                text: "Use"
                enabled: false
            }

            Button {
                id: btnInstall

                anchors {
                    centerIn: parent
                }

                text: "Install"
                enabled: false
            }

            Button {
                id: btnUninstall

                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 25
                }

                text: "Uninstall"
                enabled: false
            }
        }
    }
}
