import qs.config
import qs.services
import Quickshell
import Quickshell.Widgets
import QtQuick

Item {
    id: root

    implicitWidth: Config.notifs.sizes.width + Appearance.padding.small * 2
    implicitHeight: {
        const count = Notifs.popups.length;

        if (count === 0)
            return 0;

        let height = (count - 1) * list.margin;
        height += 2 * list.margin;

        height += count * 75;

        height;
    }

    anchors {
        top: parent.top
        right: parent.right
        bottom: parent.bottom
    }

    ClippingWrapperRectangle {
        color: Appearance.colors.mantle
        anchors.fill: parent
        radius: Appearance.rounding.small

        ListView {
            id: list

            readonly property int margin: Appearance.padding.small

            model: ScriptModel {
                values: Notifs.popups.filter(n => n.popup)
            }

            orientation: ListView.Vertical

            anchors.fill: parent
            anchors.margins: margin

            spacing: margin

            delegate: Item {
                id: wrapper

                required property Notifs.Notif modelData

                implicitHeight: content.height

                anchors.left: parent.left
                anchors.right: parent.right

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
                        to: (notif.x >= 0 ? Config.notifs.sizes.width : -Config.notifs.sizes.width) * 2
                        duration: Appearance.anim.durations.normal
                        easing.bezierCurve: Appearance.anim.curves.emphasized
                    }
                    PropertyAction {
                        target: wrapper
                        property: "ListView.delayRemove"
                        value: false
                    }
                }

                ClippingRectangle {
                    anchors.top: parent.top

                    color: "transparent"
                    radius: notif.radius
                    implicitHeight: notif.implicitHeight
                    implicitWidth: notif.implicitWidth

                    Notification {
                        id: notif

                        modelData: wrapper.modelData
                    }
                }
            }
        }
    }

    Behavior on implicitHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.expressiveDefaultSpatial
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
    }
}
