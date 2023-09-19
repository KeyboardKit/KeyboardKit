//
//  View+KeyboardButtonStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /**
     Apply a keyboard button style to the view.

     - Parameters:
       - style: The style to apply.
     */
    func keyboardButtonStyle(_ style: KeyboardStyle.Button) -> some View {
        self.background(KeyboardButton.Body(style: style))
            .foregroundColor(style.foregroundColor)
            .font(style.font?.font)
    }
}

struct View_Button_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 20) {
            button(for: Text("a"), style: .preview1)
            button(for: Text("A"), style: .preview2)
            button(for: Image.keyboardGlobe, style: .preview1)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
    
    static func button<Content: View>(
        for content: Content,
        style: KeyboardStyle.Button
    ) -> some View {
        content
            .padding()
            .keyboardButtonStyle(style)
    }
}
