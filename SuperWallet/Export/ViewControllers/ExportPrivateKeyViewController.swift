// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import UIKit
import MBProgressHUD

final class ExportPrivateKeyViewConroller: UIViewController {

    private struct Layout {
        static var widthAndHeight: CGFloat = 260
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = viewModel.headlineText
        label.textColor = Colors.red
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
}
