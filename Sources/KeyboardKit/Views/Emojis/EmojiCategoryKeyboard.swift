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
public struct EmojiCategoryKeyboard<KeyboardView: View, CategoryTitleView: View>: View {
    
    /**
     Create an emoji category keyboard.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
       - categoryTitleView: An emoji category title view builder.
       - categoryKeyboard: An emoji category keyboard view builder.
     */
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle,
        categoryTitleView: @escaping CategoryTitleViewProvider,
        categoryKeyboard: @escaping CategoryKeyboardProvider) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.style = style
        self.context = context
        self.initialSelection = selection
        self.categoryTitle = categoryTitle
        self.categoryTitleView = categoryTitleView
        self.categoryKeyboard = categoryKeyboard
    }
    
    private let initialSelection: EmojiCategory?
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let style: EmojiKeyboardStyle
    private let categoryTitle: CategoryTitleProvider
    private let categoryTitleView: CategoryTitleViewProvider
    private let categoryKeyboard: CategoryKeyboardProvider
    
    @State private var isInitialized = false
    @State private var selection = EmojiCategory.smileys
    
    
    // MARK: - Typealiases
    
    /**
     This is a typealias for a function that can be used for
     providing a title for an emoji category.
     */
    public typealias CategoryTitleProvider = (EmojiCategory) -> String
    
    /**
     This is a typealias for a function that can be used for
     providing a title view for an emoji category.
     */
    public typealias CategoryTitleViewProvider = (EmojiCategory, String, EmojiKeyboardStyle) -> CategoryTitleView

    /**
     This is a typealias for a function that can be used for
     providing a keyboard view for an emoji category.
     */
    public typealias CategoryKeyboardProvider = (EmojiCategory, EmojiKeyboardStyle) -> KeyboardView
    
    
    // MARK: - Public Static Builders
    
    /**
     This function returns the standard title for a category.
     */
    public static func standardCategoryTitle(for category: EmojiCategory) -> String {
        category.title
    }
    

    // MARK: - Private Functions
    
    private var defaults: UserDefaults { .standard }
    
    private let defaultsKey = "com.keyboardkit.EmojiCategoryKeyboard.category"
    
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
        guard isInitialized else { return }
        defaults.set(selection.rawValue, forKey: defaultsKey)
    }
    
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: style.verticalCategoryStackSpacing) {
            title
            keyboard
            menu
        }
        .onAppear(perform: initialize)
        .onChange(of: selection) { _ in saveCurrentCategory() }
    }
}


// MARK: - Private View Extensions

@available(iOS 14.0, *)
private extension EmojiCategoryKeyboard {

    var title: some View {
        categoryTitleView(selection, categoryTitle(selection), style)
    }
    
    var keyboard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            categoryKeyboard(selection, style)
        }.id(selection)
    }
    
    var menu: some View {
        EmojiCategoryKeyboardMenu(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: $selection,
            style: style)
    }
}


@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == EmojiKeyboard<EmojiKeyboardButton> {
    
    /**
     Create an emoji category keyboard, that uses a standard
     view for category keyboards.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
       - categoryTitleView: An emoji category title view builder.
     */
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle,
        categoryTitleView: @escaping CategoryTitleViewProvider) {
        self.init(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle,
            categoryTitleView: categoryTitleView,
            categoryKeyboard: Self.standardCategoryKeyboard)
    }
    
    /**
     The standard function to use to build an emoji category
     title view.
     */
    static func standardCategoryKeyboard(
        category: EmojiCategory,
        style: EmojiKeyboardStyle) -> EmojiKeyboard<EmojiKeyboardButton> {
        EmojiKeyboard(
            emojis: category.emojis,
            style: style)
    }
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where CategoryTitleView == EmojiCategoryTitle {
    
    /**
     Create an emoji category keyboard, that uses a standard
     view for category titles.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
       - categoryKeyboard: An emoji category keyboard view builder.
     */
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle,
        categoryKeyboard: @escaping CategoryKeyboardProvider) {
        self.init(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle,
            categoryTitleView: Self.standardCategoryTitleView,
            categoryKeyboard: categoryKeyboard)
    }
    
    /**
     The standard function to use to build an emoji category
     title view.
     */
    static func standardCategoryTitleView(
        category: EmojiCategory,
        title: String,
        style: EmojiKeyboardStyle) -> EmojiCategoryTitle {
        EmojiCategoryTitle(title: title, style: style)
    }
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard where KeyboardView == EmojiKeyboard<EmojiKeyboardButton>, CategoryTitleView == EmojiCategoryTitle {
    
    /**
     Create an emoji category keyboard, that uses a standard
     view for the category titles and keyboards.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - context: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
     */
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle) {
        self.init(
            categories: categories,
            appearance: appearance,
            context: context,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle,
            categoryTitleView: Self.standardCategoryTitleView,
            categoryKeyboard: Self.standardCategoryKeyboard)
    }
    
    /**
     The standard function to use to build an emoji category
     title view.
     */
    static func standardCategoryTitleView(
        category: EmojiCategory,
        title: String,
        style: EmojiKeyboardStyle) -> EmojiCategoryTitle {
        EmojiCategoryTitle(title: title, style: style)
    }
}
    
@available(iOS 14.0, *)
struct EmojiCategoryMenu_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryKeyboard(
            appearance: .preview,
            context: .preview,
            selection: .smileys)
    }
}
