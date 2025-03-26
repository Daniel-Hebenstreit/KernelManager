import QtQuick
import QtQuick.Controls

//property int listHeight: 8
//property string labelText
//property string dataModel

Item {
    id: kernelList

    width: parent.width

    Label {
        id: listLabel

        anchors {
            top: parent.top
            left: parent.left
        }

        text: labelText
        font.bold: root.labelFontBold
        font.pixelSize: root.labelFontSize
        color: root.textColor
        padding: 5
    }


    // list background
    Rectangle {
        id: listBackground

        anchors {
            top: listLabel.bottom
            bottom: parent.bottom // bottom of container
            left: parent.left
            right: parent.right
        }

        color: root.backgroundColorLists
    }


    // list elements
    ListView {
        id: listElements

        anchors {
            fill: listBackground
            margins: 5
        }
        spacing: root.elementSpacing

        clip: true

        model: dataModel
        delegate: delegateId

        ScrollBar.vertical: ScrollBar {}
    }

    Component {
        id: delegateId // single element of a list

        Rectangle {
            width: parent.width
            height: root.elementHeight
            color: (root.selectedList === list && root.currentIndex === index) ? root.highlightColor : (mouseArea.containsMouse ? root.highlightColor : root.elementColor)
            radius: root.elementRadius

            Text {
                anchors.centerIn: parentChanged
                font.pixelSize: root.listFontSize
                color: root.textColor
                text: modelData

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        root.selectedList = list
                        root.currentIndex = index

                        manager.selectedKernel = modelData
                        // log: setSelectedKernel: qDebug()
                    }
                }
            }

        }
    }
}
