pragma Singleton

import qs.config
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property list<Notif> list: []
    readonly property list<Notif> popups: list.filter(n => n.popup)

    NotificationServer {
        id: server

        keepOnReload: false
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notif => {
            notif.tracked = true;

            const obj = notifComp.createObject(root, {
                popup: true,
                notification: notif
            });
            root.list = [obj, ...root.list];
        }
    }

    component Notif: QtObject {
        id: notif

        property Notification notification
        property bool popup
        property string summary
        property string body

        Component.onCompleted: {
            if (!notification)
                return;

            summary = notification.summary;
            body = notification.body;

            console.log(`${summary}\n${body}`);
        }

        readonly property Timer timer: Timer {
            running: true
            interval: Config.notifs.expireTimeout
            onTriggered: {
                notif.popup = false;
            }
        }
    }

    Component {
        id: notifComp

        Notif {}
    }
}
