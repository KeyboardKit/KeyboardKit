//
//  Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreTransferable
import SwiftUI
import UniformTypeIdentifiers

/// This type represents an emoji character and is used as a
/// namespace for emoji-related types and functionality.
public struct Emoji: Equatable, Codable, Hashable, Identifiable, Sendable {
    
    /// Create an emoji from a certain character.
    public init(_ char: Character) {
        self.char = String(char)
    }
    
    /// Create an emoji from a certain string.
    public init(_ char: String) {
        self.char = char
    }
    
    /// The emoji character string.
    public let char: String
}

public extension Emoji {
    
    /// The emoji's unique identifier.
    var id: String { char }
}

extension Emoji: Transferable {
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .emoji)
        ProxyRepresentation(exporting: \.char)
    }
}

public extension Array where Element == Emoji {

    /// Get the emoji at a certain index, if any.
    func emoji(at index: Int) -> Emoji? {
        let isValid = index >= 0 && index < count
        return isValid ? self[index] : nil
    }

    /// The first index of a certain emoji, if any.
    func firstIndex(of emoji: Emoji) -> Int? {
        firstIndex { $0 == emoji }
    }
}

#Preview {
    
    List {
        ForEach(Emoji.all) { emoji in
            HStack {
                HStack {
                    Text(emoji.char)
                    Spacer()
                    Text(emoji.localizedName(in: .init(identifier: "es")))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .truncationMode(.tail)
                }
                .lineLimit(1)
            }
        }
    }
}
