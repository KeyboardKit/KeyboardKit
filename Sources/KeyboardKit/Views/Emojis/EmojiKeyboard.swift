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
 
 You can customize the emoji views in the keyboard, by using
 the `emojiButton` initializer, which lets you customize the
 keyboard button for every emoji. If you use the initializer
 without a view builder, you will get a standard button with
 the standard keyboard gestures for every emoji.
 */
@available(iOS 14.0, tvOS 14.0, *)
public struct EmojiKeyboard<ButtonView: View>: View {

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
       - applyGestures: Whether or not to apply standard keyboard gestures to each button, by default `false`.
       - emojiButton: A emoji keyboard button builder function.
     */
    public init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        applyGestures: Bool = false,
        emojiButton: @escaping EmojiButtonBuilder<ButtonView>
    ) {
        let gridItem = GridItem(.fixed(style.itemSize), spacing: style.verticalItemSpacing - 9)
        self.emojis = emojis
        self.style = style
        self.rows = Array(repeating: gridItem, count: style.rows)
        self.applyGestures = applyGestures
        self.emojiButton = emojiButton
    }
    
    private let emojis: [Emoji]
    private let rows: [GridItem]
    private let style: EmojiKeyboardStyle
    private let applyGestures: Bool
    private let emojiButton: EmojiButtonBuilder<ButtonView>
    
    /**
     This typealias represents functions that can be used to
     create an emoji button.
     */
    public typealias EmojiButtonBuilder<EmojiButton: View> = (Emoji, EmojiKeyboardStyle) -> EmojiButton

    public var body: some View {
        LazyHGrid(rows: rows, spacing: style.horizontalItemSpacing) {
            ForEach(emojis) { emoji in
                if applyGestures {
                    buttonView(for: emoji, style: style)
                        .withKeyboardGestures(for: .emoji(emoji), actionHandler: Self.standardKeyboardActionHandler)
                } else {
                    buttonView(for: emoji, style: style)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: style.totalHeight)
    }
}

@available(iOS 14.0, tvOS 14.0, *)
private extension EmojiKeyboard {

    func buttonView(for emoji: Emoji, style: EmojiKeyboardStyle) -> some View {
        emojiButton(emoji, style)
            .accessibilityLabel(emoji.unicodeName ?? "")
            .accessibilityIdentifier(emoji.unicodeIdentifier ?? "")
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiKeyboard {
    
    /**
     This typealias represents an emoji-based action.
     */
    typealias EmojiAction = (Emoji) -> Void

    /**
     The standard action handler to use to handle the emojis.
     */
    static var standardKeyboardActionHandler: KeyboardActionHandler {
        KeyboardInputViewController.shared.keyboardActionHandler
    }

    /**
     The standard action to use when tapping an emoji button.
     */
    static func standardEmojiAction(emoji: Emoji) {
        standardKeyboardActionHandler.handle(.tap, on: .emoji(emoji))
    }

    /**
     The standard action to use when tapping an emoji button.
     */
    static func standardEmojiView(
        for emoji: Emoji,
        style: EmojiKeyboardStyle
    ) -> some View {
        EmojiKeyboardItem(emoji: emoji, style: style)
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiKeyboard {

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
        emojiButtonAction: @escaping EmojiAction
    ) where ButtonView == EmojiKeyboardButton {
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

    /**
     Create an emoji keyboard that uses standard buttons for
     each emoji in the provided collection.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
     */
    init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait
    ) where ButtonView == EmojiKeyboardItem {
        self.init(
            emojis: emojis,
            style: style,
            applyGestures: true,
            emojiButton: { EmojiKeyboardItem(emoji: $0, style: $1) }
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
