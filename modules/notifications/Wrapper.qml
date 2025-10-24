import qs.services
import qs.components
import Quickshell
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
        margins {
            top: 10
            right: 10
        }

        color: "transparent"

        implicitHeight: root.implicitHeight
        implicitWidth: root.implicitWidth

        Item {
            id: root

            visible: height > 0

            implicitWidth: 350
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
