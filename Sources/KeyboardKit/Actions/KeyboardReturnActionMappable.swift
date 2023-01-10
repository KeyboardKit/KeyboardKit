//
//  KeyboardReturnActionMappable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by types that can return a
 ``KeyboardAction/PrimaryType``, which can then be mapped to
 a ``KeyboardAction/primary(_:)`` value.

 This protocol is implemented by `UIReturnKeyType` in `UIKit`.
 */
public protocol KeyboardReturnActionMappable {

    /**
     Get the return action type type to use.
     */
    var keyboardActionReturnType: KeyboardAction.PrimaryType { get }
}

public extension KeyboardReturnActionMappable {

    /**
     Get a primary keyboard action from the primary keyboard
     action type.
     */
    var keyboardAction: KeyboardAction {
        .primary(keyboardActionReturnType)
    }
}

#if os(iOS) || os(tvOS)
import UIKit

extension UIReturnKeyType: KeyboardReturnActionMappable {}

public extension UIReturnKeyType {

    /**
     The corresponding ``KeyboardAction/PrimaryType``.

     Return types that have no matching primary type will be
     mapped to ``KeyboardAction/PrimaryType/custom(title:)``.
     */
    var keyboardActionReturnType: KeyboardAction.PrimaryType {
        switch self {
        case .default: return .ok
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
        @unknown default: return .custom(title: "unknown")
        }
    }
}
#endif
