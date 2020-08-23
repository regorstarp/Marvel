//
//  UIApplication+TopViewController.swift
//  Marvel
//
//  Created by Roger Prats Llivina on 22/08/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let baseViewController = base ?? UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        
        if let nav = baseViewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = baseViewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = baseViewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return baseViewController
    }
}
