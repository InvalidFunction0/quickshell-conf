pragma ComponentBehavior: Bound

import qs.components
import qs.config
import qs.services
import Quickshell
import QtQuick

Rectangle {
    id: root

    required property Notifs.Notif modelData

    implicitWidth: Config.notifs.sizes.width
    implicitHeight: 75

    color: "red"
    radius: Appearance.rounding.normal

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
