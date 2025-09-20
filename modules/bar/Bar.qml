import "components"
import qs.config
import Quickshell
import Quickshell.Widgets
import QtQuick

Variants {
  model: Quickshell.screens;

  PanelWindow {
    // the screen from screen list injected into property
    required property var modelData

    // set the window's screen tot he injected property
    screen: modelData

    color: "transparent"

    implicitHeight: Config.barHeight

    anchors {
      top: true
      left: true
      right: true
    }

    margins {
      top: Config.barMargin
      right: Config.barMargin
      left: Config.barMargin
    }

    Row {
      id: left

      height: Config.barHeight
      spacing: Config.barMargin
      anchors.left: parent.left

      ActiveWindow {}
    }

    Row {
      id: center

      anchors.horizontalCenter: parent.horizontalCenter

      height: Config.barHeight
    }

    Row {
      id: right

      layoutDirection: Qt.RightToLeft
      height: Config.barHeight
      spacing: Config.barMargin
      anchors.right: parent.right
      
      Power {}
      Clock {}
    }
  }
}
