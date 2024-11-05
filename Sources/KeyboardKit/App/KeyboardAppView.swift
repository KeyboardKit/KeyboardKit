//
//  KeyboardAppView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used as the root view of a keyboard app,
/// to set up KeyboardKit for a ``KeyboardApp``.
///
/// To use this view, just create a ``KeyboardApp`` for your
/// app and use it to setup this view as the app's root view:
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
/// This view will set up ``KeyboardSettings`` to use an App
/// Group, set up a ``Keyboard/State`` and inject state into
/// the view, after which you can access any state like this:
///
/// ```swift
/// struct MyView: View {
///
///     @EnvironmentObject
///     var keyboardContext: KeyboardContext
///
///     var body: View {
///         ...
///     }
/// }
/// ```
///
/// You can then change any state from any view to customize
/// the app to fit your needs.
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

        self.app = app
        self._autocompleteContext = .init(wrappedValue: state.autocompleteContext)
        self._calloutContext = .init(wrappedValue: state.calloutContext)
        self._dictationContext = .init(wrappedValue: state.dictationContext)
        self._feedbackContext = .init(wrappedValue: state.feedbackContext)
        self._keyboardContext = .init(wrappedValue: state.keyboardContext)
        self._keyboardContext = .init(wrappedValue: state.keyboardContext)
        self._themeContext = .init(wrappedValue: state.themeContext)
        self.content = content
    }

    private let app: KeyboardApp

    private let content: () -> Content

    @StateObject
    private var autocompleteContext: AutocompleteContext

    @StateObject
    private var calloutContext: KeyboardCalloutContext

    @StateObject
    private var dictationContext: DictationContext

    @StateObject
    private var feedbackContext: FeedbackContext

    @StateObject
    private var keyboardContext: KeyboardContext

    @StateObject
    private var themeContext: KeyboardThemeContext

    public var body: some View {
        ZStack {
            RegistrationView(app: app)
            content()
        }
        .environmentObject(autocompleteContext)
        .environmentObject(calloutContext)
        .environmentObject(dictationContext)
        .environmentObject(feedbackContext)
        .environmentObject(keyboardContext)
        .environmentObject(themeContext)
    }
}
