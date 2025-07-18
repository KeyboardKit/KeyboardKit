//
//  Feedback+Audio.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Feedback {

    /// This enum defines standard audio feedback types.
    ///
    /// Audio feedback has a unique system id that refers to
    /// system sounds. You can use ``customId(_:)`` to add a
    /// custom ID-based feedback type, and ``customUrl(_:)``
    /// to add custom audio feedback from any URL-based file.
    enum Audio: Identifiable, KeyboardModel {
        
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
}
