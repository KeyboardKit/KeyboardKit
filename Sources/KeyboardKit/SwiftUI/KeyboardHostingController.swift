//
//  KeyboardKeyboardHostingController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This controller can be used to add any `SwiftUI`-based view
 to a `KeyboardInputViewController`.
 
 You can either manually create an instance with a `SwiftUI`
 view as init parameter, then add the controller instance to
 your `KeyboardInputViewController` by calling `add(to:)` or
 call the `KeyboardInputViewController` `setup(with:)` which
 does all this for you.
 */
@available(iOS 13.0, *)
public class KeyboardHostingController<Content: View>: UIHostingController<Content> {
    
    public func add(to controller: KeyboardInputViewController) {
        controller.addChild(self)
        controller.view.addSubview(view)
        didMove(toParent: controller)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }
}
