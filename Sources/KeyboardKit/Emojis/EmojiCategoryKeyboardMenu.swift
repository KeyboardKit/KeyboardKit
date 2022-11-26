//
//  EmojiCategoryKeyboardMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This menu can be used to list a set of emoji categories and
 let each category button toggle a category selection.
 
 The menu buttons are also surrounded by a keyboard switcher
 and a backspace.
 
 As long as the view requires iOS 14, the extensions must be
 kept in the main struct body for the previews to compile.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboardMenu: View {
    
    /**
     Create an emoji category keyboard menu.
     
     - Parameters:
       - categories: The categories to include in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to bind the buttons to.
       - selection: The current selection.
       - style: The style to apply to the menu.
       - actionHandler: The action handler to use, by default the shared one.
     */
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: Binding<EmojiCategory>,
        style: EmojiKeyboardStyle,
        actionHandler: KeyboardActionHandler = KeyboardInputViewController.shared.keyboardActionHandler
    ) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.context = context
        self._selection = selection
        self.style = style
        self.actionHandler = actionHandler
    }
    
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let style: EmojiKeyboardStyle
    private let actionHandler: KeyboardActionHandler
    
    @State private var isInitialized = false
    @Binding private var selection: EmojiCategory
        
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            keyboardSwitchButton.font(style.systemFont)
            Spacer()
            buttonList.font(style.categoryFont)
            Spacer()
            backspaceButton.font(style.systemFont)
            Spacer()
        }
    }
    
    
    // MARK: - Private Extensions
    
    private var backspaceButton: some View {
        let action = KeyboardAction.backspace
        let image = appearance.buttonImage(for: action)
        return image.keyboardGestures(
            for: action,
            actionHandler: actionHandler).scaledToFill()
    }
    
    private var keyboardSwitchButton: some View {
        let action = KeyboardAction.keyboardType(.alphabetic(.lowercased))
        let text = appearance.buttonText(for: action) ?? "ABC"
        return Text(text).keyboardGestures(
            for: action,
            actionHandler: actionHandler).scaledToFill()
    }
    
    private var buttonList: some View {
        ForEach(categories) {
            buttonListItem(for: $0)
        }
    }
    
    private func buttonListItem(for category: EmojiCategory) -> some View {
        Button(action: { selection = category }, label: {
            Text(category.fallbackDisplayEmoji.char)
                .padding(3)
                .background(selection == category ? style.selectedCategoryColor : Color.clear)
                .clipShape(Circle())
        })
    }
}

@available(iOS 14.0, *)
struct EmojiCategoryKeyboardMenu_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryKeyboardMenu(
            appearance: .preview,
            context: .preview,
            selection: .constant(.activities),
            style: .standardPhonePortrait)
    }
}
#endif
