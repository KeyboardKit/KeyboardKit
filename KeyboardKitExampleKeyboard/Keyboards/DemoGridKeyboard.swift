//
//  DemoKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This demo keyboard has 24 buttons per page, which fits this
 example application's two different grid sizes for portrait
 and landscape mode. If you make any changes to the keyboard
 (which you should - play!) the extension will get an uneven
 distribution of character, emoji and image buttons.
 
 */

import KeyboardKit

class DemoGridKeyboard: Keyboard {

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
            .image(description: "color", keyboardImageName: "color", imageName: "color"),
            .image(description: "download", keyboardImageName: "download", imageName: "download"),
            .image(description: "edit", keyboardImageName: "edit", imageName: "edit"),
            .image(description: "cancel", keyboardImageName: "cancel", imageName: "cancel"),
            .image(description: "bubble", keyboardImageName: "bubble", imageName: "bubble"),
            .image(description: "box", keyboardImageName: "box", imageName: "box"),
            
            .image(description: "favorite", keyboardImageName: "favorite", imageName: "favorite"),
            .image(description: "globe", keyboardImageName: "globe", imageName: "globe"),
            .image(description: "help", keyboardImageName: "help", imageName: "help"),
            .image(description: "idea", keyboardImageName: "idea", imageName: "idea"),
            .image(description: "image", keyboardImageName: "image", imageName: "image"),
            .image(description: "info", keyboardImageName: "info", imageName: "info"),
            
            .image(description: "label", keyboardImageName: "label", imageName: "label"),
            .image(description: "mac", keyboardImageName: "mac", imageName: "mac"),
            .image(description: "mail", keyboardImageName: "mail", imageName: "mail"),
            .image(description: "monitor", keyboardImageName: "monitor", imageName: "monitor"),
            .image(description: "note", keyboardImageName: "note", imageName: "note"),
            .image(description: "refresh", keyboardImageName: "refresh", imageName: "refresh"),
            
            .image(description: "rss", keyboardImageName: "rss", imageName: "rss"),
            .image(description: "search", keyboardImageName: "search", imageName: "search"),
            .image(description: "trash", keyboardImageName: "trash", imageName: "trash"),
            .image(description: "video", keyboardImageName: "video", imageName: "video"),
            .image(description: "warning", keyboardImageName: "warning", imageName: "warning"),
            .image(description: "zoom", keyboardImageName: "zoom", imageName: "zoom")
        ])
    }
}
