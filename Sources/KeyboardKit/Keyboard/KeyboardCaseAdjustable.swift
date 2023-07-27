//
//  KeyboardCaseAdjustable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that can adapt
 to the keyboard casing of a certain text.

 This protocol is implemented by `String`.
 */
public protocol KeyboardCaseAdjustable {

    /**
     Get the capitalized value.
     */
    func capitalized() -> String

    /**
     Get the currently cased value.
     */
    func current() -> String

    /**
     Get the lowercased value.
     */
    func lowercased() -> String

    /**
     Get the uppercased value.
     */
    func uppercased() -> String
}

public extension KeyboardCaseAdjustable {

    /**
     Case-adjust the string for the provided `text`.

     This will match capitalization, uppercase and lowercase
     states in that order, meaning that a single, uppercased
     character is interpreted as capitalized, not uppercased.
     */
    func caseAdjusted(for text: String) -> String {
        if text.isCapitalized {
            return self.capitalized()
        }
        if text == text.uppercased() {
            return self.uppercased()
        }
        if text == text.lowercased() {
            return self.lowercased()
        }
        return self.current()
    }
}

extension String: KeyboardCaseAdjustable {

    public func capitalized() -> String {
        self.capitalized
    }

    public func current() -> String {
        self
    }
}
