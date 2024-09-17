//
//  KeyboardViewController+Setup.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI

extension KeyboardInputViewController {
    
    /// Setup KeyboardKit with a custom root view.
    func setup<Content: View>(
        for app: KeyboardApp?,
        withRootView view: Keyboard.RootView<Content>
    ) {
        if let app { setup(for: app) }
        self.children.forEach { $0.removeFromParent() }
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = view
            .keyboardSettings(self.settings)
            .keyboardState(self.state)
        let host = KeyboardHostingController(rootView: view)
        host.add(to: self)
    }

    /// Setup the controller when it has loaded.
    func setupController() {
        setupContexts()
        setupInitialWidth()
        setupLocaleObservation()
    }

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to the various context
    /// classes. This will be removed in KeyboardKit 9.0.
    func setupContexts() {
        settings.autocompleteSettings
            .syncToContextIfNeeded(state.autocompleteContext)
        settings.keyboardSettings
            .syncToContextIfNeeded(state.keyboardContext)
        settings.dictationSettings
            .syncToContextIfNeeded(state.dictationContext)
        settings.feedbackSettings
            .syncToContextIfNeeded(state.feedbackContext)
    }

    /// Set up the initial keyboard type.
    func setupInitialKeyboardType() {
        guard state.keyboardContext.keyboardType.isAlphabetic else { return }
        state.keyboardContext.syncKeyboardType(with: textDocumentProxy)
    }

    /// Set up an initial width to avoid SwiftUI layout bugs.
    func setupInitialWidth() {
        #if os(iOS) || os(tvOS)
        view.frame.size.width = UIScreen.main.bounds.width
        #else
        view.frame.size.width = 500
        #endif
    }

    /// Setup locale observation to handle locale changes.
    func setupLocaleObservation() {
        state.keyboardContext.$locale.sink { [weak self] in
            guard let self = self else { return }
            let locale = $0
            self.primaryLanguage = locale.identifier
            self.services.autocompleteService.locale = locale
        }
        .store(in: &cancellables)
    }
}
#endif
