import qs.config
import QtQuick

Text {
  // idk man don't ask me
  renderType: Text.NativeRendering
  // textFormat: Text.PlainText

  font.family: "CaskaydiaCove NF"
  // boldness is good. be bold. tell your boss he's mean.
  // you know you want to.
  // ( I take no responsibility for consequences )
  font.weight: 700
  font.pointSize: 13

  anchors.centerIn: parent
  // why do I need to do this to center when I centered it
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  color: Colors.catLavender

  Behavior on color {
    CAnim {}
  }
}
