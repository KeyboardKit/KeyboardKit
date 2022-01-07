import SwiftUI

@available(iOS 14.0, *)
public extension EmojiKeyboard where ButtonView == AnyView {
    
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    typealias ButtonBuilder = EmojiButtonBuilder<AnyView>

    /**
     Create an emoji keyboard.

     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - buttonBuilder: A emoji keyboard button builder.
     */
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        buttonBuilder: @escaping ButtonBuilder) {
        self.init(
            emojis: emojis,
            style: style,
            emojiButton: buttonBuilder)
    }
    /**
     This standard button builder will return an button that
     applies the keyboard actions of an `.emoji` action.
     */
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    static func standardButton(
        for emoji: Emoji,
        configuration: EmojiKeyboardStyle) -> AnyView {
        let handler = KeyboardInputViewController.shared.keyboardActionHandler
        return AnyView(
            EmojiKeyboardButton(
                emoji: emoji,
                style: configuration,
                action: { handler.handle(.tap, on: .emoji($0)) }
            )
        )
    }
}
