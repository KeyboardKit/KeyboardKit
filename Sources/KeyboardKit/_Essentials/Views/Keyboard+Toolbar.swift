//
//  Keyboard+Toolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view can be used to render a toolbar with a min
    /// height, to ensure that callouts are not cut off.
    ///
    /// Use a `.keyboardToolbarStyle` view modifier to apply
    /// a keyboard toolbar style.
    struct Toolbar<Content: View>: View {
        
        public init(
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.content = content
        }
        
        @ViewBuilder
        private let content: () -> Content
        
        @Environment(\.keyboardToolbarStyle)
        private var style
        
        public var body: some View {
            content()
                .frame(minHeight: style.minHeight)
                .background(style.backgroundColor)
        }
    }
}

#Preview {
    
    VStack {
        Keyboard.Toolbar {
            Text(".")
        }
        Color.blue
    }
    .background(Color.red)
    .keyboardToolbarStyle(.init(
        backgroundColor: Color.white.opacity(0.4),
        minHeight: 75)
    )
}
