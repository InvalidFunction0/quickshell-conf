import QtQuick
import Quickshell.Widgets

WrapperRectangle {
  id: clockWrapper

  property real pillMargin: (parent.height - clockText.font.pixelSize) / 2

  // color: Colors.catCrust
  color: Colors.catCrust
  radius: parent.height

  contentInsideBorder: false

  anchors.top: parent.top
  anchors.bottom: parent.bottom

  leftMargin:  pillMargin + 5
  rightMargin: pillMargin + 5

  border {
    color: Colors.catLavender
    width: 3
  }

  Text {
    id: clockText

    font.family: "CaskaydiaCoveNerdFont"
    font.weight: 700
    font.pixelSize: 15
    color: Colors.catLavender

    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    width: parent.width

    text: Time.time
  }
}

