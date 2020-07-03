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
        case .alphabetic(let state): return AnyView(AlphabeticKeyboard(inputSet: .english, state: state))
        default: return AnyView(Text("Not implemented"))
        }
    }
}


protocol SystemKeyboard: View {}

extension SystemKeyboard {
    
    /**
     Create a horizontal list of `SystemKeyboardButton` that
     share the available horizontal space.
     */
    func systemButtons(for row: KeyboardActionRow) -> some View {
        HStack(spacing: 6) {
            ForEach(Array(row.enumerated()), id: \.offset) { action in
                SystemKeyboardButton(action: action.element)
            }
        }
    }
}


struct AlphabeticKeyboard: View, SystemKeyboard {
    
    init(inputSet: KeyboardInputSet, state: KeyboardShiftState) {
        self.inputSet = inputSet
        self.state = state
    }
    
    private let inputSet: KeyboardInputSet
    private let state: KeyboardShiftState
    
    var inputActions: KeyboardActionRows {
        let inputs = inputSet.inputCharacters
        let chars = state.isUppercased ? inputs.uppercased() : inputs
        return KeyboardActionRows(characters: chars)
    }
    
    /*TODO:
    Numeric keyboard
    Symbolic keyboard
    Emoji keyboard
     Image keyboard*/
    
    var body: some View {
        VStack(spacing: 13) {
            AutocompleteToolbar()
            systemButtons(for: inputActions[0])
            HStack {
                Spacer(minLength: 20)
                systemButtons(for: inputActions[1])
                Spacer(minLength: 20)
            }
            HStack {
                SystemKeyboardButton(action: .shift(currentState: state))
                    .frame(width: 50)
                systemButtons(for: inputActions[2])
                SystemKeyboardButton(action: .backspace)
                    .frame(width: 50)
            }
            SystemKeyboardBottomRow(leftmostAction: .keyboardType(.numeric))
        }.padding(4)
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
