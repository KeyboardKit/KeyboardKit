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
    /// This service can also be resolved with the shorthand
    /// ``KeyboardDictationService/disabled(context:)``.
    ///
    /// See <doc:Dictation-Article> for more information.
    class DisabledKeyboardService: DisabledService, KeyboardDictationService {

        public init(context: DictationContext) {
            self.context = context
        }
        
        private let context: DictationContext

        open func startDictationFromKeyboard(
            with config: Dictation.KeyboardConfiguration
        ) async throws {
            resetContext()
        }

        open func performDictationInApp(
            with config: Dictation.KeyboardConfiguration
        ) async throws {
            resetContext()
        }

        open func abortDictationInApp() async throws {
            resetContext()
        }

        open func finishDictationInApp() async throws {
            resetContext()
        }

        open func handleDictationResultInKeyboard() async throws {
            resetContext()
        }

        open func undoLastDictation() {}
    }
}

private extension Dictation.DisabledKeyboardService {

    func resetContext() {
        DispatchQueue.main.async { [weak self] in
            self?.context.reset()
        }
    }
}
