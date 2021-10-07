//
//  UIImage+Extension.swift
//  Music Bag
//
//  Created by Premier on 06/09/21.
//

import UIKit

extension UIImage {
    
    open class var homeIcon: UIImage {
        return UIImage(named: "iconHomeTabBar")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    open class var backArrowIcon: UIImage {
        return UIImage(named: "backArrowIcon") ?? UIImage()
    }
    
    open class var playIcon: UIImage {
        return UIImage(named: "play") ?? UIImage()
    }
    
    open class var tabBarPlayIcon: UIImage {
        return UIImage(named: "tabBarPlayIcon") ?? UIImage()
    }
    
    open class var pauseIcon: UIImage {
        return UIImage(named: "pause") ?? UIImage()
    }
    
    open class var forwardIcon: UIImage {
        return UIImage(named: "forward") ?? UIImage()
    }
    
    open class var backwardIcon: UIImage {
        return UIImage(named: "backward") ?? UIImage()
    }
    
    open class var forward5SecIcon: UIImage {
        return UIImage(named: "forward5Sec") ?? UIImage()
    }
    
    open class var backward5SecIcon: UIImage {
        return UIImage(named: "backward5Sec") ?? UIImage()
    }
    
    open class var circlebadgeIcon: UIImage {
        return UIImage(named: "circlebadge") ?? UIImage()
    }
    
    open class var eyeIcon: UIImage {
        return UIImage(named: "eyeIcon")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    open class var eyeSlashIcon: UIImage {
        return UIImage(named: "eyeSlashIcon")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    open class var userIcon: UIImage {
        return UIImage(named: "userIcon")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    open class var filledHeartCircleIcon: UIImage {
        return UIImage(named: "filledHeartCircle")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    open class var heartCircleIcon: UIImage {
        return UIImage(named: "heartCircle")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
}

