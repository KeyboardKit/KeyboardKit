//
//  DisabledKeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This service can be used to disable keyboard dictation.
 */
public class DisabledKeyboardDictationService: KeyboardDictationService {

    public init(context: DictationContext) {
        self.context = context
    }

    private let context: DictationContext
}

public extension DisabledKeyboardDictationService {

    var authorizationStatus: Dictation.AuthorizationStatus {
        .disabledService
    }

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

public extension KeyboardDictationService where Self == DisabledKeyboardDictationService {
    
    /// This service can be used to disable dictation.
    static func disabled(
        context: DictationContext
    ) -> KeyboardDictationService {
        DisabledKeyboardDictationService(
            context: context
        )
    }
}

private extension DisabledKeyboardDictationService {

    func resetContext() {
        withAnimation {
            context.reset()
        }
    }
}
