//
//  EmojiCategoryTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-19.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders a standard title for an emoji category.
 */
public struct EmojiCategoryTitle: View {
    
    public init(
        title: String,
        style: EmojiKeyboardStyle
    ) {
        self.title = title
        self.style = style
    }
    
    private let title: String
    private let style: EmojiKeyboardStyle
    
    public var body: some View {
        HStack {
            Text(title)
                .font(style.categoryFont)
                .bold()
                .textCase(.uppercase)
                .opacity(0.4)
            Spacer()
        }
    }
}

struct EmojiCategoryTitle_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryTitle(
            title: "Hej",
            style: .standardPhonePortrait)
    }
}
