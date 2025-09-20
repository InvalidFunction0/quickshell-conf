import qs.config
import qs.components
import QtQuick
import Quickshell.Io

StyledWrapper {
  id: root

  readonly property var process: Process {
    command: ["sh", "-c", "wlogout"]
  }

  bg: handler.hovered ? Colors.catSky : Colors.catCrust
  fg: handler.hovered ? Colors.catCrust : Colors.catSky

  rightMargin: 0
  leftMargin:  0

  width: root.height // make a circle for the power icon to fit in

  child: icon

  MaterialIcon {
    id: icon
    text: "power_settings_new"
    color: root.fg
  }

  HoverHandler {
    id: handler
  }

  TapHandler {
    onTapped: event => {
      process.startDetached()
    }
  }
}
