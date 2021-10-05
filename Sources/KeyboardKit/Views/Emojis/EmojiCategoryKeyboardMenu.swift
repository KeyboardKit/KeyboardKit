//
//  EmojiCategoryKeyboardMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboardMenu: View {
    
    /**
     Create an emoji category keyboard menu.
     
     - Parameters:
       - categories: The categories to include in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to bind the buttons to.
       - selection: The current selection.
       - configuration: The emoji keyboard configuration to use.
       - selectedColor: The color of the selected category.
     */
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: Binding<EmojiCategory>,
        configuration: EmojiKeyboardConfiguration,
        selectedColor: Color = Color.black.opacity(0.1)) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.context = context
        self._selection = selection
        self.configuration = configuration
        self.selectedColor = selectedColor
    }
    
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let configuration: EmojiKeyboardConfiguration
    private let selectedColor: Color
    
    @State private var isInitialized = false
    @Binding private var selection: EmojiCategory
        
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            keyboardSwitchButton.font(configuration.systemFont)
            Spacer()
            buttonList.font(configuration.categoryFont)
            Spacer()
            backspaceButton.font(configuration.systemFont)
            Spacer()
        }
    }
    
    
    // MARK: - Private Extensions
    
    private var backspaceButton: some View {
        let action = KeyboardAction.backspace
        let handler = KeyboardInputViewController.shared.keyboardActionHandler
        let image = appearance.buttonImage(for: action)
        return image.keyboardGestures(
            for: action,
            context: context,
            actionHandler: handler).scaledToFill()
    }
    
    private var keyboardSwitchButton: some View {
        let action = KeyboardAction.keyboardType(.alphabetic(.lowercased))
        let handler = KeyboardInputViewController.shared.keyboardActionHandler
        let text = appearance.buttonText(for: action) ?? "ABC"
        return Text(text).keyboardGestures(
            for: action,
            context: context,
            actionHandler: handler).scaledToFill()
    }
    
    private var buttonList: some View {
        ForEach(categories) {
            buttonListItem(for: $0)
        }
    }
    
    private func buttonListItem(for category: EmojiCategory) -> some View {
        Button(action: { selection = category }) {
            Text(category.fallbackDisplayEmoji.char)
                .padding(6)
                .background(selection == category ? selectedColor : Color.clear)
                .clipShape(Circle())
        }
    }
}

@available(iOS 14.0, *)
struct EmojiCategoryKeyboardMenu_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCategoryKeyboardMenu(
            appearance: .preview,
            context: .preview,
            selection: .constant(.activities),
            configuration: .standardPhonePortrait)
            .keyboardPreview()
    }
}
