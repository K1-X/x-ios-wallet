import UIKit
import WebKit

class BrowserController: UIViewController {

    var loadURL: String
    lazy private var webview: WKWebView = {
        self.webview = WKWebView.init(frame: view.bounds)
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        return self.webview
    }()
}
