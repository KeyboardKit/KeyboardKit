//
//  KeyboardPreviews+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
public extension KeyboardInputViewController {

    static var preview: KeyboardInputViewController {
        KeyboardPreviews.InputViewController()
    }
}

public extension KeyboardPreviews {
    
    class InputViewController: KeyboardInputViewController {}
}
#endif

public extension Keyboard.Services {
    
    static var preview: Keyboard.Services {
        Keyboard.Services(state: .preview)
    }
}

public extension Keyboard.State {
    
    static var preview: Keyboard.State {
        Keyboard.State()
    }
}

public extension KeyboardContext {
    
    static var preview: KeyboardContext {
        KeyboardContext()
    }
}

public extension View {

    /// Prepare the view with preview environments.
    func keyboardPreview(
        keyboardContext: KeyboardContext = .preview
    ) -> some View {
        self.environmentObject(keyboardContext)
            .environmentObject(CalloutContext.preview)
    }
}
