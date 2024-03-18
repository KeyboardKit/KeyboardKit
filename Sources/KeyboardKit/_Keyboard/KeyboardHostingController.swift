//
//  KeyboardKeyboardHostingController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-13.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This controller can be used to add any `SwiftUI`-based view
 to a ``KeyboardInputViewController``.
 
 KeyboardKit calls ``add(to:)`` when setting up a view for a
 ``KeyboardInputViewController``, which is done when calling
 ``KeyboardInputViewController/setup(with:)``.
 */
class KeyboardHostingController<Content: View>: UIHostingController<Content> {
    
    /// Add this hosting controller to a keyboard input view
    /// controller, with every required resizing constraints.
    public func add(to controller: KeyboardInputViewController) {
        controller.addChild(self)
        controller.view.addSubview(view)
        didMove(toParent: controller)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }

    deinit {
        removeFromParent()
        guard let view = view else { return }
        DispatchQueue.main.async {
            if view.superview == nil { return }
            view.removeFromSuperview()
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateViewConstraints()
    }
}
#endif
