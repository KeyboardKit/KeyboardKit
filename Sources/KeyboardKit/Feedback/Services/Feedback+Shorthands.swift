//
//  Feedback+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension FeedbackService where Self == Feedback.DisabledService {

    /// Create a disabled feedback service.
    static var disabled: Self {
        Feedback.DisabledService()
    }
}

public extension FeedbackService where Self == Feedback.StandardService {

    /// Create a standard feedback service.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - baseService: The base service to use, by default a ``Feedback/BaseService``.
    ///   - localizedServices: A list of localized services, by default `empty`.
    ///   - feedbackService: The feedback service to use.
    static var standard: Self {
        Feedback.StandardService()
    }
}
