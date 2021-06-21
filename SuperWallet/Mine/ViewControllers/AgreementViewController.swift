// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class AgreementViewController: UIViewController {

    lazy var webView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        navigationItem.title = ""
        view.addSubview(webView)
        webView.frame = view.bounds
        let path = Bundle.main.bundlePath
        let url = URL.init(fileURLWithPath: path)
        let htmlPath = Bundle.main.path(forResource: "agreement", ofType: "html")
        let htmlContent = try!String.init(contentsOfFile: htmlPath!)
        webView.loadHTMLString(htmlContent, baseURL: url)
    }
}
