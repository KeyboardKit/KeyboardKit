//
//  Previews+Feedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension FeedbackService where Self == Feedback.DisabledFeedbackService {

    static var preview: Self {
        Feedback.DisabledFeedbackService()
    }
}
