//
//  Emojis+KeyboardWrapper.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emojis {
    
    /**
     This is used as a view eraser for the emoji keyboard.
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
