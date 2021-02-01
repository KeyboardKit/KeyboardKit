//
//  KeyboardInputViewController+View.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

public extension KeyboardInputViewController {
    
    /**
     Removes all subviews from the view and adds a `SwiftUI`
     view, that pins to the edges and resizes the extension.
     
     This function also applies `@EnvironmentObject`s to the
     view, that can be used by all nested views.
     */
    func setup<Content: View>(
        with view: Content,
        secondaryInputCalloutContext: SecondaryInputCalloutContext? = nil) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = view
            .environmentObject(keyboardContext)
            .environmentObject(keyboardInputCalloutContext)
            .environmentObject(keyboardSecondaryInputCalloutContext)
        let controller = KeyboardHostingController(rootView: view)
        controller.add(to: self)
    }
}

private extension KeyboardInputViewController {
    
    var secondaryInputCalloutContextFallback: SecondaryInputCalloutContext {
        SecondaryInputCalloutContext(
            context: keyboardContext,
            actionProvider: PreviewSecondaryCalloutActionProvider.preview,
            actionHandler: keyboardActionHandler)
    }
}
