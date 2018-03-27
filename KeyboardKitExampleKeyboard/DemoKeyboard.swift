//
//  DemoKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This demo keyboard has 24 buttons per page, which fits this
 example application's two different grid sizes. If you make
 any changes to this keyboard (which you should - play!) the
 keyboard extension will an uneven distribution of character,
 emoji and image buttons.
 
 */

import KeyboardKit

class DemoKeyboard: Keyboard {

    init() {
        super.init(actions: [
            
            // Characters
            .character("a"), .character("b"), .character("c"), .character("d"), .character("e"), .character("f"),
            .character("g"), .character("h"), .character("i"), .character("j"), .character("k"), .character("l"),
            .character("m"), .character("n"), .character("o"), .character("p"), .character("q"), .character("r"),
            .character("t"), .character("u"), .character("v"), .character("w"), .character("x"), .character("y"),
            
            // Symbol Characters
            .character("∙"), .character("•"), .character("・"), .character("◦"), .character("●"), .character("○"),
            .character("▶︎"), .character("◀︎"), .character("▲"), .character("❄︎"), .character("⚙︎"), .character("✿"),
            .character("→"), .character("➔"), .character("➙"), .character("➝"), .character("➞"), .character("➨"),
            .character("♚"), .character("♛"), .character("♜"), .character("♝"), .character("♞"), .character("♟"),
            
            // Emoji Characters (real emojis)
            .character("😀"), .character("😃"), .character("😄"), .character("😁"), .character("😆"), .character("😅"),
            .character("🐶"), .character("🐱"), .character("🐭"), .character("🐹"), .character("🐰"), .character("🦊"),
            .character("🍏"), .character("🍎"), .character("🍐"), .character("🍊"), .character("🍋"), .character("🍌"),
            .character("⚽️"), .character("🏀"), .character("🏈"), .character("⚾️"), .character("🎾"), .character("🏐"),
            
            
            // Emojis (custom emoji images)
            .emoji(emojiName: "color", keyboardImageName: "color", imageName: "color"),
            .emoji(emojiName: "download", keyboardImageName: "download", imageName: "download"),
            .emoji(emojiName: "edit", keyboardImageName: "edit", imageName: "edit"),
            .emoji(emojiName: "cancel", keyboardImageName: "cancel", imageName: "cancel"),
            .emoji(emojiName: "bubble", keyboardImageName: "bubble", imageName: "bubble"),
            .emoji(emojiName: "box", keyboardImageName: "box", imageName: "box"),
            
            .emoji(emojiName: "favorite", keyboardImageName: "favorite", imageName: "favorite"),
            .emoji(emojiName: "globe", keyboardImageName: "globe", imageName: "globe"),
            .emoji(emojiName: "help", keyboardImageName: "help", imageName: "help"),
            .emoji(emojiName: "idea", keyboardImageName: "idea", imageName: "idea"),
            .emoji(emojiName: "image", keyboardImageName: "image", imageName: "image"),
            .emoji(emojiName: "info", keyboardImageName: "info", imageName: "info"),
            
            .emoji(emojiName: "label", keyboardImageName: "label", imageName: "label"),
            .emoji(emojiName: "mac", keyboardImageName: "mac", imageName: "mac"),
            .emoji(emojiName: "mail", keyboardImageName: "mail", imageName: "mail"),
            .emoji(emojiName: "monitor", keyboardImageName: "monitor", imageName: "monitor"),
            .emoji(emojiName: "note", keyboardImageName: "note", imageName: "note"),
            .emoji(emojiName: "refresh", keyboardImageName: "refresh", imageName: "refresh"),
            
            .emoji(emojiName: "rss", keyboardImageName: "rss", imageName: "rss"),
            .emoji(emojiName: "search", keyboardImageName: "search", imageName: "search"),
            .emoji(emojiName: "trash", keyboardImageName: "trash", imageName: "trash"),
            .emoji(emojiName: "video", keyboardImageName: "video", imageName: "video"),
            .emoji(emojiName: "warning", keyboardImageName: "warning", imageName: "warning"),
            .emoji(emojiName: "zoom", keyboardImageName: "zoom", imageName: "zoom")]
        )
    }
}
