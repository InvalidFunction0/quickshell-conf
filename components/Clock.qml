import qs.config
import QtQuick
import Quickshell.Io

Widget {
  bgCol: Colors.catCrust
  fgCol: Colors.catLavender
  text: Time.time

  readonly property var process: Process {
    command: ["sh", "-c", "wlogout"]
  }

  function exec() {
    process.startDetached();
  }

  TapHandler {
    onTapped: event => { exec() }
  }
}

