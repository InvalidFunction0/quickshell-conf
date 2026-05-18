pragma ComponentBehavior: Bound

import "."
import qs.config
import qs.components
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Variants {
    model: Quickshell.screens

    // qmllint disable uncreatable-type
    PanelWindow {
        // qmllint enable uncreatable-type
        id: root

        property var modelData
        property int cornerHeight: Appearance.rounding.large
        property int cornerWidth: cornerHeight

        screen: modelData

        implicitWidth: 480
        color: "transparent"
        // Ignore exclusions, like the bar
        // So that the image doesn't get pushed down by the bar
        exclusionMode: ExclusionMode.Ignore
        aboveWindows: true
        mask: maskRegion
        HyprlandWindow.visibleMask: maskRegion
        contentItem.layer.enabled: true
        // To show over fullscreen windows
        WlrLayershell.layer: WlrLayer.Overlay

        property bool hasFullscreen: Hyprland.monitorFor(modelData).activeWorkspace.hasFullscreen
        // property bool hasFullscreen: true

        // Fill the screen for the mask
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        ScriptModel {
            id: notifModel
            values: Server.popups.filter(n => n.focusedMonitor === Hyprland.monitorFor(root.modelData))
            // values: Server.popups
        }

        Region {
            id: maskRegion
            item: layoutMask
        }

        // The image for the background mask
        // This should be the wallpaper
        Image {
            source: "file:///home/ayaan/wallpaper/shaded_landscape.jpg"
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            retainWhileLoading: true
            anchors.fill: parent
        }

        Item {
            id: mask

            visible: false
            layer.enabled: true
            anchors.fill: parent

            ColumnLayout {
                id: layoutMask

                spacing: 0
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                // move whole thing right on last notif
                // anchors.rightMargin: notifList.count > 0 ? Appearance.padding.normal : -Config.notifs.sizes.width - 100
                anchors.rightMargin: root.hasFullscreen ? 0 : Appearance.padding.normal
                anchors.bottomMargin: root.hasFullscreen ? 0 : Appearance.padding.normal

                Behavior on anchors.rightMargin {
                    Anim {}
                }

                Behavior on anchors.bottomMargin {
                    Anim {}
                }

                opacity: notifList.count > 0 ? 1 : 0

                Behavior on opacity {
                    Anim {}
                }

                readonly property int wantedHeight: 20

                Shape {
                    id: maskTopRightCorner
                    preferredRendererType: Shape.CurveRenderer
                    asynchronous: true
                    Layout.preferredWidth: root.cornerWidth
                    Layout.preferredHeight: root.cornerHeight
                    Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                    ShapePath {
                        startX: 0
                        startY: 0
                        strokeWidth: -1

                        PathArc {
                            x: root.cornerWidth
                            y: root.cornerHeight
                            radiusX: root.cornerWidth
                            radiusY: root.cornerHeight
                        }

                        PathLine {
                            x: root.cornerWidth
                            y: 0
                        }
                    }

                    transform: Rotation {
                        origin.x: root.cornerWidth / 2
                        origin.y: root.cornerHeight / 2
                        angle: 3 * -90
                    }
                }

                RowLayout {
                    id: rightColumn

                    spacing: 0
                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom

                    // Bottom left corner
                    Shape {
                        id: maskBottomLeftCorner
                        preferredRendererType: Shape.CurveRenderer
                        asynchronous: true
                        Layout.preferredWidth: root.cornerWidth
                        Layout.preferredHeight: root.cornerHeight
                        Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                        ShapePath {
                            startX: 0
                            startY: 0
                            strokeWidth: -1

                            PathArc {
                                x: root.cornerWidth
                                y: root.cornerHeight
                                radiusX: root.cornerWidth
                                radiusY: root.cornerHeight
                            }

                            PathLine {
                                x: root.cornerWidth
                                y: 0
                            }
                        }

                        transform: Rotation {
                            origin.x: root.cornerWidth / 2
                            origin.y: root.cornerHeight / 2
                            angle: 3 * -90
                        }
                    }

                    // Main body
                    Rectangle {
                        id: maskBody
                        implicitWidth: notifList.count > 0 ? Config.notifs.sizes.width + (2 * Config.notifs.sizes.maskPadding) : 0
                        // implicitHeight: {
                        //     let len = notifList.count > 0 ? Server.popups.length : 1;
                        //     let height = Config.notifs.sizes.height * len; // number of notifs
                        //     height += Appearance.padding.normal * (len - 1); // padding between
                        //     height += 2 * Config.notifs.sizes.maskPadding;
                        //     return height > 20 ? height : 0;
                        // }
                        implicitHeight: notifRoot.height
                        topLeftRadius: root.cornerHeight

                        Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                        Behavior on implicitHeight {
                            Anim {}
                        }

                        Behavior on implicitWidth {
                            Anim {
                                duration: Appearance.anim.durations.large
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: notifRoot

            // property int pad: Appearance.padding.normal + (root.hasFullscreen ? 0 : Config.notifs.sizes.maskPadding)
            property int pad: Config.notifs.sizes.maskPadding + (root.hasFullscreen ? 0 : Appearance.padding.normal)

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: pad
            anchors.bottomMargin: pad

            Behavior on anchors.rightMargin {
                Anim {}
            }

            Behavior on anchors.bottomMargin {
                Anim {}
            }

            implicitWidth: Config.notifs.sizes.width
            // implicitHeight: {
            //     let h = notifList.count * Config.notifs.sizes.height;
            //     h += (notifList.count - 1) * Appearance.padding.normal;
            //     return h;
            // }
            implicitHeight: {
                const count = notifList.count;
                if (count === 0)
                    return 0;

                let height = (count - 1) * Appearance.padding.normal;
                height += 2 * Config.notifs.sizes.maskPadding;

                for (let i = 0; i < count; i++)
                    height += (notifList.itemAtIndex(i) as NotifWrapper)?.nonAnimHeight ?? 0;
            }

            ListView {
                id: notifList
                model: notifModel

                anchors.bottom: parent.bottom
                anchors.right: parent.right
                implicitWidth: Config.notifs.sizes.width
                implicitHeight: contentHeight > 20 ? contentHeight : 0

                Behavior on implicitHeight {
                    Anim {}
                }

                spacing: Appearance.padding.normal
                orientation: Qt.Vertical
                verticalLayoutDirection: ListView.BottomToTop
                interactive: false

                displaced: Transition {
                    Anim {
                        property: "y"
                    }
                }

                move: Transition {
                    Anim {
                        property: "y"
                    }
                }

                // remove: Transition {
                //     Anim {
                //         property: "x"
                //         to: Config.notifs.sizes.width + 100
                //         duration: 1200
                //     }
                // }

                delegate: NotifWrapper {}
            }
        }

        contentItem.layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: mask
            maskSpreadAtMin: 1
            maskThresholdMin: 0.5
        }
    }

    component NotifWrapper: Item {
        id: wrapper

        required property NotifData modelData

        property int nonAnimHeight: notif.nonAnimHeight

        implicitWidth: notif.width
        implicitHeight: notif.height

        ListView.onAdd: addAnim.start()
        ListView.onRemove: removeAnim.start()

        SequentialAnimation {
            id: addAnim
            Anim {
                target: notif
                property: "x"
                from: Config.notifs.sizes.width + 200
                to: 0
                duration: Appearance.anim.durations.normal
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }

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
                to: Config.notifs.sizes.width + 200
                duration: Appearance.anim.durations.normal
                easing.bezierCurve: Appearance.anim.curves.standard
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
                cornerRadius: root.cornerHeight - 4
            }
        }
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.expressiveDefaultSpatial
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
    }
}
