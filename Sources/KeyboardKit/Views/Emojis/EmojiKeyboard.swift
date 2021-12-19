//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to list an emoji collection using the
 provided configuration.

 You can customize the buttons in the grid by using a custom
 `buttonBuilder` in the initalizer. If you do not, init will
 use the static `standardButton` function.
 */
@available(iOS 14.0, *)
public struct EmojiKeyboard<ButtonView: View>: View {

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - emojiButton: A emoji keyboard button builder, by default `.standardEmojiButton`.
     */
    public init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        emojiButton: @escaping EmojiButtonBuilder<ButtonView>) {
        let gridItem = GridItem(.fixed(style.itemSize), spacing: style.verticalSpacing - 9)
        self.emojis = emojis.map { EmojiKeyboardItem(emoji: $0) }
        self.style = style
        self.rows = Array(repeating: gridItem, count: style.rows)
        self.emojiButton = emojiButton
    }
    
    private let emojis: [EmojiKeyboardItem]
    private let rows: [GridItem]
    private let style: EmojiKeyboardStyle
    private let emojiButton: EmojiButtonBuilder<ButtonView>
    
    /**
     This typealias represents functions that can be used to
     create an emoji button.
     */
    public typealias EmojiButtonBuilder<EmojiButton: View> = (Emoji, EmojiKeyboardStyle) -> EmojiButton
    
    /**
     This internal struct is used to make it possible to use
     the same emoji at multiple places in the same keyboard.
     */
    struct EmojiKeyboardItem: Identifiable {
        let id = UUID()
        let emoji: Emoji
    }

    public var body: some View {
        LazyHGrid(rows: rows, spacing: style.horizontalSpacing) {
            ForEach(emojis) {
                emojiButton($0.emoji, style)
            }
        }.frame(height: style.totalHeight)
    }
}

@available(iOS 14.0, *)
public extension EmojiKeyboard where ButtonView == EmojiKeyboardButton {
    
    /**
     Create an emoji keyboard that uses standard buttons for
     each emoji in the provided collection.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - emojiButtonBuilder: A emoji keyboard button builder, by default `.standardEmojiButton`.
     */
    init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait) {
        let handler = KeyboardInputViewController.shared.keyboardActionHandler
        self.init(
            emojis: emojis,
            style: style,
            emojiButton: {
                EmojiKeyboardButton(
                    emoji: $0,
                    configuration: $1,
                    action: { handler.handle(.tap, on: .emoji($0)) })
            }
        )
    }
}

@available(iOS 14.0, *)
struct EmojiKeyboard_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.horizontal) {
            EmojiKeyboard(emojis: Array(Emoji.all.prefix(50)))
        }
    }
}
