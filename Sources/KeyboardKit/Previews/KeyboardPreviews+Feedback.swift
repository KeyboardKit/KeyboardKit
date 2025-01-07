//
//  Previews+Feedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-19.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension KeyboardFeedbackService where Self == KeyboardFeedback.DisabledFeedbackService {

    static var preview: Self {
        KeyboardFeedback.DisabledFeedbackService()
    }
}
