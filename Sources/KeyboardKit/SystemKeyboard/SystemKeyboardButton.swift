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
 
 Note that this view only mimics the look of a system button.
 It does not add any gestures or actions and does not change
 style when it's tapped. If you apply gestures or wrap it in
 a `Button`, you can change style according to pressed state.
 
 Use ``SystemKeyboardActionButton`` to get a complete button,
 with gestures, pressed state handling etc.
 */
public struct SystemKeyboardButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - content: The content to present in the button.
       - style: The style to apply to the button
     */
    public init(
        content: Content,
        style: KeyboardButtonStyle
    ) {
        self.content = content
        self.style = style
    }
    
    private let content: Content
    private let style: KeyboardButtonStyle
    
    public var body: some View {
        content.systemKeyboardButtonStyle(style)
            .accessibility(addTraits: .isButton)
    }
}

struct SystemKeyboardButton_Previews: PreviewProvider {
    
    static let appearance = StandardKeyboardAppearance(
        context: .preview)
    
    static func previewButton<Content: View>(for content: Content, style: KeyboardButtonStyle) -> some View {
        SystemKeyboardButton(
            content: content
                .padding(.horizontal, 80)
                .padding(.vertical, 20),
            style: style)
    }
    
    static var previewImage: some View {
        Image("photo-forest", bundle: .keyboardKit)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    static var previewStack: some View {
        ScrollView {
            VStack(spacing: 20) {
                previewButton(for: Text("hello"), style: .preview1)
                previewButton(for: Text("HELLO"), style: .preview2)
                previewButton(for: SystemKeyboardButtonText(text: "🚀", action: .character("")), style: .preview1)
                previewButton(for: Image.keyboardGlobe, style: .preview2)
                
                previewButton(for: Text("input"), style: appearance.buttonStyle(for: .character(""), isPressed: false))
                previewButton(for: Text("input pressed"), style: appearance.buttonStyle(for: .character(""), isPressed: true))
                previewButton(for: Text("control"), style: appearance.buttonStyle(for: .backspace, isPressed: false))
                previewButton(for: Text("control pressed"), style: appearance.buttonStyle(for: .backspace, isPressed: true))
            }.padding(.top, 40)
        }
    }
    
    static var previews: some View {
        ZStack {
            previewImage
            previewStack
        }
    }
}
