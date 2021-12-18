import SwiftUI

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    typealias KeyboardProvider = EmojiKeyboardProvider<AnyView>
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where TitleView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    typealias TitleViewProvider = EmojiTitleProvider<AnyView>
}


@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == AnyView, TitleView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        keyboardProvider: @escaping KeyboardProvider = Self.standardKeyboard,
        titleProvider: @escaping TitleProvider = Self.standardTitle,
        titleViewProvider: @escaping TitleViewProvider = Self.standardTitleView) {
        self.init(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: selection,
            style: style,
            titleProvider: titleProvider,
            titleViewProvider: titleViewProvider,
            keyboardProvider: keyboardProvider)
    }
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    static func standardTitleView(for category: EmojiCategory, title: String) -> AnyView {
        AnyView(standardEmojiTitleView(for: category, title: title))
    }
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    static func standardKeyboard(for category: EmojiCategory, style: EmojiKeyboardStyle) -> AnyView {
        AnyView(standardEmojiKeyboard(for: category, style: style))
    }
}
