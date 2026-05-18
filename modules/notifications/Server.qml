pragma Singleton
pragma ComponentBehavior: Bound

import "."
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property list<NotifData> list: []
    property list<var> popups: root.list.filter(n => n.popup)

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

            const comp = notifComp.createObject(root, {
                notification: notif,
                popup: true
            });

            console.log(`Notification from ${notif.appName}:`);
            console.log(`   ${notif.summary}`);
            console.log(`   ${notif.body}`);

            // prepend the new notif to the notif list
            root.list = [comp, ...root.list];
        }
    }

    Component {
        id: notifComp

        NotifData {}
    }
}
