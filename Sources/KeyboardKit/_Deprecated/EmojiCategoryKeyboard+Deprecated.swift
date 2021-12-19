import SwiftUI

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard {
    
    @available(*, deprecated, renamed: "CategoryTitleProvider")
    typealias TitleProvider = CategoryTitleProvider
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    typealias KeyboardProvider = (EmojiCategory, EmojiKeyboardStyle) -> AnyView
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where CategoryTitleView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    typealias TitleViewProvider = (EmojiCategory, String) -> AnyView
}


@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == AnyView, CategoryTitleView == AnyView {
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        keyboardProvider: @escaping KeyboardProvider,
        titleProvider: @escaping TitleProvider = Self.standardCategoryTitle,
        titleViewProvider: @escaping TitleViewProvider = Self.standardTitleView) {
        self.init(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: selection,
            style: style,
            categoryTitle: titleProvider,
            categoryTitleView: titleViewProvider,
            categoryKeyboard: keyboardProvider)
    }
    
    @available(*, deprecated, message: "Use the generic initializers instead.")
    static func standardTitleView(for category: EmojiCategory, title: String) -> AnyView {
        AnyView(EmojiCategoryTitle(title: title))
    }
}
