//
//  KeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Keyboard stack view components are "rows" that can be added
 to your `KeyboardInputViewController`'s `keyboardStackView`.
 Some examples are button rows, toolbars etc.
 
 `TODO` The standard height and padding properties are valid
 for views that don't implement this protocol as well, but I
 want to isolete these new features to UIKit in this part of
 the process, to avoid risking side-effects.
 */
public protocol KeyboardStackViewComponent: VerticalKeyboardComponent {}

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
        idiom == .pad ? 66 : 54
    }
    
    static func standardLandscapeHeight(for idiom: UIUserInterfaceIdiom) -> CGFloat {
        idiom == .pad ? 86 : 38
    }
}

private extension CGRect {
    
    var isLandscape: Bool { width > height }
}
