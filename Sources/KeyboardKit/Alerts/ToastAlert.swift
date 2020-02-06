//
//  ToastAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class presents message alerts as toasts, at the center
 of a keyboard extension's view.
 
 To customize the appearance, you can modify the `appearance`
 property. You can also override the `style` functions.
 
 `TODO:` This alerter should be refactored to use appearance
 proxies, e.g. combined with theme classes.
*/
open class ToastAlert: KeyboardAlert {
    
    
    // MARK: - Initialization
    
    public init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
    }
    
    
    // MARK: - Public Properties
    
    public let appearance: Appearance
    
    
    // MARK: - Types
    
    public class Label: UILabel {}
    
    public class View: UIView {}
    
    public struct Appearance {
        public init() {}
        public var backgroundColor: UIColor = .white
        public var cornerRadius: CGFloat = 10
        public var font: UIFont = .systemFont(ofSize: 10)
        public var horizontalPadding: CGFloat = 20
        public var textColor: UIColor = .black
        public var verticalOffset: CGFloat = 0
        public var verticalPadding: CGFloat = 10
    }
    
    
    // MARK: - Public functions
    
    open func alert(message: String, in view: UIView, withDuration duration: Double) {
        let label = createLabel(withText: message)
        let container = createContainerView(for: label, in: view)
        unpresent(container, withDuration: duration)
    }
    
    open func style(_ view: View) {}
    
    open func style(_ label: Label) {}
    
    open func unpresent(_ view: View, withDuration duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
}


// MARK: - Private Functions

private extension ToastAlert {

    func createContainerView(for label: Label, in view: UIView) -> View {
        let container = View(frame: label.frame)
        view.addSubview(container)
        container.backgroundColor = appearance.backgroundColor
        container.layer.cornerRadius = appearance.cornerRadius
        container.center = view.center
        container.frame.origin.y += appearance.verticalOffset
        container.addSubview(label)
        container.applyShadow(.standardButtonShadow)
        placeContainerView(container, in: view)
        style(container)
        return container
    }
    
    func createLabel(withText text: String) -> Label {
        let label = Label()
        label.text = text
        label.numberOfLines = 0
        label.font = appearance.font
        label.textColor = appearance.textColor
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.sizeToFit()
        style(label)
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
