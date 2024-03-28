//
//  Keyboard+ReturnKeyType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-17.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines various keyboard return key types.
    ///
    /// Return keys are used as ``KeyboardAction/primary(_:)``
    /// actions and insert a new line or perform the primary
    /// action when they are tapped.
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
        
        /// All primary return button types with a known use.
        public static var allCases: [Self] {
            [.return, .done, .go, .join, .newLine, .next, .ok, .search, .send]
        }
    }
}

public extension Keyboard.ReturnKeyType {

    /// The type's unique identifier.
    var id: String {
        switch self {
        case .done: "done"
        case .emergencyCall: "emergencyCall"
        case .continue: "continue"
        case .go: "go"
        case .join: "join"
        case .newLine: "newLine"
        case .next: "next"
        case .ok: "ok"
        case .return: "return"
        case .route: "route"
        case .search: "search"
        case .send: "send"
        case .custom(let title): title
        }
    }

    /// Whether or not this type is a system action.
    var isSystemAction: Bool {
        switch self {
        case .newLine: true
        case .return: true
        default: false
        }
    }

    /// The standard button image for a certain locale.
    func standardButtonImage(for locale: Locale) -> Image? {
        switch self {
        case .newLine: .keyboardNewline(for: locale)
        default: nil
        }
    }
    
    /// The standard button to text for a certain locale.
    func standardButtonText(for locale: Locale) -> String? {
        switch self {
        case .custom(let title): title
        case .continue: KKL10n.continue.text(for: locale)
        case .done: KKL10n.done.text(for: locale)
        case .emergencyCall: KKL10n.emergencyCall.text(for: locale)
        case .go: KKL10n.go.text(for: locale)
        case .join: KKL10n.join.text(for: locale)
        case .newLine: nil
        case .next: KKL10n.next.text(for: locale)
        case .return: KKL10n.return.text(for: locale)
        case .route: KKL10n.route.text(for: locale)
        case .ok: KKL10n.ok.text(for: locale)
        case .search: KKL10n.search.text(for: locale)
        case .send: KKL10n.send.text(for: locale)
        }
    }
    
    /// The standard button to text for a certain locale.
    func standardButtonText(for locale: KeyboardLocale) -> String? {
        standardButtonText(for: locale.locale)
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension Keyboard.ReturnKeyType {
    
    /// The native UIReturnKeyType that this type represents.
    var nativeType: UIReturnKeyType {
        switch self {
        case .return: .default
        case .done: .done
        case .go: .go
        case .join: .join
        case .next: .next
        case .route: .route
        case .search: .search
        case .send: .send
        case .emergencyCall: .emergencyCall
        case .continue: .continue
        default: .default
        }
    }
}

extension UIReturnKeyType {}

public extension UIReturnKeyType {

    /// The ``Keyboard/ReturnKeyType`` this type represents.
    var keyboardReturnKeyType: Keyboard.ReturnKeyType {
        switch self {
        case .default: .return
        case .done: .done
        case .go: .go
        case .google: .custom(title: "Google")
        case .join: .join
        case .next: .next
        case .route: .route
        case .search: .search
        case .send: .send
        case .yahoo: .custom(title: "Yahoo")
        case .emergencyCall: .emergencyCall
        case .continue: .continue
        @unknown default: .custom(title: "unknown")
        }
    }
}
#endif
