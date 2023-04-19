//
//  Keyboard+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {

    /**
     This preview controller can be used in SwiftUI previews.
     */
    static var preview: KeyboardInputViewController {
        KeyboardInputViewController()
    }
}
#endif

public extension KeyboardContext {
    
    /**
     This preview context can be used in SwiftUI previews.
     */
    static var preview: KeyboardContext {
        #if os(iOS) || os(tvOS)
        KeyboardContext(controller: KeyboardInputViewController.preview)
        #else
        KeyboardContext()
        #endif
    }
}

public extension View {

    /**
     This modifier prepares the view with environment object
     instances that are required for some views.
     */
    func keyboardPreview(keyboardContext: KeyboardContext = .preview) -> some View {
        self.environmentObject(keyboardContext)
            .environmentObject(ActionCalloutContext.preview)
            .environmentObject(InputCalloutContext.preview)
    }
}
