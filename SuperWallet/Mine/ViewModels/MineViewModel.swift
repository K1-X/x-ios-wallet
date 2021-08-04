import Foundation

struct MineViewModel {

    private let isDebug: Bool

    init(
        isDebug: Bool = false
        ) {
        self.isDebug = isDebug
    }    


    var servers: [RPCServer] {
        return [
            RPCServer.main
//            RPCServer.classic,
//            RPCServer.poa,
//            RPCServer.callisto,
//            RPCServer.gochain
        ]
    }

    var publishTokenTitle: String {
        return NSLocalizedString("mine.publishToken.button.title", value: "publishToken", comment: "")
    }

    var addressBookTitle: String {
        return NSLocalizedString("mine.addressBook.button.title", value: "addressBook", comment: "")
    }
}
