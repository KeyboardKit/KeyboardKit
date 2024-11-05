//
//  KeyboardPreviews+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
public extension KeyboardInputViewController {

    static var preview: KeyboardInputViewController {
        KeyboardPreviews.PreviewKeyboardInputViewController()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardInputViewController: KeyboardInputViewController {}
}
#endif

public extension Keyboard.Services {
    
    static var preview: Keyboard.Services {
        #if os(iOS) || os(tvOS) || os(visionOS)
        KeyboardInputViewController.preview.services
        #else
        Keyboard.Services(state: .preview)
        #endif
    }
}

public extension Keyboard.State {
    
    static var preview: Keyboard.State {
        #if os(iOS) || os(tvOS) || os(visionOS)
        KeyboardInputViewController.preview.state
        #else
        Keyboard.State()
        #endif
    }
}

public extension KeyboardContext {
    
    static var preview: KeyboardContext {
        #if os(iOS) || os(tvOS) || os(visionOS)
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
            .environmentObject(CalloutContext.preview)
    }
}
