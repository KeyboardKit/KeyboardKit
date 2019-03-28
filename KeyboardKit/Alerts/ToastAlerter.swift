//
//  ToastAlerter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This class presents keyboard alerts like Android toasts, at
 the center of the keyboard.
 
 To customize the appearance of these alerts, you can modify
 the `appearance` property. If this is insufficient, you can
 override `style(containerView)` and `style(label)` as well.
 
*/

import UIKit

open class ToastAlerter: NSObject, KeyboardAlerter {
    
    
    // MARK: - Public Properties
    
    public var appearance = ToastAppearance()
    
    
    // MARK: - Public functions
    
    open func alert(message: String, in view: UIView, withDuration duration: Double) {
        let label = createLabel(withMessage: message)
        let container = createContainerView(forLabel: label, in: view)
        UIView.animate(withDuration: duration, animations: {
            container.alpha = 0
        }, completion: { _ in
            container.removeFromSuperview()
        }) 
    }
    
    open func style(containerView view: UIView) {}
    
    open func style(label: UILabel) {}
}


// MARK: - Private Functions

private extension ToastAlerter {

    func createContainerView(forLabel label: UILabel, in view: UIView) -> UIView {
        let container = UIView(frame: label.frame)
        view.addSubview(container)
        container.backgroundColor = appearance.backgroundColor
        container.layer.cornerRadius = appearance.cornerRadius
        container.center = view.center
        container.frame.origin.y += appearance.verticalOffset
        container.addSubview(label)
        placeContainerView(container, in: view)
        style(containerView: container)
        return container
    }
    
    func createLabel(withMessage message: String) -> UILabel {
        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.font = appearance.font
        label.textColor = appearance.textColor
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.sizeToFit()
        style(label: label)
        label.autoresizingMask = .centerInParent
        return label
    }
    
    func placeContainerView(_ container: UIView, in view: UIView) {
        container.autoresizingMask = .centerInParent
        let dx = -appearance.horizontalPadding
        let dy = -appearance.verticalPadding
        container.frame = container.frame.insetBy(dx: dx, dy: dy)
    }
}
