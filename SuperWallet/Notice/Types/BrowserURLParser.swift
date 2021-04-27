// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BrowserURLParser {
	let urlRegEx = try! NSRegularExpression(pattern: "^(http(s)?://)?[a-z0-9-_]+(\\.[a-z0-9-_]+)+(/)?", options: .caseInsensitive)
    let validSchemes = ["http", "https"]
    let engine: SearchEngine

    init(
        engine: SearchEngine = .default
    ) {
        self.engine = engine
    }
    
}
