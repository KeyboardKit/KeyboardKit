//
//  AlphabeticKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks an alphabetic keyboard, and will
 use the input set provider in the view controller's context.
 */
struct AlphabeticKeyboard: DemoKeyboard {
    
    init(isUppercased: Bool, in viewController: KeyboardViewController) {
        let provider = viewController.context.inputSetProvider
        actions = AlphabeticKeyboard.actions(
            for: provider.alphabeticInputSet,
            isUppercased: isUppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension AlphabeticKeyboard {
    
    static func actions(
        for set: AlphabeticKeyboardInputSet,
        isUppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        let inputRows = set.inputRows
        let inputs = isUppercased ? inputRows.uppercased() : inputRows
        return KeyboardActionRows(characters: isUppercased ? inputs.uppercased() : inputs)
            .addingSideActions(isUppercased: isUppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static var switchAction: KeyboardAction {
        .keyboardType(.numeric)
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(isUppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(isUppercased ? .shift(currentState: .uppercased) : .shift(currentState: .lowercased), at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
}
