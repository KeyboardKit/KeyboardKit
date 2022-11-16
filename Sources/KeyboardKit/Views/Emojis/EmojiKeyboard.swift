//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This view can be used to list an emoji collection using the
 provided configuration.
 
 You can customize the buttons in the grid by using a custom
 `emojiButton` view builder function. You can also customize
 the button taps when using the standard builder function.
 */
@available(iOS 14.0, tvOS 14.0, *)
public struct EmojiKeyboard<ButtonView: View>: View {

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
       - emojiButton: A emoji keyboard button builder function.
     */
    public init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        emojiButton: @escaping EmojiButtonBuilder<ButtonView>
    ) {
        let gridItem = GridItem(.fixed(style.itemSize), spacing: style.verticalItemSpacing - 9)
        self.emojis = emojis
        self.style = style
        self.rows = Array(repeating: gridItem, count: style.rows)
        self.emojiButton = emojiButton
    }
    
    private let emojis: [Emoji]
    private let rows: [GridItem]
    private let style: EmojiKeyboardStyle
    private let emojiButton: EmojiButtonBuilder<ButtonView>
    
    /**
     This typealias represents functions that can be used to
     create an emoji button.
     */
    public typealias EmojiButtonBuilder<EmojiButton: View> = (Emoji, EmojiKeyboardStyle) -> EmojiButton

    public var body: some View {
        LazyHGrid(rows: rows, spacing: style.horizontalItemSpacing) {
            ForEach(emojis) {
                emojiButton($0, style)
                    .accessibilityLabel($0.unicodeName ?? "")
                    .accessibilityIdentifier($0.unicodeIdentifier ?? "")
            }
        }
        .padding(.horizontal)
        .frame(height: style.totalHeight)
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiKeyboard {
    
    /**
     This typealias represents an emoji-based action.
     */
    typealias EmojiAction = (Emoji) -> Void
    
    /**
     The standard action to use when tapping an emoji button.
     */
    static func standardEmojiAction(emoji: Emoji) {
        let controller = KeyboardInputViewController.shared
        let handler = controller.keyboardActionHandler
        handler.handle(.tap, on: .emoji(emoji))
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiKeyboard where ButtonView == EmojiKeyboardButton {
    
    /**
     Create an emoji keyboard that uses standard buttons for
     each emoji in the provided collection.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
       - emojiButtonAction: The action to perform when an emoji is tapped, by default ``EmojiKeyboard/standardEmojiAction(emoji:)``.
     */
    init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        emojiButtonAction: @escaping EmojiAction = standardEmojiAction
    ) {
        self.init(
            emojis: emojis,
            style: style,
            emojiButton: {
                EmojiKeyboardButton(
                    emoji: $0,
                    style: $1,
                    action: emojiButtonAction)
            }
        )
    }
}

@available(iOS 14.0, tvOS 14.0, *)
struct EmojiKeyboard_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.horizontal) {
            EmojiKeyboard(emojis: Array(Emoji.all.prefix(50)))
        }
    }
}
#endif
