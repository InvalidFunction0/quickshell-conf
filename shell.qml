import Quickshell
import QtQuick
// import qs.modules.bar
import qs.modules.notifications as Notifs
import qs.modules.background
import qs.modules.submap
import qs.modules.launcher

ShellRoot {
    // Bar {}
    BG {}
    Notifs.Panel {}
    Submap {}
    Launcher {}
}
