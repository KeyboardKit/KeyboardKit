//
//  DisabledDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This disabled service can be used as a placeholder when you
 don't have access to a real dictation service.
 */
public class DisabledDictationService: DictationService {

    public init() {}
}

public extension DisabledDictationService {

    var authorizationStatus: DictationAuthorizationStatus {
        .disabledService
    }

    func requestDictationAuthorization() async throws -> DictationAuthorizationStatus {
        authorizationStatus
    }

    func resetDictationResult() async throws {}

    func startDictation(with config: DictationConfiguration) async throws {
        throw DictationServiceError.disabledService
    }

    func stopDictation() async throws {
        throw DictationServiceError.disabledService
    }
}
