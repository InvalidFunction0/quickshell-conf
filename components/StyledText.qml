import qs.config
import QtQuick

Text {
  renderType: Text.NativeRendering
  // textFormat: Text.PlainText

  font.family: "CaskaydiaCove NF"
  font.weight: 700
  font.pointSize: 13

  anchors.centerIn: parent
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  color: Colors.catLavender

  Behavior on color {
    CAnim {}
  }
}
