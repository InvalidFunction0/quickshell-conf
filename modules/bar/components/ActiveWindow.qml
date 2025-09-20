import qs.config
import qs.components
import QtQuick
import Quickshell.Hyprland

StyledWrapper {
  id: root

  bg: Colors.catCrust
  fg: Colors.catGreen

  clip: true
  implicitWidth: title.implicitWidth + ( Config.textPadding * 2 )

  StyledText {
    id: title

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

