//
//  NumericKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-13.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This keyboard mimicks the default numeric keyboard for iOS,
 just like `AlphabeticKeyboard` mimics the alphabetic one.
 
 */

import KeyboardKit

struct NumericKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        actions = type(of: self).actions(in: viewController)
    }
    
    let actions: KeyboardActionRows
}

private extension NumericKeyboard {
    
    static func actions(in viewController: KeyboardViewController) -> KeyboardActionRows {
        let leftmost = KeyboardAction.switchToKeyboard(.alphabetic(uppercased: false))
        return KeyboardActionRows
            .from(characters)
            .addingSideActions()
            .appending(bottomActions(leftmost: leftmost, for: viewController))
    }
    
    static var characters: [[String]] = [
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
        ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
        [".", ",", "?", "!", "´"]
    ]
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.switchToKeyboard(.symbolic), at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
}
