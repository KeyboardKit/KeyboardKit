//
//  SystemKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-15.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 These extensions are utils for the iPhone and iPad keyboard
 layout providers. They are temporary and should not be used
 when you subclass these classes, since I may remove them if
 they are no longer used, as I look for a better approach to
 dynamic layouts. These will be made internal in 6.0.

 Note that these properties just describe the input set, NOT
 the layout. For instance, Arabic uses 11-11-9, but does NOT
 share the same layout as LTR 11-11-9 keyboards.
 */
public extension SystemKeyboardLayoutProvider {

    /**
     The number of alphabetic inputs on each input row.
     */
    var alphabeticInputCount: [Int] {
        inputSetProvider.alphabeticInputSet.rows.map { $0.count }
    }

    /**
     Whether or not the current alphabetic input set has the
     provided number of inputs.
     */
    func hasAlphabeticInputCount(_ rows: [Int]) -> Bool {
        Array(alphabeticInputCount.prefix(rows.count)) == rows
    }

    /**
     Whether or not the current input set is alphabetic with
     the provided number of inputs.
     */
    func isAlphabeticWithInputCount(_ context: KeyboardContext, _ rows: [Int]) -> Bool {
        context.isAlphabetic && hasAlphabeticInputCount(rows)
    }
}


// MARK: - KeyboardContext Extension

private extension KeyboardContext {

    /// This property makes the context checks above shorter.
    var isAlphabetic: Bool {
        keyboardType.isAlphabetic
    }
}
