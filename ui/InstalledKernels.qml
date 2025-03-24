import QtQuick
import QtQuick.Controls

Item {
    id: installedKernels

    height: labelInstalledKernels.height + listInstalledKernels.height + 15
    width: parent.width

    Label {
        id: labelInstalledKernels

        anchors {
            top: parent.top
            left: parent.left
        }

        text: "Installed Kernels"
        font.bold: root.labelFontBold
        font.pixelSize: root.labelFontSize
        color: root.textColor
        padding: 5

        background: Rectangle {
            color: root.backgroundColorLists
            implicitWidth: 150
            implicitHeight: 30
            topLeftRadius: root.labelRadius
            topRightRadius: root.labelRadius

        }
    }

    // Background of the list
    Rectangle {
        id: rectInstalledKernels

        anchors {
            top: labelInstalledKernels.bottom
            left: parent.left
            right: parent.right
        }

        height: Math.max(Math.min(listInstalledKernels.count * root.elementHeight, root.height/4), 35)
        color: root.backgroundColorLists
    }

    ListView {
        id: listInstalledKernels

        anchors.fill: rectInstalledKernels
        anchors.margins: 5

        clip: true

        model: manager.listInstalledKernels()
        delegate: installedDelegate

        ScrollBar.vertical: ScrollBar {}
    }

    Component {
        id: installedDelegate

        Item {
            width: parent.width
            height: root.elementHeight + root.elementSpacing

            Rectangle {
                anchors.top: parent.top

                width: parent.width
                height: root.elementHeight
                color: (root.selectedList === "installedKernels" && root.currentIndex === index) ? root.highlightColor : (mouseArea.containsMouse ? root.highlightColor : root.elementColor)
                radius: root.elementRadius

                Text {
                    anchors.centerIn: parent
                    font.pixelSize: root.listFontSize
                    color: root.textColor
                    text: modelData //
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        root.selectedList = "installedKernels"
                        root.currentIndex = index

                        manager.selectedKernel = modelData
                        // log: setSelectedKernel: qDebug()
                    }
                }
            }
        }
    }
}
