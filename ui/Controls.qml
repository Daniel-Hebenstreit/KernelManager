import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: controls

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColorControls
    }

    RowLayout {
        width: parent.width

        anchors.verticalCenter: parent.verticalCenter

        Item {
            implicitWidth: 9
        }

        Button {
            id: btnUse

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            text: "Use"
            // active "uninstall" button === installed kernel === available for use
            enabled: root.globalUninstallBtn === true ? true : false
        }

        // Item {
        //     Layout.fillWidth: true
        // }

        Button {
            id: btnInstall

            Layout.fillWidth: true

            text: "Install"
            enabled: root.globalInstallBtn === true ? true : false

            onClicked: {
                manager.installKernel(manager.selectedKernel)
                //manager.installKernel
            }
        }

        // Item {
        //     Layout.fillWidth: true
        // }

        Button {
            id: btnUninstall

            Layout.fillWidth: true

            text: "Uninstall"
            enabled: root.globalUninstallBtn === true ? true : false

            onClicked: {
                manager.uninstallKernel(manager.selectedKernel)
            }
        }

        // Item {
        //     Layout.fillWidth: true
        // }

        ComboBox {
            id: comboBox

            Layout.fillWidth: true

            textRole: "version"

            model: ListModel {
                id: modelId

                ListElement {
                    version: "Latest Arch Kernels"
                }

                ListElement {
                    version: "Arch Linux Archive"
                }

                ListElement {
                    version: "Supported Manjaro Kernels"
                }
            }
        }

        Item {
            implicitWidth: 9
        }
    }
}
