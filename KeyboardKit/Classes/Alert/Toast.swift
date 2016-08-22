//
//  Toast.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public class Toast: NSObject, MessageAlert {
    
    public func alertMessage(message: String, inView view: UIView, duration: Double) {
        let label = UILabel()
        label.text = message
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(14)
        label.autoresizingMask = .FlexibleHeight
        label.lineBreakMode = .ByWordWrapping
        label.textAlignment = .Center
        label.sizeToFit()
        
        let container = UIView()
        container.frame = CGRectInset(label.frame, -20, -10)
        view.addSubview(container)
        container.layer.cornerRadius = 10
        container.center = view.center
        container.frame.origin.y -= 20
        container.backgroundColor = UIColor.whiteColor()
        
        container.addSubview(label)
        label.frame.origin.x = 20
        label.frame.origin.y = 9
        
        styleLabel(label)
        styleContainerView(container)
        
        let interval = NSTimeInterval(duration)
        UIView.animateWithDuration(interval, animations: { () -> Void in
            container.alpha = 0
        }) { (Bool) -> Void in
            container.removeFromSuperview()
        }
    }
    
    public func styleContainerView(view: UIView) {
    }
    
    public func styleLabel(label: UILabel) {
    }
}
