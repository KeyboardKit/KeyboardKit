//
//  Keyboard+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// This type specifies global keyboard settings.
    ///
    /// Do not confuse this with ``KeyboardSettings``, which
    /// is an observable class for general keyboard settings.
    /// This type gathers all those kind of settings classes
    /// to let you access all of them from one place.
    ///
    /// Unlike the ``Keyboard/State`` properties, these will
    /// persist any changes that are made to them. Make sure
    /// to see the <doc:Essentials> & <doc:Settings-Article>
    /// articles for more information on how to sync changes
    /// between the main app and the keyboard extension.
    ///
    /// KeyboardKit will automatically sync applied settings
    /// with ``KeyboardInputViewController/state`` when your
    /// keyboard launches, and will add `onChange` events to
    /// the keyboard view to apply settings changes to these
    /// state instances as well. Context changes are however
    /// not synced to settings.
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
