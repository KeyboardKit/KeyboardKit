//
//  AlphabeticKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the English alphabetic phone keyboard.
 It does not adjust itself to other device types or language
 layouts, since its intention isn't to be a fully functional
 keyboard, but rather to show you how to make keyboards that
 behaves like the system keyboards.
 
 */

import KeyboardKit

struct AlphabeticKeyboard: DemoKeyboard {
    
    init(
        uppercased: Bool,
        in viewController: KeyboardViewController) {
        actions = type(of: self).actions(in: viewController, uppercased: uppercased)
    }

    let actions: KeyboardActionRows
    
    static private(set) var characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
}


// MARK: - Actions

private extension AlphabeticKeyboard {
    
    static func actions(
        in viewController: KeyboardViewController,
        uppercased: Bool) -> KeyboardActionRows {
        return characters(uppercased: uppercased)
            .mappedToActions()
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: .switchToNumericKeyboard, for: viewController))
    }
}


// MARK: - Characters

private extension AlphabeticKeyboard {
    
    static func characters(uppercased: Bool) -> [[String]] {
        return uppercased ? characters.uppercased() : characters
    }
}


// MARK: - Action Extensions

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(uppercased ? .shiftDown : .shift, at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
}
