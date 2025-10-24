import QtQuick
import Quickshell.Widgets
import qs.config

WrapperRectangle {
    id: root

    property string bg: Appearance.colors.crust
    property string fg: Appearance.colors.lavender

    color: root.bg
    radius: Appearance.rounding.full

    // force everything to be squished
    contentInsideBorder: false

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    rightMargin: Appearance.padding.larger
    leftMargin: Appearance.padding.larger

    implicitHeight: parent.implicitHeight

    border {
        color: root.fg
        width: 3
    }

    Behavior on color {
        CAnim {}
    }

    Behavior on border.color {
        CAnim {}
    }
}
