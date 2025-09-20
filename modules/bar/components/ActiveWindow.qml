import qs.config
import qs.components
import QtQuick
import Quickshell.Hyprland

StyledWrapper {
  id: root

  bg: Colors.catCrust
  fg: Colors.catGreen

  // make sure the text can't sneak its way past the edge because it looks ugly as hell
  clip: true

  // multiply the text pad by 2 because right and left I think
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

