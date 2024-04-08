//
//  Feedback.Audio.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Feedback {
    
    /// This enum defines audio feedback types.
    ///
    /// You can call ``trigger()`` to play any feedback type.
    ///
    /// Each feedback type has a unique system id that refers to
    /// a system sound that is played when feedback is triggered.
    enum Audio: Codable, Equatable, Identifiable {
        
        /// Represents the sound of an input key.
        case input
        
        /// Represents the sound of a system key.
        case system
        
        /// Represents the sound of a delete key.
        case delete
        
        /// Represents a custom system sound.
        case customId(_ id: UInt32)
        
        /// Represents a custom sound at a certain URL.
        case customUrl(_ url: URL?)
        
        /// Can be used to disable feedback.
        case none
    }
}

public extension Feedback.Audio {
    
    /// The unique system sound identifier.
    var id: UInt32? {
        switch self {
        case .input: 1104
        case .delete: 1155
        case .system: 1156
        case .customId(let id): id
        case .customUrl: nil
        case .none: 0
        }
    }
    
    /// Trigger the feedback with the shared feedback engine.
    func trigger() {
        Feedback.AudioEngine.shared.trigger(self)
    }
}
