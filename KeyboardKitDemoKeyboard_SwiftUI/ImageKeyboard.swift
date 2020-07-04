//
//  ImageKeyboard.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-07-05.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit
import KeyboardKitSwiftUI
import UIKit

struct ImageKeyboard: View {
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    private let actions: [KeyboardAction] = [
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
    
    var body: some View {
        VStack {
            instructions
            grid
        }
    }
}

private extension ImageKeyboard {
    
    var grid: some View {
        KeyboardGrid(actions: actions, columns: 6) {
            self.image(for: $0)
                .resizable()
                .scaledToFit()
                .padding(10)
                .keyboardAction($0, context: self.context)
        }
    }
    
    var instructions: some View {
        Text("Tap an image to copy it, long press to save")
            .font(.footnote)
            .padding()
    }
    
    func image(for action: KeyboardAction) -> Image {
        switch action {
        case .image(_, let keyboardImageName, _): return image(named: keyboardImageName)
        default: return image(named: "")
        }
    }
    
    func image(named name: String) -> Image {
        guard let image = UIImage(named: name) else { return Image("") }
        return Image(uiImage: image)
    }
}

struct ImageKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ImageKeyboard()
    }
}
