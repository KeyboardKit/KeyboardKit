//
//  EmojiCategoryKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This keyboard lists all emojis from a selected category, as
 well as a menu that lets the user select a new category and
 change back to an alphabetic keyboard.
 
 As long as the view requires iOS 14, the extensions must be
 kept in the main struct body for the previews to compile.
 */
@available(iOS 14.0, tvOS 14.0, *)
public struct EmojiCategoryKeyboard<CategoryTitleView: View>: View {
    
    /**
     Create an emoji category keyboard.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - keyboardContext: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
       - categoryTitleView: An emoji category title view builder.
     */
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle,
        categoryTitleView: @escaping CategoryTitleViewProvider
    ) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.appearance = appearance
        self.keyboardContext = keyboardContext
        self.initialSelection = selection
        self.style = style
        self.categoryTitle = categoryTitle
        self.categoryTitleView = categoryTitleView
    }
    
    private let categories: [EmojiCategory]
    private let appearance: KeyboardAppearance
    private let keyboardContext: KeyboardContext
    private let initialSelection: EmojiCategory?
    private let style: EmojiKeyboardStyle
    private let categoryTitle: CategoryTitleProvider
    private let categoryTitleView: CategoryTitleViewProvider
    
    @State
    private var isInitialized = false

    @State
    private var isSearchFocused = false

    @State
    private var query = ""

    @State
    private var selection = EmojiCategory.smileys
    
    
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

@available(iOS 14.0, tvOS 14.0, *)
private extension EmojiCategoryKeyboard {

    var title: some View {
        categoryTitleView(selection, categoryTitle(selection), style)
            .padding(.horizontal)
    }

    var keyboard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            EmojiKeyboard(
                emojis: selection.emojis.matching(query, for: keyboardContext.locale),
                style: style)
        }.id(selection)
    }
    
    var menu: some View {
        EmojiCategoryKeyboardMenu(
            categories: categories,
            appearance: appearance,
            keyboardContext: keyboardContext,
            selection: $selection,
            style: style
        )
    }

    var searchField: some View {
        KeyboardTextField(
            KKL10n.searchEmoji.text(for: keyboardContext.locale),
            text: $query,
            hasFocus: $isSearchFocused,
            resignOnReturn: true,
            config: { $0.borderStyle = .roundedRect }
        ).padding([.horizontal, .bottom])
    }
}

@available(iOS 14.0, tvOS 14.0, *)
public extension EmojiCategoryKeyboard where CategoryTitleView == EmojiCategoryTitle {
    
    /**
     Create an emoji category keyboard, that uses a standard
     view for category titles.
     
     - Parameters:
       - categories: The categories to show in the menu.
       - appearance: The appearance to apply to the menu.
       - keyboardContext: The context to use when rendering the view.
       - selection: The currently selected category.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - categoryTitle: A category title provider, by default `.standardCategoryTitle`.
     */
    init(
        categories: [EmojiCategory] = EmojiCategory.all,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext,
        selection: EmojiCategory? = nil,
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        categoryTitle: @escaping CategoryTitleProvider = standardCategoryTitle
    ) {
        self.init(
            categories: categories,
            appearance: appearance,
            keyboardContext: keyboardContext,
            selection: selection,
            style: style,
            categoryTitle: categoryTitle,
            categoryTitleView: Self.standardCategoryTitleView)
    }
    
    /**
     The standard function to use to build an emoji category
     title view.
     */
    static func standardCategoryTitleView(
        category: EmojiCategory,
        title: String,
        style: EmojiKeyboardStyle
    ) -> EmojiCategoryTitle {
        EmojiCategoryTitle(title: title, style: style)
    }
}

@available(iOS 14.0, tvOS 14.0, *)
private extension EmojiCategoryKeyboard {

    /**
     The standard action handler to use to handle the emojis.
     */
    var standardKeyboardActionHandler: KeyboardActionHandler {
        KeyboardInputViewController.shared.keyboardActionHandler
    }
}

@available(iOS 14.0, tvOS 14.0, *)
struct EmojiCategoryKeyboard_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryKeyboard(
            appearance: .preview,
            keyboardContext: .preview,
            selection: .smileys)
    }
}
#endif
