//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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
    
    init(category: EmojiCategory) {
        self.category = category
    }
    
    private let category: EmojiCategory
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        VStack {
            KeyboardGrid(
                actions: actions,
                columns: isLandscape ? 8 : 6,
                spacing: 0,
                buttonBuilder: button)
            SystemKeyboardButtonRow(actions: bottomActions)
        }
    }
}

private extension EmojiKeyboard {
    
    var actions: KeyboardActions {
        emojis.map { KeyboardAction.emoji($0) }
    }
    
    var bottomActions: KeyboardActions {
        let cats = EmojiCategory.allCases.map { KeyboardAction.emojiCategory($0) }
        guard context.needsInputModeSwitchKey else { return cats }
        return [.nextKeyboard] + cats
    }
    
    var emojis: [String] {
        Array(category.emojis.prefix(24))
    }
    
    var isLandscape: Bool { context.controller.deviceOrientation.isLandscape }
    
    func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(action: action)
    }
}
