import Quickshell
import Quickshell.Widgets
import QtQuick

Variants {
  model: Quickshell.screens;

  PanelWindow {
    // the screen from screen list injected into property
    required property var modelData
    property int margin: 10

    // set the window's screen tot he injected property
    screen: modelData

    color: "transparent"

    implicitHeight: 35

    anchors {
      top: true
      left: true
      right: true
    }

    margins {
      top: margin
      right: margin
      left: margin
    }

    ClockWidget {}
  }
}
