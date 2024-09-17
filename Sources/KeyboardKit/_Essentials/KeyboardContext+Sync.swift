//
//  KeyboardContext+Sync.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

extension KeyboardContext {

    /// Sync ``autocapitalizationTypeOverride`` with settings.
    func syncAutocapitalizationWithSetting() {
        let noAutocap = Keyboard.AutocapitalizationType.none
        let value = isAutocapitalizationEnabled ? nil : noAutocap
        if autocapitalizationTypeOverride != value {
            autocapitalizationTypeOverride = value
        }
    }

    /// Make the context trigger a keyboard view refresh.
    func triggerKeyboardViewRefresh() {
        setLocale(locale)
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
public extension KeyboardContext {

    /// Sync the context with the provided input controller.
    func sync(with controller: KeyboardInputViewController) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: controller)
        }
    }

    /// Sync the ``keyboardType`` with the provided proxy.
    func syncKeyboardType(with proxy: UITextDocumentProxy) {
        guard let type = proxy.keyboardType?.keyboardType else { return }
        if keyboardType == type { return }
        keyboardType = type
    }

    /// Sync the ``originalTextDocumentProxy``.
    func syncTextDocumentProxy(with controller: KeyboardInputViewController) {
        if originalTextDocumentProxy === controller.originalTextDocumentProxy { return }
        DispatchQueue.main.async {
            self.originalTextDocumentProxy = controller.originalTextDocumentProxy
        }
    }

    /// Sync the ``textInputProxy``.
    func syncTextInputProxy(with controller: KeyboardInputViewController) {
        if textInputProxy === controller.textInputProxy { return }
        DispatchQueue.main.async {
            self.textInputProxy = controller.textInputProxy
        }
    }
}

extension KeyboardContext {

    /// Perform a sync after an async delay.
    func syncAfterAsync(with controller: KeyboardInputViewController) {
        syncTextDocumentProxy(with: controller)
        syncTextInputProxy(with: controller)

        if hasDictationKey != controller.hasDictationKey {
            hasDictationKey = controller.hasDictationKey
        }

        if hasFullAccess != controller.hasFullAccess {
            hasFullAccess = controller.hasFullAccess
        }

        if hostApplicationBundleId != controller.hostApplicationBundleId {
            hostApplicationBundleId = controller.hostApplicationBundleId
        }

        if interfaceOrientation != controller.orientation {
            interfaceOrientation = controller.orientation
        }

        if needsInputModeSwitchKey != controller.needsInputModeSwitchKey {
            needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        }

        let sdkAutocomplete = keyboardType.prefersAutocomplete
        let rawAutocomplete = textDocumentProxy.keyboardType?.prefersAutocomplete ?? true
        let newPrefersAutocomplete = sdkAutocomplete && rawAutocomplete
        if prefersAutocomplete != newPrefersAutocomplete {
            prefersAutocomplete = newPrefersAutocomplete
        }

        if primaryLanguage != controller.primaryLanguage {
            primaryLanguage = controller.primaryLanguage
        }

        if screenSize != controller.screenSize {
            screenSize = controller.screenSize
        }

        if textInputMode != controller.textInputMode {
            textInputMode = controller.textInputMode
        }

        if traitCollection != controller.traitCollection {
            traitCollection = controller.traitCollection
        }
    }

    func syncAfterLayout(with controller: KeyboardInputViewController) {
        syncIsFloating(with: controller)
        if controller.orientation == interfaceOrientation { return }
        sync(with: controller)
    }

    /// Perform a sync to check if the keyboard is floating.
    func syncIsFloating(with controller: KeyboardInputViewController) {
        let isFloating = controller.view.frame.width < screenSize.width/2
        if isKeyboardFloating == isFloating { return }
        isKeyboardFloating = isFloating
    }
}

private extension UIInputViewController {

    var orientation: InterfaceOrientation {
        #if os(iOS) || os(tvOS)
        view.window?.screen.interfaceOrientation ?? .portrait
        #else
        .portrait
        #endif
    }

    var screenSize: CGSize {
        #if os(iOS) || os(tvOS)
        view.window?.screen.bounds.size ?? .zero
        #else
        .zero
        #endif
    }
}
#endif
