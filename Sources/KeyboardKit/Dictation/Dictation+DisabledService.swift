//
//  Dictation+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Dictation {
    
    /// This service can be used to disable dictation.
    class DisabledService: DictationService {
        
        public init() {}
    }
}

public extension Dictation.DisabledService {

    var authorizationStatus: Dictation.AuthorizationStatus {
        .disabledService
    }

    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        authorizationStatus
    }

    func resetDictationResult() async throws {}

    func startDictation(with config: Dictation.Configuration) async throws {
        throw Dictation.ServiceError.disabledService
    }

    func stopDictation() async throws {
        throw Dictation.ServiceError.disabledService
    }
}

public extension DictationService where Self == Dictation.DisabledService {
    
    /// This service can be used to disable dictation.
    static func disabled(
        context: DictationContext
    ) -> DictationService {
        Dictation.DisabledService()
    }
}
