//
//  KeyboardPreviews+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {

    static var preview: KeyboardInputViewController {
        KeyboardPreviews.PreviewKeyboardInputViewController()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardInputViewController: KeyboardInputViewController {
        
        open override func viewWillRegisterSharedController() {}
    }
}
#endif

public extension Keyboard.KeyboardServices {
    
    static var preview: Keyboard.KeyboardServices {
        KeyboardInputViewController.preview.services
    }
}

public extension Keyboard.KeyboardState {
    
    static var preview: Keyboard.KeyboardState {
        KeyboardInputViewController.preview.state
    }
}

public extension KeyboardContext {
    
    static var preview: KeyboardContext {
        #if os(iOS) || os(tvOS)
        let context = KeyboardContext()
        context.sync(with: .preview)
        return context
        #else
        KeyboardContext()
        #endif
    }
}

public extension View {

    /// Prepare the view with preview environments.
    func keyboardPreview(keyboardContext: KeyboardContext = .preview) -> some View {
        self.environmentObject(keyboardContext)
            .environmentObject(CalloutContext.ActionContext.preview)
            .environmentObject(CalloutContext.InputContext.preview)
    }
}
