pragma ComponentBehavior: Bound

import qs.services
import qs.components
import Quickshell
import QtQuick

Rectangle {
    id: root

    required property Notifs.Notif modelData

    implicitWidth: 300
    implicitHeight: 75

    color: "red"
    radius: 10

    Component.onCompleted: x = 0

    Behavior on x {
        Anim {}
    }

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10

        implicitHeight: 75

        StyledText {
            text: root.modelData.summary
        }
    }
}
