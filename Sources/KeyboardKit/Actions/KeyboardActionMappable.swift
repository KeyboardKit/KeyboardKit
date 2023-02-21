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
 ``KeyboardAction/ReturnType``, which is then be mapped to a
 ``KeyboardAction/primary(_:)`` action by ``keyboardAction``.

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
        .primary(keyboardActionReturnType)
    }

    /**
     The corresponding ``KeyboardAction/ReturnType``.

     Return types that have no matching primary type will be
     mapped to ``KeyboardAction/ReturnType/custom(title:)``.
     */
    var keyboardActionReturnType: KeyboardAction.ReturnType {
        switch self {
        case .go: return .go
        case .google: return .custom(title: "Google")
        case .join: return .join
        case .next: return .custom(title: "next")
        case .route: return .custom(title: "route")
        case .search: return .search
        case .send: return .custom(title: "send")
        case .yahoo: return .custom(title: "Yahoo")
        case .done: return .done
        case .emergencyCall: return .custom(title: "emergencyCall")
        case .continue: return .custom(title: "continue")
        case .default: return .return
        @unknown default: return .custom(title: "unknown")
        }
    }
}
#endif
