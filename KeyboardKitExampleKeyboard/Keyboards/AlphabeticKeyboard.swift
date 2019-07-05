//
//  AlphabeticKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 
 This demo keyboard mimicks the English, alphabetic keyboard.
 
 */
struct AlphabeticKeyboard: DemoKeyboard {
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = AlphabeticKeyboard.actions(
            uppercased: uppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension AlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        return KeyboardActionRows
            .from(characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static let characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    static func characters(uppercased: Bool) -> [[String]] {
        return uppercased ? characters.uppercased() : characters
    }
    
    static var switchAction: KeyboardAction {
        return .switchToKeyboard(.numeric)
    }
}

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
