pragma ComponentBehavior: Bound

import "."
import qs.components
import qs.config
import QtQuick
import Quickshell
import Quickshell.Widgets

ClippingRectangle {
    id: root
    required property NotifData modelData
    property int cornerRadius: Appearance.rounding.large - Config.notifs.sizes.maskPadding
    property int nonAnimHeight: {
        // let height = root.expanded ? (inner.anchors.margins * 2) + summary.implicitHeight + bodyPreview.height : 1;
        let height = inner.anchors.margins * 2; // padding that will always be there
        height += summary.implicitHeight;
        height += root.expanded ? body.height : bodyPreview.height;
        return height;
    }
    property bool expanded: false

    implicitWidth: Config.notifs.sizes.width
    implicitHeight: nonAnimHeight
    color: Appearance.colors.base
    radius: cornerRadius

    Behavior on implicitHeight {
        Anim {}
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        preventStealing: true

        onEntered: root.modelData.timer.stop()
        onExited: root.modelData.timer.start()

        drag.target: parent
        drag.axis: Drag.XAxis

        onClicked: event => {
            const actions = root.modelData.actions;
            if (actions.length === 1)
                actions[0].invoke();
        }

        Item {
            id: inner
            anchors.fill: parent
            anchors.margins: Appearance.padding.normal

            Loader {
                id: notifImage

                asynchronous: true
                active: true

                anchors.left: parent.left
                anchors.top: parent.top
                width: 41
                height: 41

                ClippingRectangle {
                    radius: Appearance.rounding.full
                    implicitHeight: 41
                    implicitWidth: 41

                    Image {
                        anchors.fill: parent

                        sourceSize.width: 41
                        sourceSize.height: 41
                        source: Qt.resolvedUrl(root.modelData.image)
                        // source: root.modelData.image
                        fillMode: Image.PreserveAspectCrop
                        cache: false
                        asynchronous: true
                    }
                }
            }

            Loader {
                id: appIcon

                asynchronous: true
                active: true

                anchors.right: notifImage.right
                anchors.bottom: notifImage.bottom
                anchors.rightMargin: -2
                anchors.bottomMargin: -2
                width: 15
                height: width

                ClippingRectangle {
                    radius: Appearance.rounding.full
                    implicitHeight: parent.height
                    implicitWidth: parent.width

                    Image {
                        anchors.fill: parent

                        sourceSize.width: parent.height
                        sourceSize.height: parent.width
                        source: Quickshell.iconPath(root.modelData.appIcon)
                        // source: root.modelData.image
                        fillMode: Image.PreserveAspectCrop
                        cache: false
                        asynchronous: true
                    }
                }
            }

            Item {
                id: expandButton

                anchors.top: parent.top
                anchors.right: parent.right

                implicitHeight: expandIcon.height
                implicitWidth: expandIcon.width

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.expanded = !root.expanded;
                    }
                }

                MaterialIcon {
                    id: expandIcon

                    anchors.centerIn: parent
                    text: root.expanded ? "expand_less" : "expand_more"
                }
            }

            TextMetrics {
                id: summaryMetrics

                text: root.modelData.summary
                font.family: summary.font.family
                font.pointSize: summary.font.pointSize
                font.weight: summary.font.weight
                elide: Text.ElideRight
                elideWidth: summary.width
            }

            StyledText {
                id: summary

                anchors.top: parent.top
                anchors.left: notifImage.right
                anchors.right: expandButton.left

                anchors.leftMargin: Appearance.padding.normal

                // height: implicitHeight

                wrapMode: Text.WordWrap
                maximumLineCount: undefined

                // font.pointSize: Appearance.fonts.size.large
                font.weight: 600
                font.family: "Rubik"

                text: root.expanded ? root.modelData.summary : summaryMetrics.elidedText
            }

            TextMetrics {
                id: bodyPreviewMetrics

                text: root.modelData.body
                font.family: bodyPreview.font.family
                font.pointSize: bodyPreview.font.pointSize
                elide: Text.ElideRight
                elideWidth: bodyPreview.width
                Component.onCompleted: {
                    console.log(`elided width is ${elideWidth}`);
                }
            }

            StyledText {
                id: bodyPreview

                anchors.left: summary.left
                anchors.top: summary.bottom
                anchors.right: parent.right

                textFormat: Text.MarkdownText

                font.pointSize: Appearance.fonts.size.small
                font.weight: 500
                font.family: "Rubik"
                color: Appearance.colors.subtext0

                opacity: root.expanded ? 0 : 1

                text: bodyPreviewMetrics.elidedText

                Behavior on opacity {
                    Anim {}
                }
            }

            StyledText {
                id: body

                anchors.left: summary.left
                anchors.right: expandButton.left
                anchors.top: summary.bottom

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.MarkdownText

                font.pointSize: Appearance.fonts.size.small
                font.weight: 500
                font.family: "Rubik"

                onLinkActivated: link => {
                    Quickshell.execDetached(["app2unit", "-O", "--", link]);
                }

                opacity: root.expanded ? 1 : 0

                text: root.modelData.body

                Behavior on opacity {
                    Anim {}
                }
            }
        }
    }
}
