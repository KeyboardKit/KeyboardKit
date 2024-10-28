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
    
    /// Set up KeyboardKit with a ``Keyboard.RootView``.
    func setup<Content: View>(
        withRootView view: Keyboard.RootView<Content>
    ) {
        self.children.forEach { $0.removeFromParent() }
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = view
            .keyboardState(self.state)
        let host = KeyboardHostingController(rootView: view)
        host.add(to: self)
    }

    /// Set up the initial keyboard type.
    func setupInitialKeyboardType() {
        let context = state.keyboardContext
        guard context.keyboardType == .alphabetic else { return }
        context.syncKeyboardType(with: textDocumentProxy)
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
