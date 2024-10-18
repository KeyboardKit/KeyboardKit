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

/// This class has observable states and persistent settings,
/// as well as a couple of persisted properties that are not
/// considered settings, but carry state between the app and
/// its keyboard extension.
///
/// The context is used by both ``DictationService`` as well
/// as ``KeyboardDictationService``. Use an initializer that
/// fits your needs, as described in <doc:Dictation-Article>.
///
/// The ``dictatedText`` property is updated while dictation
/// is performed, together with many other properties, which
/// are used by the dictation services.
///
/// The ``silenceLimit`` settings can be used to control how
/// long time a user can be silent before the dictation will
/// automatically wrap up.
///
/// The ``lastError`` can be set by a dictation service when
/// something goes wrong. You can observe this to handle any
/// errors for the user.
///
/// The ``returnToKeyboardFromAppError`` should be set if an
/// app can't navigate back to the keyboard. You can observe
/// it to add an arrow that points to the top-leading system
/// back button if this becomes `true`.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value.
///
/// > Important: KeyboardKit 9.0 will remove the manual data
/// persistency and replace it with @AppStorage.
public class DictationContext: ObservableObject {

    /// Create a dictation context instance.
    public init() {}


    // MARK: - Settings

    /// The settings key prefix to use for this namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "dictation")
    }

    /// The max number of seconds of silence after which the
    /// dictation operation will automatically finish.
    ///
    /// Stored in ``Foundation/UserDefaults/keyboardSettings``.
    @AppStorage("\(settingsPrefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit: TimeInterval = 5.0


    // MARK: - Persisted State

    /// This store to use for persisted dictation data.
    ///
    /// This uses the same store as ``KeyboardSettings``, so
    /// that settings and dictation state are persisted into
    /// the same store.
    static var peristentStore: UserDefaults {
        KeyboardSettings.store
    }

    /// The currently dictated text, which will update while
    /// dictation detects new text.
    ///
    /// This text can be observed from your app, and will be
    /// automatically synced between an app and its keyboard.
    @AppStorage("\(settingsPrefix)dictatedText", store: peristentStore)
    public var dictatedText = ""

    /// The bundle ID of the app that is using the keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app navigate back to the keyboard.
    @AppStorage("\(settingsPrefix)hostApplicationBundleId", store: peristentStore)
    public var hostApplicationBundleId: String?

    /// Whether dictation has been started by a keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app start dictation if it cannot use deep links.
    @AppStorage("\(settingsPrefix)isDictationStartedByKeyboard", store: peristentStore)
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
