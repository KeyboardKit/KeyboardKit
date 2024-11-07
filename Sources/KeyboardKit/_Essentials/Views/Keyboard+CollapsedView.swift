//
//  Keyboard+CollapsedView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-07.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view can be used to render a collapsed keyboard,
    /// e.g. when an external keyboard is connected.
    ///
    /// The content view is rendered in an `HStack`, since a
    /// collapsed keyboard view is more like a toolbar.
    struct CollapsedView<Content: View>: View {

        /// Create a coll
        public init(
            openKeyboardAction: @escaping () -> Void,
            @ViewBuilder content: @escaping () -> Content

        ) {
            self.openKeyboardAction = openKeyboardAction
            self.content = content
        }

        private let openKeyboardAction: () -> Void
        private let content: () -> Content

        @Environment(\.keyboardToolbarStyle)
        private var toolbarStyle

        public var body: some View {
            Keyboard.Toolbar {
                HStack {
                    content()
                    Spacer()
                    Divider()
                        .frame(maxHeight: toolbarStyle.minHeight - 20)
                    SwiftUI.Button(action: openKeyboardAction) {
                        Image.keyboard
                    }
                }
                .padding(10)
            }
            .font(.title3.weight(.light))
            .buttonStyle(.keyboardPlain)
        }
    }
}

extension ButtonStyle where Self == KeyboardPlainButtonStyle {

    static var keyboardPlain: Self { .init() }
}

struct KeyboardPlainButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    List {
        ForEach(0..<100, id: \.self) { _ in
            Text("")
        }
    }
    .safeAreaInset(edge: .bottom) {
        Keyboard.CollapsedView {
            print("Expand")
        } content: {
            Image.keyboardSettings
            Image.keyboardDictation
            Image.keyboardEmoji
        }
        .background(Color.keyboardBackground)
    }
}
