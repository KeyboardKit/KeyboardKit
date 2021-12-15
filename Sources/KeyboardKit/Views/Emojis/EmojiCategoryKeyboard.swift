//
//  EmojiCategoryKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public typealias TitleProvider = (EmojiCategory) -> String

@available(iOS 14.0, *)
public typealias EmojiKeyboardProvider<EmojiKeyboard: View> = (EmojiCategory, EmojiKeyboardStyle) -> EmojiKeyboard

@available(iOS 14.0, *)
public typealias EmojiTitleProvider<EmojiTitle: View> = (EmojiCategory, String) -> EmojiTitle

@available(iOS 14.0, *)
public func standardEmojiTitleView(for category: EmojiCategory, title: String) -> some View {
   HStack {
       Text(title).font(.footnote).bold().textCase(.uppercase).opacity(0.4)
       Spacer()
   }.padding(.horizontal)
}

@available(iOS 14.0, *)
public func standardEmojiKeyboard(for category: EmojiCategory, style: EmojiKeyboardStyle) -> some View {
        EmojiKeyboard(
            emojis: category.emojis,
            style: style,
            emojiButtonBuilder: standardEmojiButton)
            .padding(.horizontal)
}

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
    /**
     Create an emoji category keyboard.
     
     - Parameters:
       - categories: The categories to include in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to bind the buttons to.
       - selection: The current selection.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - selectedColor: The color of the selected category.
       - keyboardProvider: A keyboard provider, by default `.standardKeyboard`.
       - titleProvider: A title provider, by default `.standardTitle`.
       - titleViewProvider: A title view provider, by default `.standardTitleView`.
     */
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
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.style = style
        self.context = context
        self.initialSelection = selection
        self.keyboardProvider = keyboardProvider
        self.titleProvider = titleProvider
        self.titleViewProvider = titleViewProvider
    }
    @available(*, deprecated, message: "Use standardEmojiTitleView instead.")
    static func standardTitleView(for category: EmojiCategory, title: String) -> AnyView {
        AnyView(standardEmojiTitleView(for: category, title: title))
    }
    @available(*, deprecated, message: "Use standardEmojiKeyboard instead.")
    static func standardKeyboard(for category: EmojiCategory, style: EmojiKeyboardStyle) -> AnyView {
        AnyView(standardEmojiKeyboard(for: category, style: style))
    }
}
/**
 This keyboard lists all emojis from a selected category, as
 well as a menu that lets the user select a new category and
 change back to an alphabetic keyboard.
 
 As long as the view requires iOS 14, the extensions must be
 kept in the main struct body for the previews to compile.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboard<KeyboardView: View, TitleView: View>: View {
    
    private let initialSelection: EmojiCategory?
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let style: EmojiKeyboardStyle
    private let keyboardProvider: EmojiKeyboardProvider<KeyboardView>
    private let titleProvider: TitleProvider
    private let titleViewProvider: EmojiTitleProvider<TitleView>
    
    @State private var isInitialized = false
    @State private var selection = EmojiCategory.smileys
    /**
     Create an emoji category keyboard.
     
     - Parameters:
       - categories: The categories to include in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to bind the buttons to.
       - selection: The current selection.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - selectedColor: The color of the selected category.
       - keyboardProvider: A keyboard provider, by default `.standardKeyboard`.
       - titleProvider: A title provider, by default `.standardTitle`.
       - titleViewProvider: A title view provider, by default `.standardTitleView`.
     */
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        keyboardProvider: @escaping EmojiKeyboardProvider<KeyboardView>,
        titleProvider: @escaping TitleProvider = Self.standardTitle,
        titleViewProvider: @escaping EmojiTitleProvider<TitleView>) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.style = style
        self.context = context
        self.initialSelection = selection
        self.keyboardProvider = keyboardProvider
        self.titleProvider = titleProvider
        self.titleViewProvider = titleViewProvider
    }
    public var body: some View {
        VStack(spacing: 0) {
            titleViewProvider(selection, titleProvider(selection))
            ScrollView(.horizontal, showsIndicators: false) {
                keyboardProvider(selection, style)
            }
            EmojiCategoryKeyboardMenu(
                categories: categories,
                appearance: appearance,
                context: context,
                selection: $selection,
                style: style)
        }
        .onAppear(perform: initialize)
        .onDisappear(perform: saveCurrentCategory)
    }

    
    // MARK: - Public Static Builders
    
    
    public static func standardTitle(for category: EmojiCategory) -> String {
        category.title
    }
    

    // MARK: - Private Functions
    
    private var defaults: UserDefaults { .standard }
    private var defaultsKey: String { "com.keyboardkit.EmojiCategoryKeyboard.category" }
    
    private var persistedCategory: EmojiCategory {
        let name = defaults.string(forKey: defaultsKey) ?? ""
        return categories.first { $0.rawValue == name } ?? .smileys
    }
    
    private func initialize() {
        if isInitialized { return }
        selection = initialSelection ?? persistedCategory
        isInitialized = true
    }
    
    private func saveCurrentCategory() {
        defaults.set(selection.rawValue, forKey: defaultsKey)
    }
}

@available(iOS 14.0, *)
struct EmojiCategoryMenu_Keyboard: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryKeyboard(
            appearance: .preview,
            context: .preview,
            selection: .smileys,
            keyboardProvider: standardEmojiKeyboard,
            titleViewProvider: standardEmojiTitleView
        )
    }
}
