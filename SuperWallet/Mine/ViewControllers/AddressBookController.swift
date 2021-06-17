// Copyright DApps Platform Inc. All rights reserved.

import UIKit


protocol AddressBookControllerDelegate: class {
    func didClickAddButton(bookStorage: AddressBookStorage, viewController: AddressBookController)
    func didClickAddress(bookStorage: AddressBookStorage, addressBook: AddressBook, viewController: AddressBookController)
}
