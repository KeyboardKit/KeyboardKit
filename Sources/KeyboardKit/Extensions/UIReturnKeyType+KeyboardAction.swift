//
//  UIReturnKeyType+KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-06-23.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UIReturnKeyType {

    /**
     The corresponding ``KeyboardAction``.

     Return types that have no matching primary type will be
     mapped to ``KeyboardAction/PrimaryType/custom(title:)``.
     */
    var keyboardAction: KeyboardAction {
        .primary(primaryButtonType)
    }

    /**
     The corresponding ``KeyboardAction/PrimaryType``.

     Return types that have no matching primary type will be
     mapped to ``KeyboardAction/PrimaryType/custom(title:)``.
     */
    var primaryButtonType: KeyboardAction.PrimaryType {
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
