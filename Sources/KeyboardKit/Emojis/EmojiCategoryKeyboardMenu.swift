//
//  EmojiCategoryKeyboardMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to list a set of emoji categories and
 let each category button toggle a category selection.
 
 The menu buttons are also surrounded by a keyboard switcher
 and a backspace.

 The menu currently has little customizations. We can extend
 it after 4.0, when everything resides in the main repo.
 
 `TODO` This can't be previewed when it depends on a context.
 For some reason, the preview engine then crashes. Return to
 it after 4.0 to see if a cleaned up context solves this.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboardMenu: View {
    
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        selection: Binding<EmojiCategory>,
        font: Font = .footnote,
        selectedColor: Color = Color.black.opacity(0.1)) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self._selection = selection
        self.font = font
        self.selectedColor = selectedColor
    }
    
    private let categories: [EmojiCategory]
    private let font: Font
    private let selectedColor: Color
    
    @State private var isInitialized = false
    @Binding private var selection: EmojiCategory
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    public var body: some View {
        HStack(spacing: 0) {
            Spacer()
            keyboardSwitchButton
            Spacer()
            buttonList
            Spacer()
            backspaceButton
            Spacer()
        }.font(font)
    }
    
    
    // MARK: - Private Extensions (here to make preview work)
    
    private var backspaceButton: some View {
        let action = KeyboardAction.backspace
        let handler = keyboardInputViewController.keyboardActionHandler
        let image = action.standardButtonImage
        return image.keyboardGestures(for: action, actionHandler: handler)
    }
    
    private var keyboardSwitchButton: some View {
        let action = KeyboardAction.keyboardType(.alphabetic(.lowercased))
        let handler = keyboardInputViewController.keyboardActionHandler
        let text = action.standardButtonText ?? ""
        return Text(text).keyboardGestures(for: action, actionHandler: handler)
    }
    
    private var buttonList: some View {
        ForEach(categories) {
            buttonListItem(for: $0)
        }
    }
    
    private func buttonListItem(for category: EmojiCategory) -> some View {
        let action = { selection = category }
        return Button(action: action) {
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
        EmojiCategoryKeyboardMenu(selection: .constant(.activities))
            .environmentObject(ObservableKeyboardContext.preview)
            .environmentObject(SecondaryInputCalloutContext.preview)
    }
}
