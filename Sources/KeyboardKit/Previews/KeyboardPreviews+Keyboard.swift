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

    /// This controller can be used in SwiftUI previews.
    static var preview: KeyboardInputViewController {
        KeyboardPreviews.InputViewController()
    }
}

public extension KeyboardPreviews {
    
    /// This controller can be used in SwiftUI previews.
    class InputViewController: KeyboardInputViewController {
        
        open override func viewWillRegisterSharedController() {}
    }
}
#endif

public extension KeyboardContext {
    
    /// This context can be used in SwiftUI previews.
    static var preview: KeyboardContext {
        #if os(iOS) || os(tvOS)
        KeyboardContext(controller: KeyboardInputViewController.preview)
        #else
        KeyboardContext()
        #endif
    }
}

public extension View {

    /// Prepare the view with preview environments.
    func keyboardPreview(keyboardContext: KeyboardContext = .preview) -> some View {
        self.environmentObject(keyboardContext)
            .environmentObject(CalloutActionContext.preview)
            .environmentObject(CalloutInputContext.preview)
    }
}
