//
//  Emoji+KeyboardWrapper.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /// This view is used as a keyboard emoji view eraser to
    /// ensure that the view is only used for valid licenses.
    struct KeyboardWrapper: View {
        
        init(
            actionHandler: KeyboardActionHandler,
            keyboardContext: KeyboardContext,
            calloutContext: KeyboardCalloutContext?,
            styleService: KeyboardStyleService
        ) {}

        public var body: some View {
            EmptyView()
        }
        
        static let isEmojiKeyboardAvailable = false
    }
}
