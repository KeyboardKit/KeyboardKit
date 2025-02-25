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
    enum LayoutType: String, CaseIterable, Identifiable, KeyboardModel {
        
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
        
        /// A Vietnamese Telex - AZERTY layout type.
        case vietnamese_telex_azerty
        
        /// A Vietnamese Telex - QWERTY layout type.
        case vietnamese_telex_qwerty
        
        /// A Vietnamese Telex - QWERTZ layout type.
        case vietnamese_telex_qwertz
        
        /// A Vietnamese VIQR - AZERTY layout type.
        case vietnamese_viqr_azerty
        
        /// A Vietnamese VIQR - QWERTY layout type.
        case vietnamese_viqr_qwerty
        
        /// A Vietnamese VIQR - QWERTZ layout type.
        case vietnamese_viqr_qwertz
        
        /// A Vietnamese VNI - AZERTY layout type.
        case vietnamese_vni_azerty
        
        /// A Vietnamese VNI - QWERTY layout type.
        case vietnamese_vni_qwerty
        
        /// A Vietnamese VNI - QWERTZ layout type.
        case vietnamese_vni_qwertz
        
        /// The layout type's unique ID.
        public var id: String { rawValue }
    }
}

public extension Keyboard.LayoutType {
    
    // The layout type's display name.
    var displayName: String {
        switch self {
        case .colemak: rawValue.capitalized
        case .qwerty_catalan: "QWERTY - Catalan"
        case .vietnamese_telex_azerty: "Telex - AZERTY"
        case .vietnamese_telex_qwerty: "Telex - QWERTY"
        case .vietnamese_telex_qwertz: "Telex - QWERTZ"
        case .vietnamese_viqr_azerty: "VIQR - AZERTY"
        case .vietnamese_viqr_qwerty: "VIQR - QWERTY"
        case .vietnamese_viqr_qwertz: "VIQR - QWERTZ"
        case .vietnamese_vni_azerty: "VNI - AZERTY"
        case .vietnamese_vni_qwerty: "VNI - QWERTY"
        case .vietnamese_vni_qwertz: "VNI - QWERTZ"
        default: rawValue.uppercased()
        }
    }
}
