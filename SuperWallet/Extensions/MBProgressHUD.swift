// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import MBProgressHUD
import Kingfisher

extension MBProgressHUD {

    class func showGifAdded(to view:UIView!,userInterface:Bool = true,animated:Bool = true){
        let path = Bundle.main.path(forResource:"source_loading", ofType:"gif")
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 68))
        image.backgroundColor = UIColor.clear;        image.kf.setImage(with:ImageResource(downloadURL:URL(fileURLWithPath: path!)))
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.bezelView.backgroundColor = UIColor.clear
        hud.mode = .customView
        hud.isUserInteractionEnabled = userInterface
        hud.customView = image
        hud.label.text = "..."
        hud.customView?.backgroundColor = UIColor.clear
    }    
}
