//
//  Dictation+DisabledDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension DictationService where Self == Dictation.DisabledDictationService {

    /// Create a ``Dictation/DisabledDictationService`` instance.
    static var disabled: Self {
        Dictation.DisabledDictationService(context: .preview)
    }

    /// Create a ``Dictation/DisabledDictationService`` instance.
    static func disabled(
        context: DictationContext
    ) -> Self {
        Dictation.DisabledDictationService(
            context: context
        )
    }
}

public extension Dictation {
    
    /// This class is used as the default service, until you
    /// register a custom implementation or register a valid
    /// KeyboardKit Pro license key.
    ///
    /// This service can also be resolved with the shorthand
    /// ``DictationService/disabled``.
    class DisabledDictationService: DictationService {

        public init(context: DictationContext) {
            self.context = context
        }

        
        public let context: DictationContext

        open var authorizationStatus: Dictation.AuthorizationStatus {
            .disabledService
        }

        open var supportedLocales: [Locale] { [] }


        open func startDictationFromKeyboard() async throws {
            resetContext()
        }

        open func startDictationInApp() async throws {
            resetContext()
        }

        open func abortDictationInApp() async throws {
            resetContext()
        }

        open func finishDictationInApp() async throws {
            resetContext()
        }

        open func returnToKeyboardFromApp() throws {}

        open func handleDictationResultInKeyboard() async throws {
            resetContext()
        }

        open func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
            authorizationStatus
        }

        open func undoLastDictation() {}
    }
}

private extension Dictation.DisabledDictationService {

    func resetContext() {
        DispatchQueue.main.async { [weak self] in
            self?.context.reset()
        }
    }
}
