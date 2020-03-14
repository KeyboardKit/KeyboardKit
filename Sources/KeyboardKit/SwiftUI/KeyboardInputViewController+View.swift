//
//  KeyboardInputViewController+View.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension KeyboardInputViewController {
    
    /**
     Remove all subviews from the view controller then add a
     `SwiftUI` `View` that pins to the extension edges.
     */
    func setup<Content: View>(with view: Content) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let controller = KeyboardHostingController(rootView: view)
        controller.add(to: self)
    }
}
