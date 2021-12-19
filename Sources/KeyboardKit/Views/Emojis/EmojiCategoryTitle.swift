//
//  EmojiCategoryTitle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders a standard title for an emoji category.
 */
@available(iOS 14.0, *)
public struct EmojiCategoryTitle: View {
    
    public init(
        title: String) {
        self.title = title
    }
    
    private let title: String
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.footnote)
                .bold()
                .textCase(.uppercase)
                .opacity(0.4)
            Spacer()
        }.padding(.horizontal)
    }
}

@available(iOS 14.0, *)
struct EmojiCategoryTitle_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiCategoryTitle(title: "Hej")
    }
}
