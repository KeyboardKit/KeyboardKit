//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

/**
 This keyboard is a custom view that is implemented for this
 project alone. It takes the provided category and lists the
 24 first emojis in a grid, where the number of columns will
 depend on if the grid is presented in portrait or landscape.
 
 `TODO` The 24 emoji thing is only because SwiftUI can't add
 all emojis in long, scrolling stack. This will cause memory
 pressure related crashes, since SwiftUI 1 doesn't have lazy
 loaded stacks. When the library is updated for SwiftUI 2, I
 will create a richer emoji keyboard and add it to the repo.
 */
struct EmojiKeyboard: View {
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        VStack(spacing: 30) {
            KeyboardGrid(
                actions: actions,
                columns: isLandscape ? 8 : 6,
                spacing: 0,
                buttonBuilder: button)
            bottomRow
        }
    }
}

private extension EmojiKeyboard {
    
    var actions: KeyboardActions {
        emojis.map { KeyboardAction.emoji($0) }
    }
    
    var bottomActions: KeyboardActions {
        let cats = EmojiCategory.allCases.filter { $0 != .frequent }
        let actions = cats.map { KeyboardAction.emojiCategory($0) }
        return [.keyboardType(.alphabetic(.lowercased))] + actions + [.backspace]
    }
    
    var bottomRow: some View {
        let handler = context.actionHandler
        return HStack(spacing: 10) {
            ForEach(Array(bottomActions.enumerated()), id: \.offset) { item in
                self.bottomView(for: item.element).keyboardAction(item.element, actionHandler: handler)
            }
        }
    }
    
    var category: EmojiCategory {
        let category = context.emojiCategory
        return category == .frequent ? .smileys : category
    }
    
    var emojis: [String] {
        Array(category.emojis.prefix(24))
    }
    
    var isLandscape: Bool { context.controller.deviceOrientation.isLandscape }
    
    func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(action: action)
    }
    
    func bottomView(for action: KeyboardAction) -> AnyView {
        if let image = action.standardButtonImage(for: context) { return AnyView(image) }
        return AnyView(Text(action.standardButtonText ?? ""))
    }
}
