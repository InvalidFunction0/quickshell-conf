import QtQuick
import Quickshell.Widgets
import qs.config

WrapperRectangle {
  id: root

  required property string bgCol
  required property string fgCol
  required property string text

  property real pillMargin: (Config.barHeight - text.font.pixelSize) / 2

  color: root.bgCol
  radius: parent.height

  contentInsideBorder: false

  anchors.top: parent.top
  anchors.bottom: parent.bottom

  leftMargin:  pillMargin + 5
  rightMargin: pillMargin + 5

  border {
    color: root.fgCol
    width: 3
  }

  Text {
    id: text

    font.family: "CaskaydiaCoveNerdFont"
    font.weight: 700
    font.pixelSize: 15
    color: root.fgCol

    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    width: parent.width

    text: root.text
  }
}

