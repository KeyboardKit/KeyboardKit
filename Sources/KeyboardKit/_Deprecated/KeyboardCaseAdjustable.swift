//
//  KeyboardCaseAdjustable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
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

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public extension KeyboardCaseAdjustable {

    /**
     Get a case-adjusted value that matches the `text`.

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

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
extension String: KeyboardCaseAdjustable {

    public func capitalized() -> String {
        self.capitalized
    }

    public func current() -> String {
        self
    }
}
