pragma Singleton

import Quickshell

Searcher {
    id: root

    useFuzzy: true
    list: [...DesktopEntries.applications]

    function launch(entry: DesktopEntry): void {
        entry.execute();
    }

    function search(search: string): var {
        console.log(query(search));
    }
}
