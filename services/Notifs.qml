pragma Singleton

import qs.components
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

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
                notification: notif
            });
        }
    }

    component Notif: QtObject {
        id: notif

        property Notification notification
        property string summary
        property string body

        Component.onCompleted: {
            if (!notification)
                return;

            summary = notification.summary;
            body = notification.body;

            console.log(`${summary} ${body}`);
        }
    }

    Component {
        id: notifComp

        Notif {}
    }
}
