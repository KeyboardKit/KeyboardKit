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
        Dictation.DisabledDictationService()
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

        @available(*, deprecated, message: "This class no longer requires a context")
        public init(context: DictationContext) {}
        
        public init() {}
        
        public typealias AuthStatus = Dictation.AuthorizationStatus

        public var context: DictationContext { .preview }
        
        private let authStatus = AuthStatus.disabledService

        open var authorizationStatus: AuthStatus { authStatus }
        open var supportedLocales: [Locale] { [] }

        open func startDictationFromKeyboard() async throws {}
        open func startDictationInApp() async throws {}
        open func abortDictationInApp() async throws {}
        open func finishDictationInApp() async throws {}
        open func returnToKeyboardFromApp() throws {}
        open func handleDictationResultInKeyboard() async throws {}
        open func requestDictationAuthorization() async throws -> AuthStatus { authStatus }
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
