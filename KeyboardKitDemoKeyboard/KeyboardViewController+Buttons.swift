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
        
        let insets = DemoButton.standardInsets(for: .current, screen: .main)
        
        view.setup(with: action, in: self, edgeInsets: insets, distribution: distribution)
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
        let height = KeyboardButtonRow.standardHeight(for: .current, screen: .main)
        return KeyboardButtonRow(height: height, actions: row, distribution: distribution) {
            button(for: $0, distribution: distribution)
        }
    }
}


public extension KeyboardStackViewComponent {
    
    /**
     The standard height of a vertical keyboard component in
     your `KeyboardInputViewController`'s `keyboardStackView`.
     
     This is the `total` component height, including any top
     and bottom padding that should be applied to every view
     in the row. This padding must be added WITHIN each view,
     since row spacing will create dead tap areas.
     */
    static func standardHeight(for device: UIDevice, screen: UIScreen) -> CGFloat {
        standardHeight(for: device.userInterfaceIdiom, bounds: screen.bounds)
    }
}

extension KeyboardStackViewComponent {
    
    static func standardHeight(for idiom: UIUserInterfaceIdiom, bounds: CGRect) -> CGFloat {
        bounds.isLandscape ? standardLandscapeHeight(for: idiom) : standardPortraitHeight(for: idiom)
    }
}

private extension KeyboardStackViewComponent {
    
    static func standardPortraitHeight(for idiom: UIUserInterfaceIdiom) -> CGFloat {
        idiom == .pad ? 65 : 54
    }
    
    static func standardLandscapeHeight(for idiom: UIUserInterfaceIdiom) -> CGFloat {
        idiom == .pad ? 84 : 38
    }
}

private extension KeyboardButtonRowComponent {
    
    static func standardPortraitInsets(for idiom: UIUserInterfaceIdiom) -> UIEdgeInsets {
        idiom == .pad ? .all(5) : .horizontal(3, vertical: 6)
    }
    
    static func standardLandscapeInsets(for idiom: UIUserInterfaceIdiom) -> UIEdgeInsets {
        idiom == .pad ? .all(5) : .horizontal(3, vertical: 4)
    }
}

private extension CGRect {
    
    var isLandscape: Bool { width > height }
}



public extension KeyboardButtonRowComponent {
    
    /**
     These standard insets is padding that should be applied
     INSIDE the row component to provide fake spaces between
     rows and items, while keeping the entire view tappable.
     
     Padding must be added INSIDE the views, since a spacing
     between items will create dead tap areas.
     
     For a keyboard button, it should thus push in the edges
     of the button body to fit these insets, then apply view
     gestures to its entire body.
     */
    static func standardInsets(for device: UIDevice, screen: UIScreen) -> UIEdgeInsets {
        standardInsets(for: device.userInterfaceIdiom, bounds: screen.bounds)
    }
}

extension KeyboardButtonRowComponent {
    
    static func standardInsets(for idiom: UIUserInterfaceIdiom, bounds: CGRect) -> UIEdgeInsets {
        bounds.isLandscape ? standardLandscapeInsets(for: idiom) : standardPortraitInsets(for: idiom)
    }
}


private extension UIEdgeInsets {
    
    static func all(_ all: CGFloat) -> UIEdgeInsets {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    static func horizontal(_ horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
