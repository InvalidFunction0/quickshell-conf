import Quickshell
import Quickshell.Io
import qs.config
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            aboveWindows: false
            color: "transparent"

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            // Image {
            //     source: "file:///home/ayaan/wallpaper/shaded_landscape.jpg"
            //     fillMode: Image.PreserveAspectCrop
            //     asynchronous: true
            //     retainWhileLoading: true
            //     anchors.fill: parent
            // }

            Text {
                id: timetxt
                font.pointSize: 100
                font.bold: true

                x: parent.width - width - 35
                y: parent.height - height - 35

                color: Appearance.colors.blue
                opacity: 0.5

                Process {
                    id: dateProc
                    command: ["date", "+%H:%M"]
                    running: true
                    stdout: SplitParser {
                        onRead: data => timetxt.text = data
                    }
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: dateProc.running = true
                }
            }
        }
    }
}
