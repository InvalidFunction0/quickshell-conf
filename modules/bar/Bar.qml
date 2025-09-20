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

    // make bg rectangle invisible because it looks rubbish
    color: "transparent"

    // implicit height basically means real height because
    // reasons ig
    implicitHeight: Config.barHeight

    anchors {
      top: true
      left: true
      right: true
    }

    // make sure the bar can't be infected by the bezels of my monitor
    margins {
      top: Config.barMargin
      right: Config.barMargin
      left: Config.barMargin
    }

    // these rows are to make sure the elements are horizontal
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
