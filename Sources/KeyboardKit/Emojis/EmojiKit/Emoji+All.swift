//
//  Emoji+All.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /// Get all available emojis from all categories.
    static var all: [Emoji] {
        EmojiCategory.all.flatMap {
            $0.emojis
        }
    }
}

public extension Collection where Element == Emoji {

    /// Get all available emojis from all categories.
    static var all: [Element] {
        Element.all
    }
}

#if os(iOS) || os(macOS)
#Preview {
    
    struct Preview: View {
        
        var columns = [GridItem(.adaptive(minimum: 30))]
        
        @State
        private var query = "grin"
        
        var emojis: [Emoji] {
            Emoji.all.matching(query)
        }
        
        var body: some View {
            NavigationView {
                #if os(macOS)
                EmptyView()
                #endif
                ScrollView(.vertical) {
                    LazyVGrid(
                        columns: columns,
                        spacing: 10
                    ) {
                        ForEach(emojis) { emoji in
                            Text(emoji.char)
                                .font(.title)
                        }
                    }
                    .padding()
                }
                .prefersSearchable(with: $query)
            }
        }
    }
    
    return Preview()
}

private extension View {
    
    @ViewBuilder
    func prefersSearchable(with query: Binding<String>) -> some View {
        if #available(iOS 15.0, macOS 12.0, *) {
            searchable(text: query)
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif
