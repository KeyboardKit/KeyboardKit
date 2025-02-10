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
/// This sets up the ``KeyboardSettings/store`` to sync data
/// between the app and its keyboard, provided that your app
/// defines an ``KeyboardApp/appGroupId``. It also creates a
/// dedicated ``Keyboard/State`` for the app and injects the
/// state into the main view hierarchy, after which your app
/// can access any state like this:
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
        
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let bundleWildcard = "\(bundleId).*"
        let statusContext = KeyboardStatusContext(bundleId: bundleWildcard)

        self.app = app
        self._autocompleteContext = .init(wrappedValue: state.autocompleteContext)
        self._calloutContext = .init(wrappedValue: state.calloutContext)
        self._dictationContext = .init(wrappedValue: state.dictationContext)
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
    @StateObject var calloutContext: KeyboardCalloutContext
    @StateObject var dictationContext: DictationContext
    @StateObject var externalContext: ExternalKeyboardContext
    @StateObject var feedbackContext: KeyboardFeedbackContext
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
        .environmentObject(externalContext)
        .environmentObject(feedbackContext)
        .environmentObject(keyboardContext)
        .environmentObject(keyboardStatusContext)
        .environmentObject(themeContext)
    }
}
