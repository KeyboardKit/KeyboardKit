//
//  SymbolicKeyboard.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks a symbolic keyboard and uses the
 current `keyboardInputProvider` to resolve its keys.
 */
struct SymbolicKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        let provider = viewController.context.keyboardInputProvider
        actions = type(of: self).actions(
            for: provider.symbolicInputSet,
            in: viewController)
    }
    
    let actions: KeyboardActionRows
}

private extension SymbolicKeyboard {
    
    static func actions(
        for set: SymbolicKeyboardInputSet,
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
        actions[2].insert(.keyboardType(.numeric), at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
}
