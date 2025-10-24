import Quickshell.Io

JsonObject {
    property int expireTimeout: 5 * 1000
    property Sizes sizes: Sizes {}

    component Sizes: JsonObject {
        property int width: 400
        property int image: 41
        property int badge: 20
    }
}
