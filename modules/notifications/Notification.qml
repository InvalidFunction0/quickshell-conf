pragma ComponentBehavior: Bound

import qs.components
import qs.config
import qs.services
import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property Notifs.Notif modelData

    implicitWidth: Config.notifs.sizes.width
    implicitHeight: 75
    radius: Appearance.rounding.normal

    color: Appearance.colors.crust

    x: Config.notifs.sizes.width

    Component.onCompleted: x = 0

    Behavior on x {
        Anim {
            easing.bezierCurve: [0.05, 0.7, 0.1, 1, 1, 1]
        }
    }

    Column {
        StyledText {
            color: Appearance.colors.blue
            text: root.modelData.summary
            height: implicitHeight
        }
        StyledText {
            color: Appearance.colors.lavender
            text: root.modelData.body
        }
    }
}
