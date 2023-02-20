//
//  EmojiKeyboardItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-19.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used in an ``EmojiKeyboard`` to display an
 emoji based on a certain style.
 */
public struct EmojiKeyboardItem: View {

    /**
     Create an emoji keyboard item.

     - Parameters:
       - emoji: The emoji to present.
       - style: The style to use.
     */
    public init(
        emoji: Emoji,
        style: EmojiKeyboardStyle
    ) {
        self.emoji = emoji
        self.style = style
    }
    
    private let emoji: Emoji
    private let style: EmojiKeyboardStyle
    
    public var body: some View {
        Text(emoji.char)
            .font(style.itemFont)
    }
}

struct EmojiKeyboardItem_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiKeyboardItem(
            emoji: Emoji("😜"),
            style: .standardPhonePortrait
        )
    }
}
