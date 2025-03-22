import QtQuick
//import QtQuick.Controls
import "ui"

//import KernelManager

Window {
    id: root

    width: 640
    height: 510
    visible: true
    title: qsTr("Linux Kernel Manager")

    color: "#686664"
    property string textColor: "white"
    property string backgroundColor: "#595854"
    property string backgroundColorControls: "#2e2d2c"
    property bool labelFontBold: true
    property int labelFontSize: 17
    property int listFontSize: 16
    property int radius: 5

    property int elementHeight: 25
    property int elementSpacing: 4
    property string elementColor: "#3f615e"
    property string highlightColor: "teal"

    property string selectedList: ""
    property int currentIndex: -1


    KernelManager {
        id: manager
    }

    Item {
        id: listsContainer

        anchors {
            top: parent.top
            bottom: controlsContainer.top
            left: parent.left
            right: parent.right
            margins: 10
        }

        Column {
            id: lists

            width: parent.width - 18
            height: parent.height - 35
            spacing: 15

            CurrentKernel {
                id: currentKernel
            }

            InstalledKernels {
                id: installedKernels
            }

            AvailableKernels {
                id: availableKernels
            }
        }
    }


    Item {
        id: controlsContainer

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 60

        Controls {
            id: controls
        }
    }
}
