import qs.config
import qs.components
import QtQuick
import Quickshell.Io

StyledWrapper {
    id: root

    readonly property var logoutMenu: Process {
        command: ["sh", "-c", "wlogout"]
    }

    // change the colours to the opposite when hovered because why not
    bg: hover.hovered ? Appearance.colors.sky : Appearance.colors.crust
    fg: hover.hovered ? Appearance.colors.crust : Appearance.colors.sky

    implicitWidth: root.height // make a circle for the power icon to fit in

    MaterialIcon {
        id: icon
        centerText: true
        // magic font makes this an icon
        text: "power_settings_new"
        color: root.fg
    }

    HoverHandler {
        id: hover
    }

    TapHandler {
        onTapped: event => {
            // open the horribly configured wlogout because I can't be bothered
            // to rewrite a logout menu in qs yet because that's effort
            logoutMenu.startDetached();
        }
    }
}
