//
//  DemoNumericKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-07.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

class DemoNumericKeyboard: Keyboard {
    
    init(in viewController: KeyboardInputViewController) {
        let actions = type(of: self).numericActions
        super.init(actions: actions)
    }
    
    let preferredDistribution = UIStackView.Distribution.fillProportionally
    
    private static var numericActions: [KeyboardAction] {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        return numbers.map { KeyboardAction.character("\($0)")}
    }
}
