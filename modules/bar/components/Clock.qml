import qs.config
import qs.components
import qs.services
import QtQuick
import Quickshell.Io

StyledWrapper {
    id: root
    bg: Appearance.colors.crust
    fg: Appearance.colors.lavender

    StyledText {
        centerText: true
        color: root.fg
        text: Time.time
    }
}
