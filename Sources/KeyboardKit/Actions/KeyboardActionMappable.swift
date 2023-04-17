//
//  KeyboardActionMappable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by types that can return a
 ``KeyboardAction``.

 This protocol is implemented by `UIReturnKeyType` in `UIKit`.
 */
public protocol KeyboardActionMappable {

    /**
     The keyboard action that this type maps to.
     */
    var keyboardAction: KeyboardAction { get }
}


#if os(iOS) || os(tvOS)
import UIKit

extension UIReturnKeyType: KeyboardActionMappable {}

public extension UIReturnKeyType {

    /**
     The keyboard action that this return key type maps to.
     */
    var keyboardAction: KeyboardAction {
        .primary(keyboardReturnKeyType)
    }
}
#endif
