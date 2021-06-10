import Foundation
import RealmSwift

struct BookmarksViewModel {

    let bookmarksStore: BookmarksStore

    init(
        bookmarksStore: BookmarksStore
    ) {
        self.bookmarksStore = bookmarksStore
    }

    var hasBookmarks: Bool {
        return !bookmarksStore.bookmarks.isEmpty
    }
}
