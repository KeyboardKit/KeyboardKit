import Foundation
import SwiftUI

public extension EmojiCategoryKeyboard {
    
    @available(*, deprecated, message: "Use the styleProvider initializer instead")
    init(
        selection: EmojiCategory? = nil,
        categories: [EmojiCategory] = EmojiCategory.all,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        appearance: KeyboardAppearance,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = { $0.title }
    ) {
        self.init(
            selection: selection,
            categories: categories,
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            style: style,
            styleProvider: appearance,
            categoryTitle: categoryTitle
        )
    }
}

public extension EmojiCategoryKeyboardMenu {
    
    @available(*, deprecated, message: "Use the styleProvider initializer instead")
    init(
        selection: Binding<EmojiCategory>,
        categories: [EmojiCategory] = EmojiCategory.all,
        keyboardContext: KeyboardContext,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        style: EmojiKeyboardStyle
    ) {
        self.init(
            selection: selection,
            categories: categories,
            keyboardContext: keyboardContext,
            actionHandler: actionHandler,
            style: style,
            styleProvider: appearance
        )
    }
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public protocol EmojiAnalyzer {}

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public extension EmojiAnalyzer {

    func containsEmoji(_ string: String) -> Bool {
        string.containsEmoji
    }

    func containsOnlyEmojis(_ string: String) -> Bool {
        string.containsOnlyEmojis
    }

    func emojis(in string: String) -> [Character] {
        string.emojis
    }

    func emojiScalars(in string: String) -> [UnicodeScalar] {
        string.emojiScalars
    }

    func emojiString(in string: String) -> String {
        string.emojiString
    }

    func isEmoji(_ char: Character) -> Bool {
        char.isEmoji
    }

    func isCombinedEmoji(_ char: Character) -> Bool {
        char.isCombinedEmoji
    }

    func isSimpleEmoji(_ char: Character) -> Bool {
        char.isSimpleEmoji
    }

    func isSingleEmoji(_ string: String) -> Bool {
        string.isSingleEmoji
    }
}

@available(*, deprecated, message: "This will be removed in KK 8.")
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
            EmojiKeyboardItem(emoji: emoji, style: style)
        })
    }
}
