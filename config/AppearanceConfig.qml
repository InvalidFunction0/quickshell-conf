import Quickshell.Io

JsonObject {
    property Anim anim: Anim {}
    property Colors colors: Colors {}
    property Fonts fonts: Fonts {}
    property Padding padding: Padding {}
    property Rounding rounding: Rounding {}
    property Spacing spacing: Spacing {}

    component AnimCurves: JsonObject {
        property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
        property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
        property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
    }

    component AnimDurations: JsonObject {
        property real scale: 1
        property int small: 200 * scale
        property int normal: 400 * scale
        property int large: 600 * scale
        property int extraLarge: 1000 * scale
        property int expressiveFastSpatial: 350 * scale
        property int expressiveDefaultSpatial: 500 * scale
        property int expressiveEffects: 200 * scale
    }

    component Anim: JsonObject {
        property AnimCurves curves: AnimCurves {}
        property AnimDurations durations: AnimDurations {}
    }

    component Colors: JsonObject {
        // Catppuccin Macchiato colours
        property string rosewater: "#f4dbd6"
        property string flamingo: "#f0c6c6"
        property string pink: "#f5bde6"
        property string mauve: "#c6a0f6"
        property string red: "#ed8796"
        property string maroon: "#ee99a0"
        property string peach: "#f5a97f"
        property string yellow: "#eed49f"
        property string green: "#a6da95"
        property string teal: "#8bd5ca"
        property string sky: "#91d7e3"
        property string sapphire: "#7dc4e4"
        property string blue: "#8aadf4"
        property string lavender: "#b7bdf4"

        property string text: "#cad3f5"
        property string subtext1: "#b8c0e0"
        property string subtext0: "#a5adcb"

        property string overlay2: "#939ab7"
        property string overlay1: "#8087a2"
        property string overlay0: "#6e738d"

        property string surface2: "#5b6078"
        property string surface1: "#494d64"
        property string surface0: "#363a4f"

        property string base: "#24273a"
        property string mantle: "#1e2030"
        property string crust: "#181926"
    }

    component FontSize: JsonObject {
        property real scale: 1
        property int smaller: 11 * scale
        property int small: 12 * scale
        property int normal: 13 * scale
        property int large: 15 * scale
        property int larger: 18 * scale
        property int extraLarge: 28 * scale
    }

    component FontFamily: JsonObject {
        property string base: "CaskaydiaCove NF"
        property string material: "Material Symbols Rounded"
    }

    component Fonts: JsonObject {
        property FontFamily family: FontFamily {}
        property FontSize size: FontSize {}
    }

    component Padding: JsonObject {
        property real scale: 1
        property int smaller: 5 * scale
        property int small: 7 * scale
        property int normal: 10 * scale
        property int large: 12 * scale
        property int larger: 15 * scale
    }

    component Rounding: JsonObject {
        property real scale: 1
        property int small: 12 * scale
        property int normal: 17 * scale
        property int large: 25 * scale
        property int full: 1000 * scale
    }

    component Spacing: JsonObject {
        property real scale: 1
        property int smaller: 7 * scale
        property int small: 10 * scale
        property int normal: 12 * scale
        property int large: 15 * scale
        property int larger: 20 * scale
    }
}
