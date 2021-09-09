// Copyright DApps Platform Inc. All rights reserved.

import UIKit

final class OnboardingCollectionViewController: UICollectionViewController {
    var pages = [OnboardingPageViewModel]()
    weak var pageControl: UIPageControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView?.register(OnboardingPage.self, forCellWithReuseIdentifier: OnboardingPage.identifier)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = view.bounds.size
    }
    
}
