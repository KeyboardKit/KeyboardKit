//
//  Dictation+DisabledService.swift
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
    class DisabledService: DictationService {
        
        public init() {}

        open var authorizationStatus: Dictation.AuthorizationStatus {
            .disabledService
        }

        open var supportedLocales: [KeyboardLocale] { [] }

        open func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
            authorizationStatus
        }

        open func resetDictationResult() async throws {}

        open func startDictation(
            with config: Dictation.Configuration
        ) async throws {
            throw Dictation.ServiceError.disabledService
        }

        open func stopDictation() async throws {
            throw Dictation.ServiceError.disabledService
        }
    }
}

public extension DictationService where Self == Dictation.DisabledService {
    
    /// This service can be used to disable dictation.
    static var disabled: DictationService {
        Dictation.DisabledService()
    }
}
