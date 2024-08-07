//
//  Keyboard+RootView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Keyboard {
    
    /// This view is used as a wrapper view, to make sure it
    /// binds to state that affects your layout.
    struct RootView<ViewType: View>: View {
        
        init(@ViewBuilder _ view: @escaping () -> ViewType) {
            self.view = view
        }
        
        var view: () -> ViewType
        

        @EnvironmentObject
        private var autocompleteContext: AutocompleteContext

        @EnvironmentObject
        private var calloutContext: CalloutContext

        @EnvironmentObject
        private var dictationContext: DictationContext

        @EnvironmentObject
        private var feedbackContext: FeedbackContext

        @EnvironmentObject
        private var keyboardContext: KeyboardContext


        @EnvironmentObject
        private var autocompleteSettings: AutocompleteSettings

        @EnvironmentObject
        private var dictationSettings: DictationSettings

        @EnvironmentObject
        private var feedbackSettings: FeedbackSettings

        @EnvironmentObject
        private var keyboardSettings: KeyboardSettings


        var body: some View {
            view()
                .onChange(of: autocompleteSettings.lastChanged) { _ in
                    autocompleteContext.sync(with: autocompleteSettings)
                }
                .onChange(of: dictationSettings.lastChanged) { _ in
                    dictationContext.sync(with: dictationSettings)
                }
                .onChange(of: feedbackSettings.lastChanged) { _ in
                    feedbackContext.sync(with: feedbackSettings)
                }
                .onChange(of: keyboardSettings.lastChanged) { _ in
                    keyboardContext.sync(with: keyboardSettings)
                }
        }
    }
}
