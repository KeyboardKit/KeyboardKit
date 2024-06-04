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
        withRootView view: Content
    ) {
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
        setupInitialWidth()
        setupLocaleObservation()
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
            self.services.autocompleteProvider.locale = locale
        }
        .store(in: &cancellables)
    }
}
#endif
