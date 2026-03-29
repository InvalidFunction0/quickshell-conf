import qs.config
import Quickshell.Io

JsonObject {
    property int expireTimeout: 5 * 1000
    property Sizes sizes: Sizes {}

    component Sizes: JsonObject {
        property int width: 380
        property int height: 100
        property int maskPadding: 7
    }
}
