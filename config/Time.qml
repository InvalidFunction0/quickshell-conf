pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  // make sure the laws of physics are upheld and time travel can't occur.
  // Also ensure the time is never "bob" etc.
  readonly property string time: {
    // I want seconds because precision
    Qt.formatDateTime(clock.date, "hh:mm:ss")
  }

  SystemClock {
    id: clock
    // I do not know why the tutorial said to use this line.
    // It does not work.
    // precision: SystemClock.seconds
  }
}
