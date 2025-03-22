import QtQuick
import QtQuick.Controls

Item {
    id: availableKernels

    height: labelAvailableKernels.height + listAvailableKernels.height + 15
    width: parent.width

    Label {
        id: labelAvailableKernels

        anchors {
            top: parent.top
            left: parent.left
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

    Rectangle {
        id: rectAvailableKernels

        anchors {
            top: labelAvailableKernels.bottom
            left: parent.left
            right: parent.right
        }

        height: Math.max(Math.min(listAvailableKernels.count * root.elementHeight, root.height/3), 35)
        color: root.backgroundColor
    }

    ListView {
        id: listAvailableKernels

        anchors.fill: rectAvailableKernels
        anchors.margins: 5

        clip: true

        model: manager.listArchKernels()
        delegate: availableDelegate

        ScrollBar.vertical: ScrollBar { }
    }

    Component {
        id: availableDelegate

        Item {
            width: parent.width
            height: root.elementHeight + root.elementSpacing

            Rectangle {
                id: element
                width: parent.width
                height: root.elementHeight
                color: (root.selectedList === "availableKernels" && root.currentIndex === index) ? root.highlightColor : (mouseArea.containsMouse ? root.highlightColor : root.elementColor)
                radius: root.radius

                Text {
                    anchors.centerIn: parent
                    font.pixelSize: root.listFontSize
                    color: root.textColor
                    text: modelData
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        root.selectedList = "availableKernels"
                        root.currentIndex = index
                    }
                }
            }
        }
    }
}
