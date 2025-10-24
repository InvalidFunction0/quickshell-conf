pragma ComponentBehavior: Bound

import qs.config
import qs.services
import qs.components
import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData

        screen: modelData

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

        color: "transparent"

        mask: Region {
            x: 0
            y: Config.bar.sizes.innerHeight
        }

        anchors {
            top: true
            // bottom: true
            left: true
            right: true
        }

        Item {
            id: root

            visible: height > 0

            implicitWidth: Config.notifs.sizes.width
            implicitHeight: content.implicitHeight

            states: State {
                name: "hidden"
                when: Notifs.popups === []

                PropertyChanges {
                    root.implicitHeight: 0
                }
            }

            transitions: Transition {
                Anim {
                    target: root
                    property: "implicitHeight"
                    duration: 300
                    easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
                }
            }

            Content {
                id: content
            }
        }
    }
}
