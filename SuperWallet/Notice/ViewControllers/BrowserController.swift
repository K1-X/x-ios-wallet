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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        view.addSubview(progressView)
        navigationItem.title = "NewsDApp"
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if loadURL.isEmpty {
            loadURL = "http://h5.meiti.in/"
        }
        webview.load(URLRequest.init(url: URL.init(string: loadURL)!))
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (_) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        webview.removeObserver(self, forKeyPath: "estimatedProgress")
        webview.uiDelegate = nil
        webview.navigationDelegate = nil
    }
}

extension BrowserController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("")
        self.webview.evaluateJavaScript("document.title") { (result, _) in
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}

extension BrowserController: WKUIDelegate {

}

