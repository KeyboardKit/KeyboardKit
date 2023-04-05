//
//  DisabledKeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This disabled service can be used as a placeholder when you
 don't have access to a real dictation service.

 KeyboardKit Pro unlocks a ``StandardDictationService`` plus
 a ``StandardKeyboardDictationService`` when a valid license
 is registered.
 */
public class DisabledKeyboardDictationService: KeyboardDictationService {

    public init(context: DictationContext) {
        self.context = context
    }

    private let context: DictationContext
}

public extension DisabledKeyboardDictationService {

    var authorizationStatus: DictationAuthorizationStatus {
        .disabledService
    }

    func requestDictationAuthorization() async throws -> DictationAuthorizationStatus {
        authorizationStatus
    }

    func startDictationFromKeyboard(
        with config: KeyboardDictationConfiguration
    ) async throws {
        resetContext()
    }

    func performDictationInApp(
        with config: KeyboardDictationConfiguration
    ) async throws {
        resetContext()
    }

    func abortDictationInApp() async throws {
        resetContext()
    }

    func stopDictationInKeyboard() async throws {
        resetContext()
    }

    func undoLastDictation() {}
}

private extension DisabledKeyboardDictationService {

    func resetContext() {
        withAnimation {
            context.reset()
        }
    }
}
