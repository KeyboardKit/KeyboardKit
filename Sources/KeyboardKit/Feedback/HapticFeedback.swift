//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains various haptic feedback types.
  
 You can call ``trigger()`` on any feedback value to trigger
 it, using the static ``engine``. You can replace the engine
 with any custom engine if you need to.

 Note that `macOS`, `tvOS` and `watchOS` resolves a disabled
 ``HapticFeedbackEngine`` by default, since the platforms do
 not support system haptics. You can replace it with another
 engine that does something meaningful on each platform.
*/
public enum HapticFeedback: String, CaseIterable, Codable, Equatable, Identifiable {
    
    case

    /// Represents feedback for an error event.
    error,

    /// Represents feedback for a successful event.
    success,

    /// Represents feedback for a warning event.
    warning,


    /// Represents light impact feedback.
    lightImpact,

    /// Represents medium impact feedback.
    mediumImpact,

    /// Represents heavy impact feedback.
    heavyImpact,


    /// Represents feedback when a selection changes.
    selectionChanged,


    /// Can be used to disable feedback.
    none
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    /**
     The unique feedback identifier.
     */
    var id: String { rawValue }

    /**
     The engine that will be used to trigger haptic feedback.
     */
    static var engine: HapticFeedbackEngine = {
        #if os(iOS)
        StandardHapticFeedbackEngine.shared
        #else
        DisabledHapticFeedbackEngine()
        #endif
    }()
    
    /**
     Prepare the haptic feedback, using the shared engine.
     */
    func prepare() {
        Self.engine.prepare(self)
    }
    
    /**
     Trigger the feedback, using the shared feedback engine.
     */
    func trigger() {
        Self.engine.trigger(self)
    }
}
