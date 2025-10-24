import "components"
import qs.config
import Quickshell
import Quickshell.Widgets
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData

        color: "transparent"

        implicitHeight: Config.bar.sizes.innerHeight

        anchors {
            top: true
            left: true
            right: true
        }

        // make sure the bar can't be infected by the bezels of my monitor
        margins {
            top: Appearance.padding.normal
            right: Appearance.padding.normal
            left: Appearance.padding.normal
        }

        // these rows are to make sure the elements are horizontal
        Row {
            id: left

            height: parent.height
            spacing: Appearance.spacing.small
            anchors.left: parent.left

            ActiveWindow {}
        }

        Row {
            id: center

            anchors.horizontalCenter: parent.horizontalCenter

            height: parent.height
        }

        Row {
            id: right

            layoutDirection: Qt.RightToLeft
            height: parent.height
            spacing: Appearance.spacing.small
            anchors.right: parent.right

            Power {}
            Clock {}
        }
    }
}
