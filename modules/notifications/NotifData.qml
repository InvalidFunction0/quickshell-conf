pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import Quickshell.Services.Notifications

QtObject {
    id: notif

    property Notification notification
    property bool popup: true
    property string id
    property string summary
    property string body
    property string appIcon
    property string appName
    property string image
    property HyprlandMonitor focusedMonitor
    property list<var> actions

    readonly property Timer timer: Timer {
        running: true
        interval: 5000
        onTriggered: {
            notif.popup = false;
        }
    }

    Component.onCompleted: {
        if (!notification) {
            return;
        }

        id = notification.id;
        summary = notification.summary;
        body = notification.body;
        appIcon = notification.appIcon;
        appName = notification.appName;
        image = notification.image;
        focusedMonitor = Hyprland.focusedMonitor;
        // qmllint disable unresolved-type
        actions = notification.actions.map(a => ({
                    // qmllint enable unresolved-type
                    identifier: a.identifier,
                    text: a.text,
                    invoke: () => a.invoke
                }));

        // OLD
        // put the chromium link in the summary instead of prepending the body because it annoyed me
        if (notification.appName == "Chromium") {
            // let urlRx = /href="https:\/\/(.*)\/"/; // match the href
            let urlRx = />(.*)</;
            let url = body.match(urlRx)[1]; // only the group inside the regex

            summary = `${summary} (${url})`;
            body = body.replace(/<a.*\/a>/, "");
            body = body.trim();
        }

        // if (notification.appName === "Chromium") {
        //     let bodyLines = body.split("\n");
        //     let url = bodyLines[0];
        //
        //     body = bodyLines.slice(1).join("\n").trim(); // remove the first line with the url
        //     summary = `${summary} (${url})`;
        // }
    }
}
