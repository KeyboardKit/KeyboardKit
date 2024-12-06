//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

/// This class has observable states and persistent settings
/// for keyboard-based dictation.
///
/// The ``dictatedText`` property is updated while dictation
/// is performed, together with many other properties, which
/// are used by the dictation services. The ``lastError`` is
/// set when something goes wrong. You can observe both.
///
/// This class also has observable auto-persisted ``settings``
/// that can be used to configure the behavior and presented
/// to users in e.g. a settings screen.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
public class DictationContext: ObservableObject {

    /// Create a dictation context instance.
    public init() {
        settings = .init()
    }


    // MARK: - Settings

    /// A ``Dictation/Settings`` typealias.
    public typealias Settings = Dictation.Settings

    /// Dictation-specific, auto-persisted settings.
    @Published
    public var settings: Settings


    // MARK: - Persisted State

    /// This store to use for persisted dictation data.
    ///
    /// This uses the same store as ``Keyboard/Settings`` so
    /// settings and dictation state use the same store.
    static var peristentStore: UserDefaults {
        Keyboard.Settings.store
    }

    /// The currently dictated text, which will update while
    /// dictation detects new text.
    ///
    /// This text can be observed from your app, and will be
    /// automatically synced between an app and its keyboard.
    @AppStorage("\(Settings.settingsPrefix)dictatedText", store: .keyboardSettings)
    public var dictatedText = ""

    /// The bundle ID of the app that is using the keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app navigate back to the keyboard.
    @AppStorage("\(Settings.settingsPrefix)hostApplicationBundleId", store: .keyboardSettings)
    public var hostApplicationBundleId: String?

    /// Whether dictation has been started by a keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app start dictation if it cannot use deep links.
    @AppStorage("\(Settings.settingsPrefix)isDictationStartedByKeyboard", store: .keyboardSettings)
    public var isDictationStartedByKeyboard = false


    // MARK: - Properties

    /// Whether dictation is currently in progress.
    @Published
    public var isDictating = false

    /// The last applied dictation error.
    @Published
    public var lastError: Error?

    /// The last inserted dictated text.
    ///
    /// This can be used to undo the last inserted dictation.
    @Published
    public var lastInsertedText: String?

    /// The last navigate back error.
    @Published
    public var returnToKeyboardFromAppError: Error?

    /// A strong reference to the current dictation service.
    public var service: DictationService?
}

public extension DictationContext {

    /// Reset the context.
    func reset() {
        DispatchQueue.main.async {
            self.dictatedText = ""
            self.isDictating = false
            self.isDictationStartedByKeyboard = false
            self.lastError = nil
            self.returnToKeyboardFromAppError = nil
        }
    }

    /// Set ``isDictating`` with an animation.
    func setIsDictating(_ value: Bool) {
        withAnimation {
            isDictating = value
        }
    }
}
