//
//  TextDelimiterProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to retrieve word and sentence delimiter.

 This protocol uses the delimiters in ``TextDelimiters`` and
 provides similar properties to its implementing types.

 This protocol is implemented by `String` and other types in
 this library. `UITextDocumentProxy` also has the non-static
 properties, but it doesn't implement the protocol. `String`
 adds more functionality on top of this functionality.
 */
public protocol TextDelimiterProvider {}

public extension TextDelimiterProvider {

    /// A list of western sentence delimiters.
    static var sentenceDelimiters: [String] { TextDelimiters.sentenceDelimiters }

    /// A list of western word delimiters.
    static var wordDelimiters: [String] { TextDelimiters.wordDelimiters }

    /// A list of western sentence delimiters.
    var sentenceDelimiters: [String] { TextDelimiters.sentenceDelimiters }

    /// A list of western word delimiters.
    var wordDelimiters: [String] { TextDelimiters.wordDelimiters }
}


// MARK: - String

extension String: TextDelimiterProvider {}

public extension String {

    /// Whether or not this is a western sentence delimiter.
    var isSentenceDelimiter: Bool {
        TextDelimiters.sentenceDelimiters.contains(self)
    }

    /// Whether or not this is a western word delimiter.
    var isWordDelimiter: Bool {
        TextDelimiters.wordDelimiters.contains(self)
    }
}


// MARK: - UITextDocumentProxy

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /// A list of western sentence delimiters.
    var sentenceDelimiters: [String] { TextDelimiters.sentenceDelimiters }

    /// A list of western word delimiters.
    var wordDelimiters: [String] { TextDelimiters.wordDelimiters }
}
#endif
