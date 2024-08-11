//
//  Keyboard+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// DEPRECATED!
    ///
    /// > Warning: Settings have been moved into the various
    /// context types. This will be removed in KeyboardKit 9.
    class Settings {

        /// The autocomplete settings to use.
        public lazy var autocompleteSettings = AutocompleteSettings()

        /// The dictation settings to use.
        public lazy var dictationSettings = DictationSettings()

        /// The feedback settings to use.
        public lazy var feedbackSettings = FeedbackSettings()

        /// The keyboard settings to use.
        public lazy var keyboardSettings = KeyboardSettings()
    }
}

public extension View {
    
    // Inject observable settings into the view hierarchy.
    func keyboardSettings(_ settings: Keyboard.Settings) -> some View {
        self.environmentObject(settings.autocompleteSettings)
            .environmentObject(settings.dictationSettings)
            .environmentObject(settings.feedbackSettings)
            .environmentObject(settings.keyboardSettings)
    }
}
