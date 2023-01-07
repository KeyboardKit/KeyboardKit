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
 This view renders a system keyboard button.

 This view wraps the provided content and applies a style to
 it, which will make it mimic a native iOS keyboard button.
 
 Note that this view does not add any gestures or actions to
 the button. It only renders the button content. You can use
 a ``SystemKeyboardActionButton`` to get a full button, with
 gestures, pressed state etc.
 */
public struct SystemKeyboardButton<Content: View>: View {
    
    /**
     Create a system keyboard button.
     
     - Parameters:
       - content: The button content.
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
        content
            .systemKeyboardButtonStyle(style)
    }
}

struct SystemKeyboardButton_Previews: PreviewProvider {
    
    static let appearance = StandardKeyboardAppearance(
        keyboardContext: .preview)
    
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
