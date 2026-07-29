pragma ComponentBehavior: Bound

import qs.config
import qs.components
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

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
        // property bool hasFullscreen: false

        property string activeSubmap: ""
        property string lastSubmap: ""
        readonly property string displaySubmap: activeSubmap !== "" ? activeSubmap : lastSubmap
        readonly property bool submapVisible: activeSubmap !== ""

        Connections {
            target: Hyprland
            function onRawEvent(e) {
                if (e.name === "submap") {
                    root.activeSubmap = e.data;
                }
            }
        }

        onActiveSubmapChanged: {
            if (activeSubmap !== "") {
                lastSubmap = activeSubmap;
            }
        }

        readonly property int pad: Config.notifs.sizes.maskPadding + (root.hasFullscreen ? 0 : Appearance.padding.normal)
        property int slideMargin: submapVisible ? pad : -(submapText.implicitWidth + 40)

        Behavior on slideMargin {
            Anim {
                duration: Appearance.anim.durations.large
            }
        }

        // Fill the screen for the mask
        anchors {
            top: true
            bottom: true
            left: true
            right: true
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
                anchors.left: parent.left
                // move whole thing right on last notif
                // anchors.rightMargin: notifList.count > 0 ? Appearance.padding.normal : -Config.notifs.sizes.width - 100
                // anchors.leftMargin: root.hasFullscreen ? 0 : Appearance.padding.normal
                anchors.leftMargin: root.slideMargin - Config.notifs.sizes.maskPadding
                anchors.bottomMargin: root.hasFullscreen ? 0 : Appearance.padding.normal

                Behavior on anchors.bottomMargin {
                    Anim {}
                }

                // opacity: submapText.width > 0 ? 1 : 0

                Behavior on opacity {
                    Anim {}
                }

                readonly property int wantedHeight: 20

                Shape {
                    id: maskTopLeftCorner
                    preferredRendererType: Shape.CurveRenderer
                    asynchronous: true
                    Layout.preferredWidth: root.cornerWidth
                    Layout.preferredHeight: root.cornerHeight
                    Layout.alignment: Qt.AlignBottom | Qt.AlignLeft

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
                        angle: 2 * 90
                    }
                }

                RowLayout {
                    id: rightColumn

                    spacing: 0
                    Layout.alignment: Qt.AlignBottom | Qt.AlignLeft

                    // Main body
                    Rectangle {
                        id: maskBody
                        // implicitWidth: (root.activeSubmap === "" ? 0 : submapText.width) + 2 * Config.notifs.sizes.maskPadding
                        implicitWidth: (root.displaySubmap === "" ? 0 : submapText.width) + 2 * Config.notifs.sizes.maskPadding
                        implicitHeight: submapText.height + 2 * Config.notifs.sizes.maskPadding
                        topRightRadius: root.cornerHeight

                        Layout.alignment: Qt.AlignBottom | Qt.AlignLeft

                        Behavior on implicitHeight {
                            Anim {}
                        }

                        Behavior on implicitWidth {
                            Anim {
                                duration: Appearance.anim.durations.large
                            }
                        }
                    }

                    // Bottom right corner
                    Shape {
                        id: maskBottomLeftCorner
                        preferredRendererType: Shape.CurveRenderer
                        asynchronous: true
                        Layout.preferredWidth: root.cornerWidth
                        Layout.preferredHeight: root.cornerHeight
                        Layout.alignment: Qt.AlignBottom | Qt.AlignLeft

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
                            angle: 2 * 90
                        }
                    }
                }
            }
        }

        Rectangle {
            id: submapText

            // property int pad: Appearance.padding.normal + (root.hasFullscreen ? 0 : Config.notifs.sizes.maskPadding)
            // property int pad: Config.notifs.sizes.maskPadding + (root.hasFullscreen ? 0 : Appearance.padding.normal)

            anchors.bottom: parent.bottom
            anchors.left: parent.left

            // anchors.leftMargin: (root.activeSubmap === "" ? -100 : pad)
            anchors.leftMargin: root.slideMargin
            anchors.bottomMargin: root.pad

            radius: root.cornerHeight - Appearance.padding.normal

            color: Appearance.colors.base
            border.width: 1
            border.color: Appearance.colors.blue

            // Behavior on anchors.leftMargin {
            //     Anim {
            //         duration: Appearance.anim.durations.large
            //     }
            // }

            implicitWidth: submapName.width > 0 ? submapName.width + 2 * Appearance.padding.normal : 0
            implicitHeight: submapName.height + 2 * Appearance.padding.normal

            StyledText {
                id: submapName
                text: root.displaySubmap
                anchors.centerIn: parent
            }
        }

        contentItem.layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: mask
            maskSpreadAtMin: 1
            maskThresholdMin: 0.5
        }
    }
}
