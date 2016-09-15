//
//  Toast.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

open class Toast: NSObject, Alerter {
    
    
    // MARK: - Public functions
    
    public func alert(message: String, inView view: UIView, withDuration duration: Double) {
        let label = createLabel(withMessage: message)
        let container = createContainer(forLabel: label, inView: view)

        style(label: label)
        style(containerView: container)
        
        let interval = TimeInterval(duration)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            container.alpha = 0
        }, completion: { (Bool) -> Void in
            container.removeFromSuperview()
        }) 
    }
    
    open func style(containerView view: UIView) {
    }
    
    open func style(label: UILabel) {
    }
    
    
    
    // MARK: - Private functions
    
    private func createContainer(forLabel label: UILabel, inView view: UIView) -> UIView {
        let container = UIView()
        container.frame = label.frame.insetBy(dx: -20, dy: -10)
        view.addSubview(container)
        container.layer.cornerRadius = 10
        container.center = view.center
        container.frame.origin.y -= 20
        container.backgroundColor = UIColor.white
        container.addSubview(label)
        return container
    }
    
    private func createLabel(withMessage message: String) -> UILabel {
        let label = UILabel()
        label.text = message
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.autoresizingMask = .flexibleHeight
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.sizeToFit()
        label.frame.origin.x = 20
        label.frame.origin.y = 9
        return label
    }
}
