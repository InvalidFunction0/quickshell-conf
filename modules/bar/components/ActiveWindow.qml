import qs.config
import qs.components
import QtQuick
import Quickshell.Hyprland

StyledWrapper {
    id: root

    bg: Appearance.colors.crust
    fg: Appearance.colors.green

    // make sure the text can't sneak its way past the edge because it looks ugly as hell
    clip: true

    StyledText {
        id: title

        centerText: true
        color: root.fg
        text: Hyprland.activeToplevel.title

        Behavior on text {
            TAnim {
                target: title
            }
        }
    }

    Behavior on implicitWidth {
        Anim {}
    }
}
