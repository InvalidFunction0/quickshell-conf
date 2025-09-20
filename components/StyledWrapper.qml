import QtQuick
import Quickshell.Widgets
import qs.config

WrapperRectangle {
  id: root

  property string bg: Colors.catCrust
  property string fg: Colors.catLavender

  color: root.bg
  radius: parent.height

  contentInsideBorder: false

  anchors.top: parent.top
  anchors.bottom: parent.bottom

  rightMargin: Config.textPadding
  leftMargin:  Config.textPadding

  height: parent.height

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

