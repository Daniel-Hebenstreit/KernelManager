import QtQuick
import QtQuick.Controls

Item {
    id: currentKernel

    height: labelUsedKernel.height + listUsedKernel.height + 10
    width: parent.width

    Label {
        id: labelUsedKernel

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
            color: root.backgroundColorLists
            implicitWidth: 150
            implicitHeight: 30
            topLeftRadius: root.labelRadius
            topRightRadius: root.labelRadius

        }
    }

    // Background of the List
    Rectangle {
        id: rectUsedKernel

        anchors {
            top: labelUsedKernel.bottom
            left: parent.left
            right: parent.right
        }

        height: root.elementHeight + (2 * root.elementSpacing)
        color: root.backgroundColorLists
    }

    Rectangle {
        id: listUsedKernel

        anchors.fill: rectUsedKernel
        anchors.margins: 5

        width: parent.width
        height: root.elementHeight
        radius: root.elementRadius
        color: root.selectedList === "currentKernel" ? root.highlightColor : (mouseArea.containsMouse ? root.highlightColor : root.elementColor)

        Text {
            anchors.centerIn: parent
            text: manager.currentKernel()
            color: root.textColor
            font.pixelSize: root.listFontSize
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                root.selectedList = "currentKernel"
                root.currentIndex = -1
            }
        }
    }

}
