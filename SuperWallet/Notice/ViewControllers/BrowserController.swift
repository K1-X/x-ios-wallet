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

    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView(frame: CGRect(x: CGFloat(0), y: CGFloat(currentNaviHeight), width: screenWidth, height: 2))
        self.progressView.tintColor = UIColor.yellow      // 
        self.progressView.trackTintColor = UIColor.white // 
        return self.progressView
    }()

    init(loadURL: String) {
        self.loadURL = loadURL
        super.init(nibName: nil, bundle: nil)
    }
}
