//
//  EmojiCategoryKeyboardMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This menu can be used to list a set of emoji categories and
 let each category button toggle a category selection.
 
 The menu buttons are also surrounded by a keyboard switcher
 and a backspace.
 
 As long as the view requires iOS 14, the extensions must be
 kept in the main struct body for the previews to compile.
 */
public struct EmojiCategoryKeyboardMenu: View {
    
    /**
     Create an emoji category keyboard menu.
     
     - Parameters:
       - selection: The current selection.
       - categories: The categories to include in the menu.
       - keyboardContext: The context to bind the buttons to.
       - actionHandler: The action handler to use, by default the shared one.
       - appearance: The appearance to apply to the menu.
       - style: The style to apply to the menu.
     */
    public init(
        selection: Binding<EmojiCategory>,
        categories: [EmojiCategory] = EmojiCategory.all,
        keyboardContext: KeyboardContext,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        style: EmojiKeyboardStyle
    ) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.keyboardContext = keyboardContext
        self.actionHandler = actionHandler
        self.appearance = appearance
        self._selection = selection
        self.style = style
    }

    @Binding
    private var selection: EmojiCategory
    
    private let categories: [EmojiCategory]
    private let keyboardContext: KeyboardContext
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let style: EmojiKeyboardStyle
    
    @State
    private var isInitialized = false
        
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
            actionHandler: actionHandler,
            calloutContext: nil
        ).scaledToFill()
    }
    
    private var keyboardSwitchButton: some View {
        let action = KeyboardAction.keyboardType(.alphabetic(.lowercased))
        let text = appearance.buttonText(for: action) ?? "ABC"
        return Text(text).keyboardGestures(
            for: action,
            actionHandler: actionHandler,
            calloutContext: nil
        ).scaledToFill()
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
        }).buttonStyle(.plain)
    }
}

struct EmojiCategoryKeyboardMenu_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryKeyboardMenu(
            selection: .constant(.activities),
            categories: .all,
            keyboardContext: .preview,
            actionHandler: .preview,
            appearance: .preview,
            style: .standardPhonePortrait
        )
    }
}
