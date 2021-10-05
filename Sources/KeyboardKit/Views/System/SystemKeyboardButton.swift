//
//  SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

import SwiftUI

/**
 This view mimics the buttons that are used in an iOS system
 keyboard. It wraps the provided content and applies a style.
 
 Note that this view only mimics the look of a system button
 for the provided `content` and `style`. It does not add any
 gestures or actions. If you do apply gestures or wrap it in
 a `Button`, change the `style` according to press state etc.
 
 If you want to create a more complete and functional button,
 `SystemKeyboardActionButton` will create a fully functional
 and contextually correct button for the provided `action`.
 */
public struct SystemKeyboardButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - content: The content to present in the button.
       - style: The style to apply to the button.
     */
    public init(
        content: Content,
        style: SystemKeyboardButtonStyle) {
        self.content = content
        self.style = style
    }
    
    private let content: Content
    private let style: SystemKeyboardButtonStyle
    
    public var body: some View {
        content.systemKeyboardButtonStyle(style)
            .accessibility(addTraits: .isButton)
    }
}

struct SystemKeyboardButton_Previews: PreviewProvider {
    
    static func button<Content: View>(for content: Content, style: SystemKeyboardButtonStyle) -> some View {
        SystemKeyboardButton(
            content: content.frame(width: 60, height: 60),
            style: style)
    }
    
    static var previews: some View {
        VStack {
            button(for: Text("hej"), style: .preview1)
            button(for: Text("HEJ"), style: .preview2)
            button(for: SystemKeyboardButtonText(text: "hej", action: .character("")), style: .preview1)
            button(for: Image.keyboardGlobe, style: .preview2)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
    }
}
