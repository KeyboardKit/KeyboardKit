//
//  Keyboard+NumberPad.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-27.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// This view mimics a native number pad keyboard.
    ///
    /// This view is greedy and will let its keys take up as
    /// much space as they can. You can restrict its size by
    /// applying a `frame` modifier, or adding it as overlay
    /// above e.g. a ``KeyboardView``.
    ///
    /// > Information: You'll be able to style the view with
    /// by applying a ``Keyboard/ButtonStyle`` modifier, but
    /// this won't be implemented until KeyboardKit 9.0.
    struct NumberPad: View {

        public init(
            actions: KeyboardAction.Rows = [
                .init(characters: "123"),
                .init(characters: "456"),
                .init(characters: "789"),
                [.keyboardType(.alphabetic), .character("0"), .backspace]
            ],
            actionHandler: KeyboardActionHandler,
            styleService: KeyboardStyleService,
            keyboardContext: KeyboardContext
        ) {
            self.rows = actions
            self.actionHandler = actionHandler
            self.styleService = styleService
            self.keyboardContext = keyboardContext
        }

        private let rows: KeyboardAction.Rows
        private let actionHandler: KeyboardActionHandler
        private let styleService: KeyboardStyleService
        private let keyboardContext: KeyboardContext

        public var body: some View {
            VStack {
                ForEach(Array(rows.enumerated()), id: \.offset) { row in
                    HStack {
                        ForEach(Array(row.element.enumerated()), id: \.offset) { action in
                            Keyboard.Button(
                                action: action.element,
                                actionHandler: actionHandler,
                                styleService: styleService,
                                keyboardContext: keyboardContext,
                                calloutContext: nil
                            ) {
                                $0.frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        Keyboard.NumberPad(
            actionHandler: .preview,
            styleService: .preview,
            keyboardContext: .preview
        )
        .padding()
        .frame(height: 300)
        .background(Color.keyboardBackground)
    }
}
