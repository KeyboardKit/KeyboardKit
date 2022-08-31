//
//  SystemKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-15.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
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
     Whether or not to use an 10-10-8 keyboard layout, which
     is used by e.g. `Czech` iPhone keyboards.
     */
    func isTenTenEightAlphabetic(_ context: KeyboardContext) -> Bool {
        context.isAlphabetic && alphabeticInputCount.prefix(3) == [10, 10, 8]
    }

    /**
     Whether or not to use an 11-11-9 keyboard layout, which
     is used by e.g. `Belarusian` iPhone keyboards.
     */
    func isTwelveTwelveNineAlphabetic(_ context: KeyboardContext) -> Bool {
        context.isAlphabetic && alphabeticInputCount.prefix(3) == [12, 12, 9]
    }

    /**
     Whether or not to use an 11-11-9 keyboard layout, which
     is used by e.g. `Russian` iPhone keyboards.
     */
    func isElevenElevenNineAlphabetic(_ context: KeyboardContext) -> Bool {
        context.isAlphabetic && alphabeticInputCount.prefix(3) == [11, 11, 9]
    }

    /**
     Get the leading margin action for a certain action row.
     */
    func leadingMarginAction(for actions: KeyboardActions) -> KeyboardAction {
        marginAction(for: actions.first { $0.isInputAction })
    }

    /**
     Get the trailing margin action for a certain action row.
     */
    func trailingMarginAction(for actions: KeyboardActions) -> KeyboardAction {
        marginAction(for: actions.last { $0.isInputAction })
    }

    /**
     Get a margin action for a certain action, if any.

     This function returns `characterMargin` for `character`
     and `none` for all other action types.
     */
    func marginAction(for action: KeyboardAction?) -> KeyboardAction {
        guard let action = action else { return .none }
        switch action {
        case .character(let char): return .characterMargin(char)
        default: return .none
        }
    }
}


// MARK: - KeyboardContext Extension

private extension KeyboardContext {

    /// This property makes the context checks above shorter.
    var isAlphabetic: Bool {
        keyboardType.isAlphabetic
    }
}
