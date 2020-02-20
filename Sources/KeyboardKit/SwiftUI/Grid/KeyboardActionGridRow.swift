//
//  EmojiGridRow.swift
//  GothEmoji
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 A `KeyboardActionGridRow` can be used to list an action row
 inside a `KeyboardActionGrid`.

 The grid row supports a custom `spacing` which will be used
 to space out itms in the row.
 
 The provided `content` view builder will be used to provide
 the row with views to display within its `HStack`.
*/
@available(iOS 13.0, *)
public struct KeyboardActionGridRow<Content: View>: View {
    
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
struct KeyboardActionGridRow_Previews: PreviewProvider {
    
    static var image: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .scaledToFit()
    }
    
    static var previews: some View {
        KeyboardActionGridRow(spacing: 5) {
            image
            image
            image
            image
            image
            image
        }.background(Color.red)
    }
}
