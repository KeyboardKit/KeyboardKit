//
//  Emoji.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct is just a wrapper around a single character. It
 can be used to get a little bit of type safety, and to work
 more structured with emojis.
 */
public struct Emoji: Equatable, Codable, Identifiable {
    
    public init(_ char: String) {
        self.char = char
    }
   
    /**
     The character that can be used to display the emoji.
     */
    public let char: String
    
     /**
      The unique id of the emoji.
      */
    public var id: String { char }
}

public extension Emoji {
    
    /**
     Get all emojis from all categories.
     */
    static var all: [Emoji] {
        EmojiCategory.all.flatMap { $0.emojis }
    }
}

@available(iOS 14.0, *)
struct Emoji_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 30, maximum: 30))], spacing: 20) {
                ForEach(Emoji.all) {
                    Text($0.char)
                }
            }.padding()
        }
    }
}
