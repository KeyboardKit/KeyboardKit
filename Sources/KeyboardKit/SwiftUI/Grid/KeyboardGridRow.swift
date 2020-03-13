//
//  EmojiGridRow.swift
//  GothEmoji
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 A `KeyboardGridRow` can be used to list a grid row inside a
 `KeyboardGrid`.

 This row supports a custom item `spacing`, which is used as
 spacing between row items. The `content` is used to provide
 the row with views to display within its `HStack`.
*/
@available(iOS 13.0, *)
public struct KeyboardGridRow<Content: View>: View {
    
    public init(spacing: CGFloat = 5, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    private let spacing: CGFloat
    private let content: () -> Content
    
    public var body: some View {
        HStack(spacing: spacing) { content() }
    }
}

@available(iOS 13.0, *)
struct KeyboardGridRow_Previews: PreviewProvider {
    
    static var image: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .scaledToFit()
    }
    
    static var previews: some View {
        KeyboardGridRow(spacing: 5) {
            image
            image
            image
            image
            image
            image
        }.background(Color.red)
    }
}
