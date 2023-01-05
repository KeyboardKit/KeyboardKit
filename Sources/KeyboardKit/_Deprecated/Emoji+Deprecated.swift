import SwiftUI

#if os(iOS) || os(tvOS)
@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiCategoryKeyboard {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle,
        categoryTitleView: @escaping CategoryTitleViewProvider
    ) {
        self.init(
            categories: categories,
            appearance: appearance,
            keyboardContext: context,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle,
            categoryTitleView: categoryTitleView
        )
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiCategoryKeyboard where CategoryTitleView == EmojiCategoryTitle {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle
    ) {
        self.init(
            categories: categories,
            appearance: appearance,
            keyboardContext: context,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle
        )
    }
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboardMenu {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: Binding<EmojiCategory>,
        style: EmojiKeyboardStyle,
        actionHandler: KeyboardActionHandler = KeyboardInputViewController.shared.keyboardActionHandler
    ) {
        self.init(
            categories: categories,
            appearance: appearance,
            keyboardContext: context,
            selection: selection,
            style: style,
            actionHandler: actionHandler
        )
    }
}
#endif
