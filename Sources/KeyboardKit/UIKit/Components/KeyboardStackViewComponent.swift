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
     Get the standard height of vertical keyboard components
     that are placed to your `KeyboardInputViewController`'s
     `keyboardStackView` (i.e. keyboard "rows").
     
     This is the `total` height of this component, including
     any top and bottom padding that should be added to your
     buttons. This padding must be added INSIDE the button's
     view, since we do not want any spacing between our rows
     that can create dead tap areas.
     */
    static func standardHeight(for device: UIDevice, screen: UIScreen) -> CGFloat {
        standardHeight(for: device.userInterfaceIdiom, bounds: screen.bounds)
    }
    
    /**
     The standard row insets of vertical keyboard components
     are insets that should be applied within the row view.
     
     The reason for this is that keyboard stack views should
     not have any row spacings, since that would create dead
     tap areas. Instead, it's up to each button to apply the
     correct padding within itself and apply gesture support
     to its entire body.
     */
    static func standardRowPadding(for device: UIDevice, screen: UIScreen) -> CGFloat {
        standardRowPadding(for: device.userInterfaceIdiom, bounds: screen.bounds)
    }
}

extension KeyboardStackViewComponent {
    
    static func standardHeight(for idiom: UIUserInterfaceIdiom, bounds: CGRect) -> CGFloat {
        bounds.isLandscape ? standardLandscapeHeight(for: idiom) : standardPortraitHeight(for: idiom)
    }
    
    static func standardRowPadding(for idiom: UIUserInterfaceIdiom, bounds: CGRect) -> CGFloat {
        idiom == .pad ? 5 : 3
    }
}

private extension KeyboardStackViewComponent {
    
    static func standardLandscapeHeight(for idiom: UIUserInterfaceIdiom) -> CGFloat {
        idiom == .pad ? 84 : 42
    }
    
    static func standardPortraitHeight(for idiom: UIUserInterfaceIdiom) -> CGFloat {
        idiom == .pad ? 65 : 48
    }
}

private extension CGRect {
    
    var isLandscape: Bool { width > height }
}
