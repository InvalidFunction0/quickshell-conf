import QtQuick
import Quickshell.Widgets
import qs.config

WrapperRectangle {
  id: root

  // I occasionally misread the two colours as "catLust"
  property string bg: Colors.catCrust
  property string fg: Colors.catLavender

  color: root.bg
  radius: parent.height

  // force everything to be squished
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

