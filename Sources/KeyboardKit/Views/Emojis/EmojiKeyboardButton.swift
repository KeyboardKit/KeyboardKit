//
//  EmojiKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders a standard button for an emoji.
 */
public struct EmojiKeyboardButton: View {
    
    public init(
        emoji: Emoji,
        style: EmojiKeyboardStyle,
        action: @escaping (Emoji) -> Void
    ) {
        self.emoji = emoji
        self.style = style
        self.action = action
    }
    
    private let emoji: Emoji
    private let style: EmojiKeyboardStyle
    private let action: (Emoji) -> Void
    
    public var body: some View {
        Button(action: { action(emoji) }, label: {
            Text(emoji.char).font(style.itemFont)
        })
    }
}

struct EmojiKeyboardButton_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiKeyboardButton(
            emoji: Emoji("😜"),
            style: .standardPhonePortrait,
            action: { _ in })
    }
}
