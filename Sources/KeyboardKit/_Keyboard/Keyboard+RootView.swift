//
//  Keyboard+RootView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
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
    
        @EnvironmentObject var autocompleteContext: AutocompleteContext
        @EnvironmentObject var calloutContext: KeyboardCalloutContext
        @EnvironmentObject var dictationContext: DictationContext
        @EnvironmentObject var externalContext: ExternalKeyboardContext
        @EnvironmentObject var feedbackContext: KeyboardFeedbackContext
        @EnvironmentObject var keyboardContext: KeyboardContext
        @EnvironmentObject var themeContext: KeyboardThemeContext

        var body: some View {
            view()
                .keyboardDockEdge(keyboardContext.settings.keyboardDockEdge)
                .onChange(of: externalContext.isExternalKeyboardConnected) { newValue in
                    guard keyboardContext.settings.isKeyboardAutoCollapseEnabled else { return }
                    keyboardContext.isKeyboardCollapsed = newValue
                }
        }
    }
}
