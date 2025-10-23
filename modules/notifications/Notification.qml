import qs.services
import Quickshell
import Quickshell.Widgets
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData
        screen: modelData

        anchors {
            top: true
            right: true
        }
        color: "transparent"
        implicitHeight: 300

        Item {
            id: root

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            implicitWidth: 200
            implicitHeight: 1080

            ClippingWrapperRectangle {
                anchors.fill: parent
                color: "red"
            }
        }
    }
}
