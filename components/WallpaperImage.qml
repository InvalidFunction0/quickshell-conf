import QtQuick

Image {
    source: "file:///home/ayaan/wallpaper/shaded_landscape.jpg"
    fillMode: Image.PreserveAspectCrop
    asynchronous: true
    retainWhileLoading: true
    anchors.fill: parent
}
