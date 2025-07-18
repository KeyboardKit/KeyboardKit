//
//  KeyboardAppView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used as the root view of a keyboard app,
/// to set up KeyboardKit for a certain ``KeyboardApp``.
///
/// To use the view, just add it around your app's root view:
///
/// ```swift
/// @main
/// struct MyApp: App {
///
///     var body: some Scene {
///         WindowGroup {
///             KeyboardAppView(for: .myApp) {
///                 ContentView()
///             }
///         }
///     }
/// }
/// ```
///
/// This will set up your app, register your Pro license (if
/// needed), inject keyboard state into the environment, etc.
public struct KeyboardAppView<Content: View>: View {

    /// Create a KeyboardKit app wrapper, that injects state
    /// into the view hierarchy, registers
    public init(
        for app: KeyboardApp,
        @ViewBuilder content: @escaping () -> Content
    ) {
        KeyboardSettings.setupStore(for: app)
        let state = Keyboard.State()
        state.setup(for: app)
        
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let bundleWildcard = "\(bundleId).*"
        let statusContext = KeyboardStatusContext(bundleId: bundleWildcard)

        self.app = app
        self._autocompleteContext = .init(wrappedValue: state.autocompleteContext)
        self._calloutContext = .init(wrappedValue: state.calloutContext)
        self._dictationContext = .init(wrappedValue: state.dictationContext)
        self._emojiContext = .init(wrappedValue: state.emojiContext)
        self._externalContext = .init(wrappedValue: state.externalKeyboardContext)
        self._feedbackContext = .init(wrappedValue: state.feedbackContext)
        self._keyboardContext = .init(wrappedValue: state.keyboardContext)
        self._keyboardStatusContext = .init(wrappedValue: statusContext)
        self._themeContext = .init(wrappedValue: state.themeContext)
        self.content = content
    }

    private let app: KeyboardApp

    private let content: () -> Content
    
    @StateObject var autocompleteContext: AutocompleteContext
    @StateObject var calloutContext: CalloutContext
    @StateObject var dictationContext: DictationContext
    @StateObject var emojiContext: EmojiContext
    @StateObject var externalContext: ExternalKeyboardContext
    @StateObject var feedbackContext: FeedbackContext
    @StateObject var keyboardContext: KeyboardContext
    @StateObject var keyboardStatusContext: KeyboardStatusContext
    @StateObject var themeContext: KeyboardThemeContext

    public var body: some View {
        ZStack {
            LicenseRegistrationView(app: app)
            content()
        }
        .environmentObject(autocompleteContext)
        .environmentObject(calloutContext)
        .environmentObject(dictationContext)
        .environmentObject(emojiContext)
        .environmentObject(externalContext)
        .environmentObject(feedbackContext)
        .environmentObject(keyboardContext)
        .environmentObject(keyboardStatusContext)
        .environmentObject(themeContext)
    }
}
