pragma Singleton

import Quickshell

Singleton {
    readonly property AppearanceConfig.Anim anim: Config.appearance.anim
    readonly property AppearanceConfig.Colors colors: Config.appearance.colors
    readonly property AppearanceConfig.Fonts fonts: Config.appearance.fonts
    readonly property AppearanceConfig.Padding padding: Config.appearance.padding
    readonly property AppearanceConfig.Rounding rounding: Config.appearance.rounding
    readonly property AppearanceConfig.Spacing spacing: Config.appearance.spacing
}
