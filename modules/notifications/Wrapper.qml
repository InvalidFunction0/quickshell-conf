pragma ComponentBehavior: Bound

import qs.config
import Quickshell
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: win

        required property ShellScreen modelData

        screen: modelData

        color: "transparent"

        anchors {
            top: true
            right: true
        }

        margins {
            top: Appearance.padding.normal
            right: Appearance.padding.normal
        }

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        Content {
            id: content
        }
    }
}
