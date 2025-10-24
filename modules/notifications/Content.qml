import qs.services
import qs.config
import qs.components
import Quickshell
import Quickshell.Widgets
import QtQuick

Item {
    id: root

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    implicitWidth: 350
    implicitHeight: {
        const count = Notifs.popups.length;
        if (count === 0) {
            return 0;
        }

        return 100;
    }

    ClippingWrapperRectangle {
        anchors.fill: parent
        color: Colors.ctpCrust
        radius: 10

        ListView {
            model: ScriptModel {
                values: Notifs.popups.filter(n => n.popup) // the filter is just to please Qt
            }

            anchors.fill: parent

            orientation: Qt.Vertical
            spacing: 0
            cacheBuffer: QsWindow.window?.screen.height ?? 0

            delegate: Item {
                id: wrapper

                required property Notifs.Notif modelData

                ListView.onRemove: removeAnim.start()

                SequentialAnimation {
                    id: removeAnim

                    PropertyAction {
                        target: wrapper
                        property: "ListView.delayRemove"
                        value: true
                    }
                    PropertyAction {
                        target: wrapper
                        property: "enabled"
                        value: false
                    }
                    PropertyAction {
                        target: wrapper
                        property: "implicitHeight"
                        value: 0
                    }
                    PropertyAction {
                        target: wrapper
                        property: "z"
                        value: 1
                    }
                    Anim {
                        target: notif
                        property: "x"
                        to: (notif.x >= 0 ? 300 : -300) * 2
                        duration: 300
                    }
                    PropertyAction {
                        target: wrapper
                        property: "ListView.delayRemove"
                        value: false
                    }
                }

                ClippingRectangle {
                    color: "transparent"
                    implicitHeight: notif.implicitHeight
                    implicitWidth: notif.implicitWidth

                    Notification {
                        id: notif
                        modelData: wrapper.modelData
                    }
                }
            }

            move: Transition {
                Anim {
                    property: "y"
                }
            }

            displaced: Transition {
                Anim {
                    property: "y"
                }
            }
        }
    }

    Behavior on implicitHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: 300
        easing.type: Easing.BezierSpline
        easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
    }
}
