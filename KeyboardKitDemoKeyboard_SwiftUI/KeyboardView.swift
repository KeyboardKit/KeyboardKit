//
//  KeyboardView.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit
import KeyboardKitSwiftUI

struct KeyboardView: View {
    
    init(controller: KeyboardInputViewController) {
        self.controller = controller
    }
    
    private let controller: KeyboardInputViewController
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        keyboardView
    }
}

private extension KeyboardView {
    
    var keyboardView: AnyView {
        switch context.keyboardType {
        case .alphabetic(let state): return AnyView(AlphabeticKeyboard(state: state))
        default: return AnyView(Text("Not implemented"))
        }
    }
}

struct AlphabeticKeyboard: View {
    
    let state: KeyboardShiftState
    
    var inputActions: KeyboardActionRows {
        let chars = state.isUppercased ? inputCharacters.uppercased() : inputCharacters
        return KeyboardActionRows(characters: chars)
    }
    
    let inputCharacters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    var body: some View {
        VStack(spacing: 13) {
            Text("Autocomplete")
            inputButtons(for: inputActions[0])
            HStack {
                Spacer(minLength: 20)
                inputButtons(for: inputActions[1])
                Spacer(minLength: 20)
            }
            HStack {
                InputButton(action: .shift(currentState: state))
                    .frame(width: 50)
                inputButtons(for: inputActions[2])
                InputButton(action: .backspace)
                    .frame(width: 50)
            }
            HStack {
                InputButton(action: .keyboardType(.numeric))
                InputButton(action: .keyboardType(.emojis))
                inputButtons(for: inputActions[2])
                InputButton(action: .re)
                    .frame(width: 50)
            }
            InputButton(action: .emoji("😀"))
            Text("System")
        }.padding(4)
    }
    
    func inputButtons(for row: KeyboardActionRow) -> some View {
        HStack(spacing: 6) {
            ForEach(Array(row.enumerated()), id: \.offset) { action in
                InputButton(action: action.element)
            }
        }
    }
}

struct InputButton: View {
    
    let action: KeyboardAction
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        buttonContent
            .systemKeyboardButtonStyle(for: action, scheme: colorScheme, context: context)
            .keyboardAction(action, context: context)
    }
    
    var buttonContent: AnyView {
        if let text = action.systemKeyboardButtonText {
            return AnyView(Text(text))
        }
        if let image = action.systemKeyboardButtonImage(for: context) {
            return AnyView(image)
        }
        return AnyView(Text("-"))
    }
}



struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
