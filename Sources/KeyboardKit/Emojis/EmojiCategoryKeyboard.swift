//
//  EmojiCategoryKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view lists all emojis from a selected category as well
 as a menu that lets the user select a new category.
 
 `TODO` The view should list a collection of emoji keyboards
 in an `HStack`, one for each category. However, I can't get
 it to scroll correctly.
 
 `TODO` This can't be previewed when it depends on a context.
 For some reason, the preview engine then crashes. Return to
 it after 4.0 to see if a cleaned up context solves this.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryKeyboard: View {
    
    public init(
        categories: [EmojiCategory] = EmojiCategory.all,
        selection: EmojiCategory? = nil,
        configuration: EmojiKeyboardConfiguration = .standardPhonePortrait,
        keyboardProvider: @escaping KeyboardProvider = Self.standardKeyboard,
        titleProvider: @escaping TitleProvider = Self.standardTitle,
        titleViewProvider: @escaping TitleViewProvider = Self.standardTitleView) {
        self.categories = categories.filter { $0.emojis.count > 0 }
        self.configuration = configuration
        self.initialSelection = selection
        self.keyboardProvider = keyboardProvider
        self.titleProvider = titleProvider
        self.titleViewProvider = titleViewProvider
    }
    
    public typealias KeyboardProvider = (EmojiCategory, EmojiKeyboardConfiguration) -> AnyView
    public typealias TitleProvider = (EmojiCategory) -> String
    public typealias TitleViewProvider = (EmojiCategory, String) -> AnyView
    
    @State private var isInitialized = false
    @State private var selection = EmojiCategory.smileys
    
    private let initialSelection: EmojiCategory?
    private let categories: [EmojiCategory]
    private let configuration: EmojiKeyboardConfiguration
    private let keyboardProvider: KeyboardProvider
    private let titleProvider: TitleProvider
    private let titleViewProvider: TitleViewProvider
    
    public var body: some View {
        VStack(spacing: 0) {
            titleViewProvider(selection, titleProvider(selection))
            ScrollView(.horizontal, showsIndicators: false) {
                keyboardProvider(selection, configuration)
            }
            EmojiCategoryKeyboardMenu(categories: categories, selection: $selection)
        }
        .onAppear(perform: initialize)
        .onDisappear(perform: saveCurrentCategory)
    }
}

@available(iOS 14.0, *)
public extension EmojiCategoryKeyboard {
    
    static func standardKeyboard(for category: EmojiCategory, configuration: EmojiKeyboardConfiguration) -> AnyView {
        AnyView(
            EmojiKeyboard(
                emojis: category.emojis,
                configuration: configuration)
                .padding(.horizontal)
        )
    }
    
    static func standardTitle(for category: EmojiCategory) -> String {
        category.title
    }
    
    static func standardTitleView(for category: EmojiCategory, title: String) -> AnyView {
        AnyView(HStack {
            Text(title).font(.footnote).bold().textCase(.uppercase).opacity(0.4)
            Spacer()
        }.padding(.horizontal))
    }
}

@available(iOS 14.0, *)
private extension EmojiCategoryKeyboard {
    
    var defaults: UserDefaults { .standard }
    var defaultsKey: String { "com.keyboardkit.EmojiCategoryKeyboard.category" }
    
    var persistedCategory: EmojiCategory {
        let name = defaults.string(forKey: defaultsKey) ?? ""
        return categories.first { $0.rawValue == name } ?? .smileys
    }
    
    func initialize() {
        if isInitialized { return }
        selection = initialSelection ?? persistedCategory
        isInitialized = true
    }
    
    func saveCurrentCategory() {
        defaults.set(selection.rawValue, forKey: defaultsKey)
    }
}

//@available(iOS 14.0, *)
//struct EmojiCategoryMenu_Keyboard: PreviewProvider {
//    static var previews: some View {
//        EmojiCategoryKeyboard(selection: .constant(.activities))
//    }
//}
