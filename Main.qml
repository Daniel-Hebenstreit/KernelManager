import QtQuick
import "ui"

Window {
    id: root

    width: 640
    height: 510
    visible: true
    color: windowColor
    title: qsTr("Linux Kernel Manager")

    // background upper window color
    property string windowColor: "#2e2d2c"

    // background lower window color
    property string backgroundColorControls: "#1f1e1d"

    // customize list background
    property string backgroundColorLists: "#2e2d2c"//"#4c4b47"
    property bool labelFontBold: true
    property int labelFontSize: 17
    property int listFontSize: 16
    property int labelRadius: 5

    // customize list elements
    property string elementColor: "#3f615e"
    property string highlightColor: "teal"
    property int elementRadius: 0
    property int elementHeight: 25
    property int elementSpacing: 2

    // label and list elements
    property string textColor: "white"

    // needed to select elements across different lists
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

            width: parent.width
            height: parent.height
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
