pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls
import qs.components
import qs.config
import "."
import "scripts/fzf.js" as Fzf

Variants {
    model: Quickshell.screens

    // qmllint disable uncreatable-type
    PanelWindow {
        // qmllint enable uncreatable-type

        id: root

        property var modelData
        screen: modelData

        property int cornerHeight: Appearance.rounding.large
        property int cornerWidth: cornerHeight

        // Ignore exclusions, like the bar
        // So that the image doesn't get pushed down by the bar
        exclusionMode: ExclusionMode.Ignore
        aboveWindows: true
        mask: maskRegion
        HyprlandWindow.visibleMask: maskRegion
        contentItem.layer.enabled: true
        // To show over fullscreen windows
        WlrLayershell.layer: WlrLayer.Overlay

        visible: false
        focusable: true

        property int selectedIndex: 0

        HyprlandFocusGrab {
            id: grab
            active: root.visible
            windows: [root]

            onCleared: {
                if (root.visible) {
                    console.log("launcher lost focus, starting timer");
                    closeTimer.restart();
                }
            }
        }

        Timer {
            id: closeTimer
            interval: 1 * 1000
            repeat: false
            running: false

            onTriggered: {
                root.hide();
            }
        }

        onVisibleChanged: {
            if (visible) {
                closeTimer.stop();
                grab.active = true;
            }
        }

        color: "transparent"

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        function show() {
            // field.text = "";
            field.clear();
            selectedIndex = 0;
            visible = true;
            field.forceActiveFocus();
        }

        function hide() {
            visible = false;
        }

        IpcHandler {
            target: "launcher"

            function toggle() {
                root.visible ? root.hide() : root.show();
            }
        }

        onSelectedIndexChanged: {
            appList.positionViewAtIndex(selectedIndex, ListView.Contain);
        }

        WallpaperImage {}

        Region {
            id: maskRegion
            item: maskLayout
        }

        contentItem.layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: mask
            maskSpreadAtMin: 1
            maskThresholdMin: 0.5
        }

        Item {
            id: mask
            visible: false
            layer.enabled: true
            anchors.fill: parent

            ColumnLayout {
                id: maskLayout

                spacing: 0
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: Appearance.padding.normal
                anchors.leftMargin: Appearance.padding.normal

                RowLayout {
                    spacing: 0
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                    Rectangle {
                        id: maskBody

                        implicitWidth: launcherBody.width + 2 * Config.notifs.sizes.maskPadding
                        implicitHeight: launcherBody.height + 2 * Config.notifs.sizes.maskPadding

                        bottomRightRadius: root.cornerHeight
                    }

                    Shape {
                        // top right corner
                        preferredRendererType: Shape.CurveRenderer
                        asynchronous: true
                        Layout.preferredWidth: root.cornerWidth
                        Layout.preferredHeight: root.cornerHeight
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft

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
                            angle: -90
                        }
                    }
                }

                Shape {
                    // bottom left corner
                    preferredRendererType: Shape.CurveRenderer
                    asynchronous: true
                    Layout.preferredWidth: root.cornerWidth
                    Layout.preferredHeight: root.cornerHeight
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft

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
                        angle: -90
                    }
                }
            }
        }

        Item {
            id: launcherBody

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: Appearance.padding.normal + Config.notifs.sizes.maskPadding
            anchors.leftMargin: Appearance.padding.normal + Config.notifs.sizes.maskPadding

            implicitHeight: childrenRect.height
            implicitWidth: childrenRect.width

            ClippingWrapperRectangle {
                margin: Appearance.padding.larger
                color: Qt.alpha(Appearance.colors.crust, 0.5)
                border.width: 1
                border.color: Appearance.colors.blue

                radius: root.cornerWidth - Config.notifs.sizes.maskPadding

                ColumnLayout {
                    spacing: 10

                    TextField {
                        id: field
                        // focus: true

                        background: WrapperRectangle {
                            id: bg
                            anchors.fill: parent
                            color: Appearance.colors.red
                            margin: 10
                        }

                        implicitWidth: 500

                        onAccepted: {
                            let selected = filteredApps.values[root.selectedIndex];
                            console.log(selected);
                            root.hide();

                            DesktopEntries.applications.values.filter(e => e.name === selected)[0].execute();
                        }

                        Keys.onEscapePressed: {
                            root.hide();
                        }

                        Keys.onDownPressed: {
                            root.selectedIndex = Math.min(root.selectedIndex + 1, filteredApps.values.length - 1);
                        }

                        Keys.onUpPressed: {
                            root.selectedIndex = Math.max(root.selectedIndex - 1, 0);
                        }

                        onTextChanged: {
                            root.selectedIndex = 0;
                            appList.positionViewAtIndex(0, ListView.Beginning);
                        }
                    }

                    ListView {
                        id: appList

                        model: ScriptModel {
                            id: filteredApps

                            values: {
                                const list = [...DesktopEntries.applications.values].map(e => e.name);
                                const fzf = new Fzf.Finder(list);

                                if (field.text !== "") {
                                    const entries = fzf.find(field.text).sort((a, b) => {
                                        if (a.score === b.score)
                                            return a.item.trim().length - b.item.trim().length;
                                        return b.score - a.score;
                                    });
                                    return (entries.length > 0 ? entries.map(e => e.item) : ["no items found"]);
                                } else {
                                    return list.sort((a, b) => a.localeCompare(b));
                                }
                            }
                        }

                        clip: true
                        spacing: 5

                        Layout.preferredWidth: parent.width
                        // 11 items for a reason I can't work out
                        Layout.preferredHeight: Math.min(contentHeight, (12 * exampleHeight.height + 10 + 5))

                        Behavior on Layout.preferredHeight {
                            Anim {}
                        }

                        add: Transition {
                            enabled: true

                            Anim {
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: Appearance.anim.durations.large
                            }
                        }

                        remove: Transition {
                            enabled: true

                            Anim {
                                property: "opacity"
                                from: 1
                                to: 0
                                duration: Appearance.anim.durations.large
                            }
                        }

                        delegate: WrapperRectangle {
                            id: delegateRoot

                            required property var modelData
                            required property int index

                            color: root.selectedIndex === index ? Appearance.colors.base : Appearance.colors.mantle

                            Behavior on color {
                                CAnim {}
                            }

                            radius: root.cornerHeight - Config.notifs.sizes.maskPadding - Appearance.padding.normal
                            margin: 10

                            width: appList.width
                            // height: 20

                            Text {
                                color: Appearance.colors.text
                                text: delegateRoot.modelData
                            }
                        }
                    }
                }
                //
                // MultiEffect {
                //     source: mask
                //     // anchors.fill: launcherBody
                //     blurEnabled: true
                //     blurMax: 64
                // }
            }
        }

        WrapperRectangle {
            id: exampleHeight
            visible: false
            radius: root.cornerHeight - Config.notifs.sizes.maskPadding - Appearance.padding.normal
            margin: 10
            width: appList.width
            Text {
                text: "example text"
            }
        }
    }
}
