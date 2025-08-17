//
//  DemoKeyboardView.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2025-07-14.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This demo-specific keyboard view sets up a `KeyboardView`
/// and customizes it with basic features.
struct DemoKeyboardView: View {

    let services: Keyboard.Services
    let state: Keyboard.State

    // ‼️ Observe the context to make sure that it updates.
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        KeyboardView(
            layout: layout,
            state: state,
            services: services,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { _ in
                Keyboard.Toolbar {
                    HStack {
                        Spacer()
                        Text("Autocomplete can be tested in the Pro demo.")
                        Spacer()
                    }
                }
            }
        )

        // 💡 Customize the style of any keyboard button.
        .keyboardButtonStyle { params in
            let context = keyboardContext
            var style = params.standardStyle(for: context)
            guard params.action == .backspace else { return style }
            style.backgroundColor = params.isPressed ? .yellow : .blue
            return style
        }

        // 💡 Setup custom callout actions
        .keyboardCalloutActions { params in                 // Apply custom actions to "K" key
            if case .character(let char) = params.action, char == "K" {
                return .init(characters: String("keyboardkit".reversed()))
            }
            return params.standardActions(for: keyboardContext)
        }

        // 💡 Customize the style of the entire keyboard.
        .keyboardViewStyle(
            .init(background: .color(.green))
        )

        // 💡 Customize other custom view styles as well.
        .keyboardToolbarStyle(
            .init(backgroundColor: .red)
        )
    }
}

private extension DemoKeyboardView {

    // 💡 Setup a custom keyboard layout
    var layout: KeyboardLayout {
        NSLog("Creating a custom layout")
        var layout = KeyboardLayout.standard(for: keyboardContext)
        guard keyboardContext.keyboardType == .alphabetic else { return layout }
        var item = layout.createIdealItem(for: .character("!"))
        item.size.width = .input
        layout.itemRows.insert(item, after: .space)
        return layout
    }
}

private extension KeyboardAction {

    var customCalloutActions: [KeyboardAction]? {
        switch self {
        case .character(let char): customCalloutAction(for: char)
        default: nil
        }
    }

    func customCalloutAction(for char: String) -> [KeyboardAction]? {
        guard char.lowercased() == "k" else { return nil }
        let custom = String("keyboardkit".reversed())
        return [KeyboardAction].init(characters: custom)
    }
}
