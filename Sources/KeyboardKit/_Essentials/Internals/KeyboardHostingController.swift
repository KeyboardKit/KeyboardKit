//
//  KeyboardKeyboardHostingController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-13.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI

/// This controller is used to set up custom `SwiftUI` views
/// with ``KeyboardInputViewController``.
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
