//
//  DemoKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 
 This demo keyboard has 24 buttons per page, which fits this
 demo app's two different grid sizes for portrait/landscape.
 It features one page of real emoji characters and four with
 image buttons, which are handled by the demo action handler.
 
 If you make any changes to this keyboard (which you should,
 play with it) the keyboard may get an uneven set of buttons,
 which the grid engine handles by adding empty dummy buttons
 at the very end.
 
 */
struct EmojiKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        self.bottomActions = EmojiKeyboard.bottomActions(
            leftmost: EmojiKeyboard.switchAction,
            for: viewController)
    }
    
    let actions: [KeyboardAction] = [
        .character("😀"), .character("😃"), .character("😄"), .character("😁"), .character("😆"), .character("😅"),
        .character("🐶"), .character("🐱"), .character("🐭"), .character("🐹"), .character("🐰"), .character("🦊"),
        .character("🍏"), .character("🍎"), .character("🍐"), .character("🍊"), .character("🍋"), .character("🍌"),
        .character("⚽️"), .character("🏀"), .character("🏈"), .character("⚾️"), .character("🎾"), .character("🏐"),
        
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
    ]
    
    let bottomActions: KeyboardActionRow
}

private extension EmojiKeyboard {
    
    static var switchAction: KeyboardAction {
        return .switchToKeyboard(.alphabetic(uppercased: false))
    }
}
