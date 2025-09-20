import qs.config
import qs.components
import QtQuick
import Quickshell.Io

StyledWrapper {
  id: root
  bg: Colors.catCrust
  fg: Colors.catLavender

  StyledText {
    color: root.fg
    text: Time.time
  }
}

