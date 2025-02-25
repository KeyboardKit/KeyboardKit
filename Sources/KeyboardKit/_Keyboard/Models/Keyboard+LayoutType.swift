//
//  Keyboard+LayoutType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-08.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines various keyboard layout types.
    ///
    /// Unlike the ``InputSet`` and ``KeyboardLayout`` types,
    /// this enum defines standard layout types, without any
    /// specific information about how a type is implemented.
    ///
    /// This is used to allow an ``AddedLocale`` to define a
    /// locale together with an optional layout. KeyboardKit
    /// Pro defines ``Foundation/Locale/supportedLayoutTypes``
    /// for each supported locale.
    ///
    /// This may be refactored in the future, since it mixes
    /// the concept of locales, layouts and input methods. A
    /// better name should at least be found.
    enum LayoutType: CaseIterable, Identifiable, KeyboardModel {
        
        public init?(id: String) {
            let match = Self.allCases.first { $0.id == id }
            guard let match else { return nil }
            self = match
        }
        
        /// A AZERTY keyboard layout type.
        case azerty
        
        /// A Colemak keyboard layout type.
        case colemak
        
        /// A QWERTY keyboard layout type.
        case qwerty
        
        /// A QWERTY keyboard in Catalan layout type.
        case qwerty_catalan
        
        /// A QWERTZ keyboard layout type.
        case qwertz
        
        /// A Vietnamese Telex layout type.
        case vietnamese_telex(NestedReference)
        
        /// A Vietnamese VIQR layout type.
        case vietnamese_viqr(NestedReference)
        
        /// A Vietnamese VNI layout type.
        case vietnamese_vni(NestedReference)
    }
}

public extension Keyboard.LayoutType {
    
    /// All possible layout combinations
    static var allCases: [Keyboard.LayoutType] {
        [
            .azerty,
            .colemak,
            .qwerty,
            .qwerty_catalan,
            .qwertz,
            .vietnamese_telex(.azerty),
            .vietnamese_telex(.colemak),
            .vietnamese_telex(.qwerty),
            .vietnamese_telex(.qwertz),
            .vietnamese_viqr(.azerty),
            .vietnamese_viqr(.colemak),
            .vietnamese_viqr(.qwerty),
            .vietnamese_viqr(.qwertz),
            .vietnamese_vni(.azerty),
            .vietnamese_vni(.colemak),
            .vietnamese_vni(.qwerty),
            .vietnamese_vni(.qwertz)
        ]
    }
    
    /// The layout type's display name.
    var displayName: String {
        switch self {
        case .azerty: "AZERTY"
        case .colemak: "Colemak"
        case .qwerty: "QWERTY"
        case .qwerty_catalan: "QWERTY - Catalan"
        case .qwertz: "QWERTZ"
        case .vietnamese_telex(let ref): "Telex - \(ref.displayName)"
        case .vietnamese_viqr(let ref): "VIQR - \(ref.displayName)"
        case .vietnamese_vni(let ref): "VNI - \(ref.displayName)"
        }
    }
    
    /// The layout type's unique ID.
    var id: String {
        switch self {
        case .azerty: "azerty"
        case .colemak: "colemak"
        case .qwerty: "qwerty"
        case .qwerty_catalan: "qwerty_catalan"
        case .qwertz: "qwertz"
        case .vietnamese_telex(let ref): "vietnamese_telex_\(ref.id)"
        case .vietnamese_viqr(let ref): "vietnamese_viqr_\(ref.id)"
        case .vietnamese_vni(let ref): "vietnamese_vni_\(ref.id)"
        }
    }
}

public extension Keyboard.LayoutType {
    
    /// This is used as a nested reference to a main type.
    enum NestedReference: String, CaseIterable, Identifiable, KeyboardModel {
        case azerty
        case colemak
        case qwerty
        case qwertz
    }
}

public extension Keyboard.LayoutType.NestedReference {
    
    var displayName: String {
        switch self {
        case .colemak: rawValue.capitalized
        default: rawValue.uppercased()
        }
    }
    
    var id: String { rawValue }
}
