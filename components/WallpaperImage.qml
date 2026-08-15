import QtQuick
import Quickshell.Io

Image {
    fillMode: Image.PreserveAspectCrop
    asynchronous: true
    retainWhileLoading: true
    anchors.fill: parent

    source: wallpaperState.text().trim() ? "file://" + wallpaperState.text().trim() : ""

    FileView {
        id: wallpaperState
        path: "/home/ayaan/wallpaper/.wallpaperstate"
        watchChanges: true
        onFileChanged: reload()
    }
}
