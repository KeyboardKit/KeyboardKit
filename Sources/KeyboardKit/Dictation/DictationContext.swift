//
//  DictationContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
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
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class DictationContext: ObservableObject {

    /// Create a dictation context instance.
    public init() {
        settings = .init()
        dictatedText = settings.dictatedText
    }


    // MARK: - Settings

    /// Dictation-specific, auto-persisted settings.
    @Published public var settings: DictationSettings


    // MARK: - Published Properties
    
    /// The currently dictated text, which will auto-persist.
    @Published public var dictatedText: String = "" {
        didSet { settings.dictatedText = dictatedText }
    }

    /// Whether dictation is currently in progress.
    @Published public var isDictating = false

    /// The last applied dictation error.
    @Published public var lastError: Error?

    /// The last inserted dictated text.
    @Published public var lastInsertedText: String?

    /// The last navigate back error.
    @Published public var returnToKeyboardFromAppError: Error?

    /// A strong reference to the current dictation service.
    public var service: DictationService?
}


// MARK: - Settings-Backed Properties

public extension DictationContext {
    
    /// The bundle ID of the app that is using the keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app navigate back to the keyboard.
    var hostApplicationBundleId: String? {
        get { settings.hostApplicationBundleId }
        set { settings.hostApplicationBundleId = newValue }
    }

    /// Whether dictation has been started by a keyboard.
    ///
    /// This is automatically set by the keyboard to let the
    /// main app start dictation if it cannot use deep links.
    var isDictationStartedByKeyboard: Bool {
        get { settings.isDictationStartedByKeyboard }
        set { settings.isDictationStartedByKeyboard = newValue }
    }
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
