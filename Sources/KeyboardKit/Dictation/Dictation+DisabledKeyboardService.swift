//
//  Dictation+DisabledKeyboardService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Dictation {
    
    /// This class is used as the default service, until you
    /// register a custom implementation or register a valid
    /// KeyboardKit Pro license key.
    ///
    /// See <doc:Dictation-Article> for more information.
    class DisabledKeyboardService: KeyboardDictationService {
        
        public init(context: DictationContext) {
            self.context = context
        }
        
        private let context: DictationContext
    }
}

public extension Dictation.DisabledKeyboardService {

    var authorizationStatus: Dictation.AuthorizationStatus {
        .disabledService
    }
    
    var supportedLocales: [KeyboardLocale] { [] }

    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        authorizationStatus
    }

    func startDictationFromKeyboard(
        with config: Dictation.KeyboardConfiguration
    ) async throws {
        resetContext()
    }

    func performDictationInApp(
        with config: Dictation.KeyboardConfiguration
    ) async throws {
        resetContext()
    }

    func abortDictationInApp() async throws {
        resetContext()
    }

    func finishDictationInApp() async throws {
        resetContext()
    }

    func handleDictationResultInKeyboard() async throws {
        resetContext()
    }

    func undoLastDictation() {}
}

public extension KeyboardDictationService where Self == Dictation.DisabledKeyboardService {
    
    /// This service can be used to disable dictation.
    static func disabled(
        context: DictationContext
    ) -> KeyboardDictationService {
        Dictation.DisabledKeyboardService(
            context: context
        )
    }
}

private extension Dictation.DisabledKeyboardService {

    func resetContext() {
        withAnimation {
            context.reset()
        }
    }
}
