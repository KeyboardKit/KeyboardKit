//
//  KeyboardContext+Sync.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
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
        let value = settings.isAutocapitalizationEnabled ? nil : noAutocap
        if autocapitalizationTypeOverride != value {
            autocapitalizationTypeOverride = value
        }
    }

    /// Make the context trigger a keyboard view refresh.
    func triggerKeyboardViewRefresh() {
        self.locale = locale
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
}

extension KeyboardContext {
    
    func update<ValueType: Equatable>(
        _ keypath: ReferenceWritableKeyPath<KeyboardContext, ValueType>,
        ifHasChanged val: ValueType
    ) {
        if self[keyPath: keypath] != val {
            self[keyPath: keypath] = val
        }
    }
}

extension KeyboardContext {

    /// Perform a sync after an async delay.
    func syncAfterAsync(
        with controller: KeyboardInputViewController,
        isForNewDocument: Bool = false
    ) {
        syncTextDocumentProxy(with: controller)
        update(\.hasDictationKey, ifHasChanged: controller.hasDictationKey)
        update(\.hasFullAccess, ifHasChanged: controller.hasFullAccess)
        update(\.hostApplicationBundleId, ifHasChanged: controller.hostApplicationBundleId)
        update(\.needsInputModeSwitchKey, ifHasChanged: controller.needsInputModeSwitchKey)
        update(\.interfaceOrientation, ifHasChanged: controller.orientation)
        update(\.primaryLanguage, ifHasChanged: controller.primaryLanguage)
        update(\.screenSize, ifHasChanged: controller.screenSize)
        update(\.textInputMode, ifHasChanged: controller.textInputMode)
        update(\.traitCollection, ifHasChanged: controller.traitCollection)
        if isForNewDocument {
            syncKeyboardType(with: controller.originalTextDocumentProxy)
        }
    }

    func syncAfterLayout(with controller: KeyboardInputViewController) {
        syncIsFloating(with: controller)
        if controller.orientation == interfaceOrientation { return }
        sync(with: controller)
    }

    /// Perform a sync to check if the keyboard is floating.
    func syncIsFloating(
        with controller: KeyboardInputViewController,
        usePhoneDeviceForFloatingKeyboard: Bool = true
    ) {
        let isFloating = controller.view.frame.width < screenSize.width/2
        if isKeyboardFloating == isFloating { return }
        let usePhone = isFloating && usePhoneDeviceForFloatingKeyboard
        isKeyboardFloating = isFloating
        deviceTypeForKeyboard = usePhone ? .phone : deviceType
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
