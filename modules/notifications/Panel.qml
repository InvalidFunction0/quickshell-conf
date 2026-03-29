pragma ComponentBehavior: Bound

// import qs.modules.notifications
import qs.config
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id: root

    property int cornerHeight: Appearance.rounding.normal
    property int cornerWidth: cornerHeight

    implicitWidth: 480
    color: "transparent"
    // Ignore exclusions, like the bar
    // So that the image doesn't get pushed down by the bar
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    mask: maskRegion
    HyprlandWindow.visibleMask: maskRegion
    contentItem.layer.enabled: true

    // Fill the screen for the mask
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    ScriptModel {
        id: notifModel
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
            anchors.rightMargin: Appearance.padding.normal
            anchors.bottomMargin: Appearance.padding.normal

            Shape {
                id: maskTopRightCorner
                preferredRendererType: Shape.CurveRenderer
                asynchronous: true
                Layout.preferredWidth: root.cornerWidth
                Layout.preferredHeight: root.cornerHeight
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom

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
                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom

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
                    Layout.preferredWidth: Config.notifs.sizes.width + (2 * Config.notifs.sizes.maskPadding)
                    Layout.preferredHeight: Config.notifs.sizes.height + (2 * Config.notifs.sizes.maskPadding)
                    topLeftRadius: cornerHeight
                }
            }
        }
    }

    ColumnLayout {

        spacing: 0
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: Appearance.padding.normal + Config.notifs.sizes.maskPadding
        anchors.bottomMargin: Appearance.padding.normal + Config.notifs.sizes.maskPadding

        Rectangle {
            id: thing

            color: Appearance.colors.mauve
            opacity: 1
            clip: true

            radius: root.cornerHeight - 4

            implicitWidth: Config.notifs.sizes.width
            implicitHeight: Config.notifs.sizes.height

            layer.enabled: true
            layer.effect: MultiEffect {
                // anchors.fill: thing
                source: thing
                blurEnabled: true
                blur: 0.4
                blurMax: 12
                opacity: 0.5
            }
        }
    }

    contentItem.layer.effect: MultiEffect {
        maskEnabled: true
        maskSource: mask
        maskSpreadAtMin: 1
        maskThresholdMin: 0.5
    }
}
