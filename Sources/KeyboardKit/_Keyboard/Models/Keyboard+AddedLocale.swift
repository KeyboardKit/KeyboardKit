//
//  Keyboard+AddedLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This type can be used to define metadata for locales
    /// that have been added to a keyboard.
    ///
    /// Every new value gets a unique ``id`` on creation. Do
    /// not confuse this ID with the ``localeIdentifier``.
    struct AddedLocale: Identifiable, KeyboardModel {
        
        public init(
            _ locale: Locale,
            layoutType: Keyboard.LayoutType? = nil
        ) {
            self.init(
                localeIdentifier: locale.identifier,
                layoutType: layoutType
            )
        }
        
        init(
            localeIdentifier: String,
            layoutType: Keyboard.LayoutType? = nil
        ) {
            self.id = UUID()
            self.localeIdentifier = localeIdentifier
            self.layoutTypeIdentifier = layoutType?.id
        }
        
        /// The unique identifier, defined at creation.
        public let id: UUID
        
        /// The ``locale`` identifier.
        public let localeIdentifier: String
        
        /// The ``layoutType`` identifier, if any.
        public var layoutTypeIdentifier: Keyboard.LayoutType.ID?
    }
}

public extension Keyboard.AddedLocale {
    
    /// A list of all supported locales.
    static var keyboardKitSupported: [Self] {
        Locale.keyboardKitSupported.map { .init($0) }
    }
    
    /// The related locale to use.
    ///
    /// This is optional, since the ``localeIdentifier`` can
    /// be invalid, even though this should never happen.
    var locale: Locale? {
        Locale(identifier: localeIdentifier)
    }
    
    /// The related keyboard layout to use, if any.
    var layoutType: Keyboard.LayoutType? {
        guard let id = layoutTypeIdentifier else { return nil }
        return .init(rawValue: id)
    }
}

public extension Collection where Element == Keyboard.AddedLocale {
    
    /// A list of all supported locales.
    static var keyboardKitSupported: [Element] {
        Element.keyboardKitSupported
    }
    
    /// Get the first locale for a certain locale and layout.
    func first(
        of locale: Locale,
        layoutType: Keyboard.LayoutType?
    ) -> Element? {
        guard let index = firstIndex(of: locale, layoutType: layoutType) else { return nil }
        return self[index]
    }
    
    /// Get the first locale for a certain locale and layout.
    func firstIndex(
        of locale: Locale,
        layoutType: Keyboard.LayoutType?
    ) -> Self.Index? {
        firstIndex { $0.locale?.identifier == locale.identifier && $0.layoutType == layoutType }
    }
}
