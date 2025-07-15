//
//  EmojiContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-15.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class has observable states and persistent settings
/// for emoji-related functionality.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure emojis.
///
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class EmojiContext: ObservableObject {

    /// Create an autocomplete context instance.
    public init() {
        settings = .init()
    }

    // MARK: - Settings

    /// Auto-persisted emoji settings.
    @Published public var settings: EmojiSettings
}
