import qs.config
import qs.components
import QtQuick
import Quickshell.Io

StyledWrapper {
  id: root

  readonly property var process: Process {
    command: ["sh", "-c", "wlogout"]
  }

  // change the colours to the opposite when hovered because why not
  bg: handler.hovered ? Colors.catSky : Colors.catCrust
  fg: handler.hovered ? Colors.catCrust : Colors.catSky

  // reset margins so it's a circle circle and not a long circle
  rightMargin: 0
  leftMargin:  0

  width: root.height // make a circle for the power icon to fit in

  child: icon

  MaterialIcon {
    id: icon
    // magic font makes this an icon
    text: "power_settings_new"
    color: root.fg
  }

  HoverHandler {
    id: handler
  }

  TapHandler {
    onTapped: event => {
      // open the horribly configured wlogout because I can't be bothered
      // to rewrite a logout menu in qs yet because that's effort
      process.startDetached()
    }
  }
}
