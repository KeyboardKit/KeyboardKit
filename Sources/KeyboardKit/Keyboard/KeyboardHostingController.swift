//
//  KeyboardKeyboardHostingController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-13.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This controller can be used to add any `SwiftUI`-based view
 to a `KeyboardInputViewController`.
 
 You can either manually create a controller instance with a
 `rootView` then add it to your `KeyboardInputViewController`
 with `add(to:)` or use the input controller's `setup(with:)`
 with a `SwiftUI` `View`, which does of all this for you.
 */
public class KeyboardHostingController<Content: View>: UIHostingController<Content> {
    
    /**
     Add the hosting controller to a keyboard extension view
     controller and setup constraints to resize the keyboard
     extension as the hosting content size changes.
     */
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
        view.removeFromSuperview()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateViewConstraints()
    }
}
#endif
