import qs.config
import QtQuick

Text {
    property bool centerText: false

    // idk man don't ask me
    renderType: Text.NativeRendering
    textFormat: Text.PlainText

    font.family: Appearance.fonts.family.base
    font.weight: 700
    font.pointSize: Appearance.fonts.size.normal

    // why do I need to do this to center when I centered it
    horizontalAlignment: centerText ? Text.AlignHCenter : Text.AlignLeft
    verticalAlignment: centerText ? Text.AlignVCenter : Text.AlignTop

    color: Appearance.colors.lavender

    Behavior on color {
        CAnim {}
    }
}
