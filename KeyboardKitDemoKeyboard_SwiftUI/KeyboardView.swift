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
        case .alphabetic(let state): return AnyView(AlphabeticKeyboard(uppercased: true))
        default: return AnyView(Text("Not implemented"))
        }
    }
}

struct AlphabeticKeyboard: View {
    
    let uppercased: Bool
    
    var actionRows: KeyboardActionRows {
        let chars = uppercased ? characters.uppercased() : characters
        return KeyboardActionRows(characters: chars)
    }
    
    let characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    var body: some View {
        VStack(spacing: 13) {
            Text("Autocomplete")
            ForEach(Array(actionRows.enumerated()), id: \.offset) { row in
                HStack(spacing: 6) {
                    ForEach(Array(row.element.enumerated()), id: \.offset) { action in
                        InputButton(height: 42, action: action.element)
                    }
                }
            }
            Text("System")
        }.padding(4)
    }
}

struct InputButton: View {
    
    let height: CGFloat
    let action: KeyboardAction
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        Text(text)
        .systemFont(for: action)
            
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.3), radius: 0, x: 0, y: 1)
            .keyboardAction(action, context: context)
    }
}

private extension InputButton {
    
    var text: String {
        switch action {
        case .character(let char): return char
        case .emoji(let emoji): return emoji
        default: return "-"
        }
    }
}

private extension KeyboardView {
    
    var text: String {
        switch context.keyboardType {
        case .alphabetic: return "alpha"
        default: return "other"
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(controller: KeyboardInputViewController())
    }
}
