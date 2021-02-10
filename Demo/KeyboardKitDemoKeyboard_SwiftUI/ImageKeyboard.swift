//
//  ImageKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard is a custom view that is implemented for this
 demo kebyoard alone. It lists images in a grid and vary the
 number of columns depending on screen orientation.
 */
struct ImageKeyboard: View {
    
    var actionHandler: KeyboardActionHandler
    var appearance: KeyboardAppearance
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    var body: some View {
        VStack(spacing: 30) {
            KeyboardGrid(
                actions: actions,
                columns: columns,
                spacing: 20,
                buttonBuilder: imageButton)
            bottomRow.frame(height: 40)
        }.frame(height: 300)
    }
}

private extension ImageKeyboard {
    
    var columns: Int { isLandscape ? 8 : 6 }
    
    var isLandscape: Bool { context.deviceOrientation.isLandscape }
    
    var bottomRow: some View {
        button(for: .nextKeyboard)
    }
    
    func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance)
    }
    
    func imageButton(for action: KeyboardAction) -> some View {
        KeyboardImageButton(action: action)
            .keyboardGestures(for: action, actionHandler: actionHandler)
    }
}


private extension ImageKeyboard {
    
    var actions: [KeyboardAction] {
        [
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
    }
}
