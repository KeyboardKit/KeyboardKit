//
//  KeyboardViewController+Buttons.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func button(for action: KeyboardAction, distribution: UIStackView.Distribution = .equalSpacing) -> UIView {
        if action == .none { return KeyboardSpacerView(width: 10) }
        let view = DemoButton.fromNib(owner: self)
        view.setup(with: action, in: self, distribution: distribution)
        return view
    }
    
    func buttonRows(for rows: KeyboardActionRows, distribution: UIStackView.Distribution) -> [KeyboardStackViewComponent] {
        var rows = rows.map {
            buttonRow(for: $0, distribution: distribution)
        }
        rows.insert(autocompleteToolbar, at: 0)
        return rows
    }
    
    func buttonRow(for row: KeyboardActionRow, distribution: UIStackView.Distribution) -> KeyboardStackViewComponent {
        KeyboardButtonRow(actions: row, distribution: distribution) {
            button(for: $0, distribution: distribution)
        }
    }
}
