import QtQuick
import QtQuick.Controls

Item {
    id: controls

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColorControls
    }

    Button {
        id: btnUse

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 25
        }

        text: "Use"
        enabled: root.selectedList === "installedKernels" ? true : false
    }

    Button {
        id: btnInstall

        anchors {
            centerIn: parent
        }

        text: "Install"
        enabled: root.selectedList === "availableKernels" ? true : false
    }

    Button {
        id: btnUninstall

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 25
        }

        text: "Uninstall"
        enabled: root.selectedList == "installedKernels" ? true : false
    }
}
