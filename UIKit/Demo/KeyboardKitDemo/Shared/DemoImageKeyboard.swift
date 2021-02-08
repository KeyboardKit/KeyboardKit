//
//  DemoImageKeyboard.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit


/**
 This protocol is used by the demo image keyboards, to setup
 the available images to display.
 
 This class is shared between the demo app and all keyboards.
 */
protocol DemoImageKeyboard {}

extension DemoImageKeyboard {
    
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
