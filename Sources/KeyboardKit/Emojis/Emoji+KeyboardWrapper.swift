//
//  Emoji+KeyboardWrapper.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /**
     This is used as a view eraser for the emoji keyboard to
     make it possible to inject it with the standard builder
     in the system keyboard initializer.
     */
    struct KeyboardWrapper: View {
        
        init(
            actionHandler: KeyboardActionHandler,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            styleProvider: KeyboardStyleProvider
        ) {}
        
        public var body: some View {
            EmptyView()
        }
        
        static let isPro = false
    }
}
