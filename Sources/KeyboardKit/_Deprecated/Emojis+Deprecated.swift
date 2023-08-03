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
