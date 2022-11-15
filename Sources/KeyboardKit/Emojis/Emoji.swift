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
    
    /**
     Create an emoji instance, using a certain emoji `char`.
     */
    public init(_ char: String) {
        self.char = char
    }
   
    /**
     The character that can be used to display the emoji.
     */
    public let char: String
}

public extension Emoji {

    /**
     Get all emojis from all categories.
     */
    static var all: [Emoji] {
        EmojiCategory.all.flatMap { $0.emojis }
    }
}

public extension Emoji {
    
    /**
     The emoji's unique identifier.
     */
    var id: String { char }

    /**
     The emoji's unique unicode identifier.
     */
    var unicodeIdentifier: String? {
        char.applyingTransform(.toUnicodeName, reverse: false)
    }

    /**
     The emoji's unicode name.
     */
    var unicodeName: String? {
        unicodeIdentifier?
            .replacingOccurrences(of: "\\N", with: "")
            .replacingOccurrences(of: "{", with: "")
            .split(by: ["}"])
            .filter { !$0.isEmpty }
            .first?
            .capitalized()
    }
}

#if os(iOS)
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
#endif
