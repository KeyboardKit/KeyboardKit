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
        configuration: EmojiKeyboardStyle,
        action: @escaping (Emoji) -> Void) {
        self.emoji = emoji
        self.configuration = configuration
        self.action = action
    }
    
    private let emoji: Emoji
    private let configuration: EmojiKeyboardStyle
    private let action: (Emoji) -> Void
    
    public var body: some View {
        Button(action: { action(emoji) }) {
            Text(emoji.char).font(configuration.font)
        }
    }
}

struct EmojiKeyboardButton_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiKeyboardButton(
            emoji: Emoji("😜"),
            configuration: .standardPhonePortrait,
            action: { _ in })
    }
}
