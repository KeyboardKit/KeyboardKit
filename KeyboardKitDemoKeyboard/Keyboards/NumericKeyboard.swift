//
//  NumericKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks a numeric keyboard, and will use
 the input set provider in the view controller's context.
 */
struct NumericKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        let provider = viewController.context.inputSetProvider
        actions = type(of: self).actions(
            for: provider.numericInputSet,
            in: viewController)
    }
    
    let actions: KeyboardActionRows
}

private extension NumericKeyboard {
    
    static func actions(
        for set: NumericKeyboardInputSet,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows(characters: set.inputRows)
            .addingSideActions()
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static var switchAction: KeyboardAction {
        .keyboardType(.alphabetic(.lowercased))
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.keyboardType(.symbolic), at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
}
