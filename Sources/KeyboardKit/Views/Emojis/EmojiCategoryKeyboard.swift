//
//  EmojiCategoryKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This keyboard lists all emojis from a selected category, as
 well as a menu that lets the user select a new category and
 change back to an alphabetic keyboard.
 
 As long as the view requires iOS 14, the extensions must be
 kept in the main struct body for the previews to compile.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboard: View {
    
    /**
     Create an emoji category keyboard.
     
     - Parameters:
       - categories: The categories to include in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to bind the buttons to.
       - selection: The current selection.
       - configuration: The emoji keyboard configuration to use.
       - selectedColor: The color of the selected category.
       - keyboardProvider: A keyboard provider, by default `.standardKeyboard`.
       - titleProvider: A title provider, by default `.standardTitle`.
       - titleViewProvider: A title view provider, by default `.standardTitleView`.
     */
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        configuration: EmojiKeyboardConfiguration = .standardPhonePortrait,
        keyboardProvider: @escaping KeyboardProvider = Self.standardKeyboard,
        titleProvider: @escaping TitleProvider = Self.standardTitle,
        titleViewProvider: @escaping TitleViewProvider = Self.standardTitleView) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.configuration = configuration
        self.context = context
        self.initialSelection = selection
        self.keyboardProvider = keyboardProvider
        self.titleProvider = titleProvider
        self.titleViewProvider = titleViewProvider
    }
    
    public typealias KeyboardProvider = (EmojiCategory, EmojiKeyboardConfiguration) -> AnyView
    public typealias TitleProvider = (EmojiCategory) -> String
    public typealias TitleViewProvider = (EmojiCategory, String) -> AnyView
    
    private let initialSelection: EmojiCategory?
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let configuration: EmojiKeyboardConfiguration
    private let keyboardProvider: KeyboardProvider
    private let titleProvider: TitleProvider
    private let titleViewProvider: TitleViewProvider
    
    @State private var isInitialized = false
    @State private var selection = EmojiCategory.smileys
    
    public var body: some View {
        VStack(spacing: 0) {
            titleViewProvider(selection, titleProvider(selection))
            ScrollView(.horizontal, showsIndicators: false) {
                keyboardProvider(selection, configuration)
            }
            EmojiCategoryKeyboardMenu(
                categories: categories,
                appearance: appearance,
                context: context,
                selection: $selection,
                configuration: configuration)
        }
        .onAppear(perform: initialize)
        .onDisappear(perform: saveCurrentCategory)
    }

    
    // MARK: - Public Static Builders
    
    public static func standardKeyboard(for category: EmojiCategory, configuration: EmojiKeyboardConfiguration) -> AnyView {
        AnyView(
            EmojiKeyboard(
                emojis: category.emojis,
                configuration: configuration)
                .padding(.horizontal)
        )
    }
    
    public static func standardTitle(for category: EmojiCategory) -> String {
        category.title
    }
    
    public static func standardTitleView(for category: EmojiCategory, title: String) -> AnyView {
        AnyView(HStack {
            Text(title).font(.footnote).bold().textCase(.uppercase).opacity(0.4)
            Spacer()
        }.padding(.horizontal))
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
            selection: .smileys)
            .keyboardPreview()
    }
}
