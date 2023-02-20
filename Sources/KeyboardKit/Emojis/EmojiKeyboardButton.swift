//
//  EmojiKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-19.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used in an ``EmojiKeyboard`` to display an
 emoji button based on a certain style.

 Note that since the button only has a tap action, it should
 not be used in emoji keyboards where a more complex gesture
 set should be used.
 */
public struct EmojiKeyboardButton: View {

    /**
     Create an emoji keyboard button.

     - Parameters:
       - emoji: The emoji to present.
       - style: The style to use.
       - action: The action to trigger when the button is tapped.
     */
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
            EmojiKeyboardItem(emoji: emoji, style: style)
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
