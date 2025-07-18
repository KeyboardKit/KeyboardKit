//
//  Feedback+Haptic.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Feedback {

    /// This enum defines standard haptic feedback types.
    enum Haptic: String, CaseIterable, Identifiable, KeyboardModel {
        
        /// Represents feedback for an error event.
        case error
        
        /// Represents feedback for a successful event.
        case success
        
        /// Represents feedback for a warning event.
        case warning
        
        
        /// Represents light impact feedback.
        case lightImpact
        
        /// Represents medium impact feedback.
        case mediumImpact
        
        /// Represents heavy impact feedback.
        case heavyImpact
        
        
        /// Represents feedback when a selection changes.
        case selectionChanged
        
        
        /// Can be used to disable feedback.
        case none
    }
}

public extension Feedback.Haptic {

    /// The unique feedback identifier.
    var id: String { rawValue }
}
