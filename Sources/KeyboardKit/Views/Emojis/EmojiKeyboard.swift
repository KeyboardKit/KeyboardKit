//
//  EmojiKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to list an emoji collection using the
 provided configuration.
 
 You can customize the buttons in the grid by using a custom
 `buttonBuilder` in the initalizer. If you do not, init will
 use the static `standardButton` function.
 */
@available(iOS 14.0, *)
public struct EmojiKeyboard: View {
    
    /**
     Create an emoji keyboard.
     
     - Parameters:
       - emojis: The emojis to include in the menu.
       - style: The style to apply to the keyboard, by default `.standardPhonePortrait`.
       - buttonBuilder: A emoji keyboard button builder, by default `.standardButton`.
     */
    public init(
        emojis: [Emoji],
        style: EmojiKeyboardStyle = .standardPhonePortrait,
        buttonBuilder: @escaping ButtonBuilder = Self.standardButton) {
        let item = GridItem(.fixed(style.itemSize), spacing: style.verticalSpacing - 9)
        self.emojis = emojis.map { EmojiKeyboardItem(emoji: $0) }
        self.style = style
        self.rows = Array(repeating: item, count: style.rows)
        self.buttonBuilder = buttonBuilder
    }
    
    public typealias ButtonBuilder = (Emoji, EmojiKeyboardStyle) -> AnyView
    
    struct EmojiKeyboardItem: Identifiable {
        let id = UUID()
        let emoji: Emoji
    }
    
    private let buttonBuilder: ButtonBuilder
    private let style: EmojiKeyboardStyle
    private let emojis: [EmojiKeyboardItem]
    private let rows: [GridItem]
        
    public var body: some View {
        LazyHGrid(rows: rows, spacing: style.horizontalSpacing) {
            ForEach(emojis) {
                buttonBuilder($0.emoji, style)
            }
        }.frame(height: style.totalHeight)
    }
    
    
    // MARK: - Public Extensions (here to make preview work)
    
    /**
     This standard button builder will return an button that
     applies the keyboard actions of an `.emoji` action.
     */
    public static func standardButton(for emoji: Emoji, configuration: EmojiKeyboardStyle) -> AnyView {
        let handler = KeyboardInputViewController.shared.keyboardActionHandler
        let action = { handler.handle(.tap, on: .emoji(emoji)) }
        return AnyView(Button(action: action) {
            Text(emoji.char)
                .font(configuration.font)
        })
    }
}

@available(iOS 14.0, *)
struct EmojiKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal) {
            EmojiKeyboard(emojis: Array(Emoji.all.prefix(50)))
        }
    }
}
