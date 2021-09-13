import UIKit
import SnapKit

protocol WelcomeViewControllerDelegate: class {
    func didPressCreateWallet(in viewController: WelcomeViewController)
    func didPressImportWallet(in viewController: WelcomeViewController)
}

final class WelcomeViewController: UIViewController {

    var viewModel = WelcomeViewModel()
    weak var delegate: WelcomeViewControllerDelegate?

//    lazy var collectionViewController: OnboardingCollectionViewController = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.scrollDirection = .horizontal
//        let collectionViewController = OnboardingCollectionViewController(collectionViewLayout: layout)
//        collectionViewController.pages = pages
//        collectionViewController.pageControl = pageControl
//        collectionViewController.collectionView?.isPagingEnabled = true
//        collectionViewController.collectionView?.showsHorizontalScrollIndicator = false
//        collectionViewController.collectionView?.backgroundColor = viewModel.backgroundColor
//        return collectionViewController
//    }()
//    let pageControl: UIPageControl = {
//        let pageControl = UIPageControl()
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        return pageControl
//    }()

    let createWalletButton: UIButton = {
        let button = Button(size: .large, style: .solid)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("welcome.createWallet.button.title", value: "CREATE WALLET", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        button.backgroundColor = Colors.darkBlue
        return button
    }()

    let importWalletButton: UIButton = {
        let importWalletButton = Button(size: .large, style: .border)
        importWalletButton.translatesAutoresizingMaskIntoConstraints = false
        importWalletButton.setTitle(NSLocalizedString("welcome.importWallet.button.title", value: "IMPORT WALLET", comment: ""), for: .normal)
        importWalletButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        importWalletButton.accessibilityIdentifier = "import-wallet"
        return importWalletButton
    }()
}
