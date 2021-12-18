//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public extension EmojiKeyboard where EmojiButton == AnyView {
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    typealias ButtonBuilder = EmojiButtonBuilder<AnyView>

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - buttonBuilder: A emoji keyboard button builder, by default `.standardButton`.
     */
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    init(
            emojis: [Emoji],
            style: EmojiKeyboardStyle = .standardPhonePortrait,
            buttonBuilder: @escaping ButtonBuilder = Self.standardButton) {
        let item = GridItem(.fixed(style.itemSize), spacing: style.verticalSpacing - 9)
        self.emojis = emojis.map { EmojiKeyboardItem(emoji: $0) }
        self.style = style
        self.rows = Array(repeating: item, count: style.rows)
        self.buttonBuilder = buttonBuilder
    }
    /**
     This standard button builder will return an button that
     applies the keyboard actions of an `.emoji` action.
     */
    @available(*, deprecated, message: "Use standardEmojiButton.")
    static func standardButton(for emoji: Emoji, configuration: EmojiKeyboardStyle) -> AnyView {
        AnyView(standardEmojiButton(for: emoji, configuration: configuration))
    }
}

public typealias EmojiButtonBuilder<EmojiButton: View> = (Emoji, EmojiKeyboardStyle) -> EmojiButton

@available(iOS 14.0, *)
func standardEmojiKeyboard(emojis: [Emoji],
                           style: EmojiKeyboardStyle = .standardPhonePortrait) -> some View {
    EmojiKeyboard(emojis: emojis, style: style, emojiButtonBuilder: standardEmojiButton)
}

/**
 This view can be used to list an emoji collection using the
 provided configuration.

 You can customize the buttons in the grid by using a custom
 `buttonBuilder` in the initalizer. If you do not, init will
 use the static `standardButton` function.
 */
@available(iOS 14.0, *)
public struct EmojiKeyboard<EmojiButton: View>: View {

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - emojiButtonBuilder: A emoji keyboard button builder, by default `.standardEmojiButton`.
     */
    public init(
            emojis: [Emoji],
            style: EmojiKeyboardStyle = .standardPhonePortrait,
            emojiButtonBuilder: @escaping EmojiButtonBuilder<EmojiButton>
    ) {
        let item = GridItem(.fixed(style.itemSize), spacing: style.verticalSpacing - 9)
        self.emojis = emojis.map {
            EmojiKeyboardItem(emoji: $0)
        }
        self.style = style
        self.rows = Array(repeating: item, count: style.rows)
        self.buttonBuilder = emojiButtonBuilder
    }

    struct EmojiKeyboardItem: Identifiable {
        let id = UUID()
        let emoji: Emoji
    }

    private let buttonBuilder: EmojiButtonBuilder<EmojiButton>
    private let style: EmojiKeyboardStyle
    private let emojis: [EmojiKeyboardItem]
    private let rows: [GridItem]

    public var body: some View {
        LazyHGrid(rows: rows, spacing: style.horizontalSpacing) {
            ForEach(emojis) {
                buttonBuilder($0.emoji, style)
            }
        }.frame(height: style.totalHeight)
    }

    // MARK: - Public Extensions (here to make preview work)

}
/**
 This standard button builder will return an button that
 applies the keyboard actions of an `.emoji` action.
 */
public func standardEmojiButton(for emoji: Emoji, configuration: EmojiKeyboardStyle) -> some View {
    let handler = KeyboardInputViewController.shared.keyboardActionHandler
    let action = {
        handler.handle(.tap, on: .emoji(emoji))
    }
    return Button(action: action) {
        Text(emoji.char).font(configuration.font)
    }
}

@available(iOS 14.0, *)
struct EmojiKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal) {
            EmojiKeyboard(
                emojis: Array(Emoji.all.prefix(50)),
                emojiButtonBuilder: standardEmojiButton
            )
        }
    }
}
