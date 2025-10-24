import Quickshell.Io

JsonObject {
    property Colors colors: Colors {}
    property Fonts fonts: Fonts {}
    property Padding padding: Padding {}
    property Rounding rounding: Rounding {}
    property Spacing spacing: Spacing {}

    component Colors: JsonObject {
        // Catppuccin Macchiato colours
        property string crust: "#181926"
        property string mauve: "#c6a0f6"
        property string red: "#ed8796"
        property string peach: "#f5a97f"
        property string yellow: "#eed49f"
        property string green: "#a6da95"
        property string sky: "#91d7e3"
        property string blue: "#8aadf4"
        property string lavender: "#b7bdf4"
        property string text: "#cad3f5"
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
