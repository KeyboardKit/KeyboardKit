//
//  Keyboard+ReturnKeyType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /**
     This enum defines various keyboard return key types.
     
     Return keys can be used as ``KeyboardAction/primary(_:)``
     actions and will insert a new line or perform a primary
     action when they are tapped.
     
     This is a multi-platform version of the UIKit exclusive
     `UIReturnKeyType` class, which has been extended with a
     `keyboardReturnKeyType` that maps it to this enum.
     
     Note that the use of some of the defined keys are still
     unknown, which means they aren't localized. Please fill
     out any of the missing information if you happen to see
     these keys being used by the system.
     */
    enum ReturnKeyType: CaseIterable, Codable, Equatable, Identifiable {
        
        /// A return key that uses a return text and not a ⏎.
        case `return`
        
        /// An continue key (native use unknown).
        case `continue`
        
        /// A done key (used when adding a Calendar location).
        case done
        
        /// An emergency call key (native use unknown).
        case emergencyCall
        
        /// A go key (used when entering a URL in Safari).
        case go
        
        /// A join key (used when joining wifi with password).
        case join
        
        /// A return key that uses a ⏎ and not a return text.
        case newLine
        
        /// A next key (used when joining wifi with uid/pwd).
        case next
        
        /// An ok key, which isn't actually used in native.
        case ok
        
        /// A route key (native use unknown).
        case route
        
        /// A search key (used for Google search in Safari).
        case search
        
        /// A send key (used when typing in WeChat, QQ, etc.).
        case send
        
        /// A custom key with a custom title.
        case custom(title: String)
        
        /**
         All unique primary keyboard action types, excluding
         ``KeyboardAction/custom(named:)``.
         */
        public static var allCases: [Self] {
            [.return, .done, .go, .join, .newLine, .next, .ok, .search, .send]
        }
    }
}

public extension Keyboard.ReturnKeyType {

    /// The type's unique identifier.
    var id: String {
        switch self {
        case .done: return "done"
        case .emergencyCall: return "emergencyCall"
        case .continue: return "continue"
        case .go: return "go"
        case .join: return "join"
        case .newLine: return "newLine"
        case .next: return "next"
        case .ok: return "ok"
        case .return: return "return"
        case .route: return "route"
        case .search: return "search"
        case .send: return "send"
        case .custom(let title): return title
        }
    }

    /// Whether or not this type is a system action.
    var isSystemAction: Bool {
        switch self {
        case .newLine: return true
        case .return: return true
        default: return false
        }
    }

    /// The standard button image for a certain locale.
    func standardButtonImage(for locale: Locale) -> Image? {
        switch self {
        case .newLine: return .keyboardNewline(for: locale)
        default: return nil
        }
    }
    
    /// The standard button to text for a certain locale.
    func standardButtonText(for locale: Locale) -> String? {
        switch self {
        case .custom(let title): return title
        case .continue: return KKL10n.continue.text(for: locale)
        case .done: return KKL10n.done.text(for: locale)
        case .emergencyCall: return KKL10n.emergencyCall.text(for: locale)
        case .go: return KKL10n.go.text(for: locale)
        case .join: return KKL10n.join.text(for: locale)
        case .newLine: return nil
        case .next: return KKL10n.next.text(for: locale)
        case .return: return KKL10n.return.text(for: locale)
        case .route: return KKL10n.route.text(for: locale)
        case .ok: return KKL10n.ok.text(for: locale)
        case .search: return KKL10n.search.text(for: locale)
        case .send: return KKL10n.send.text(for: locale)
        }
    }
    
    /// The standard button to text for a certain locale.
    func standardButtonText(for locale: KeyboardLocale) -> String? {
        standardButtonText(for: locale.locale)
    }
}

#if os(iOS) || os(tvOS)
import UIKit

extension Keyboard.ReturnKeyType {
    
    var nativeType: UIReturnKeyType {
        switch self {
        case .return: return .default
        case .done: return .done
        case .go: return .go
        case .join: return .join
        case .next: return .next
        case .route: return .route
        case .search: return .search
        case .send: return .send
        case .emergencyCall: return .emergencyCall
        case .continue: return .continue
        default: return .default
        }
    }
}

extension UIReturnKeyType {}

public extension UIReturnKeyType {

    /**
     The corresponding ``Keyboard/ReturnKeyType``.

     Return types that have no matching primary type will be
     mapped to ``Keyboard/ReturnKeyType/custom(title:)``.
     */
    var keyboardReturnKeyType: Keyboard.ReturnKeyType {
        switch self {
        case .default: return .return
        case .done: return .done
        case .go: return .go
        case .google: return .custom(title: "Google")
        case .join: return .join
        case .next: return .next
        case .route: return .route
        case .search: return .search
        case .send: return .send
        case .yahoo: return .custom(title: "Yahoo")
        case .emergencyCall: return .emergencyCall
        case .continue: return .continue
        @unknown default: return .custom(title: "unknown")
        }
    }
}
#endif
