//
//  DemoNumericKeyboard.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-05-07.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

struct DemoNumericKeyboard {
    
    init() {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        actions = numbers.map { KeyboardAction.character("\($0)")}
    }
    
    let actions: [KeyboardAction]
    
    let preferredDistribution = UIStackView.Distribution.fillProportionally
}
